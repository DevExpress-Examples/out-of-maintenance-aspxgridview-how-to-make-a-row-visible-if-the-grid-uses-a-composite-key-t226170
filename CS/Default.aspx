<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.17.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Make row visible (client and server side)</title>
    <script>
        keyToSearch = "";

        function MakeVisibleClient(s, e) {
            var key = "";
            keyToSearch = cmb1.GetValue();
            if (keyToSearch != null) {
                var visibleIndex = grid.GetTopVisibleIndex();
                while (key != null) {
                    key = grid.GetRowKey(visibleIndex);
                    if (key == keyToSearch) {
                        ShowRow(visibleIndex);
                        return;
                    }
                    visibleIndex++;
                }
            } else {
                alert("Please select value from the combo box!");
                return;
            }

            alert("No such entry on this page. Client search supports only single page search. Please go to another page of the grid and perform search again.");
        };

        function MakeVisibleServer(s, e) {
            if (cmb1.GetValue() != null) {
                grid.PerformCallback("MakeVisible");
            } else {
                alert("Please select value from the combo box!");
            }
        };

        function ShowRow(index) {
            grid.MakeRowVisible(index);
            grid.SetFocusedRowIndex(index);
        };
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin: 20px 0;">
            <dx:ASPxButton ID="GetNRowButtonClient" runat="server" Text="Show row (Client)" AutoPostBack="false">
                <ClientSideEvents Click="MakeVisibleClient" />
            </dx:ASPxButton>

            <dx:ASPxButton ID="GetNRowButtonServer" runat="server" Text="Show row (Server)" AutoPostBack="false">
                <ClientSideEvents Click="MakeVisibleServer" />
            </dx:ASPxButton>
        </div>

        <div style="margin: 20px 0;">
            <dx:ASPxLabel ID="SearchLabel" runat="server" Text="Choose Entry to show in the grid:"></dx:ASPxLabel>
            <dx:ASPxComboBox ID="ASPxComboBox1" ClientInstanceName="cmb1" runat="server" ValueField="KeyValue"
                DataSourceID="OrderDetailsSearchDataSource"
                TextFormatString="{0}|{1}">
                <Columns>
                    <dx:ListBoxColumn FieldName="OrderID" />
                    <dx:ListBoxColumn FieldName="ProductID" />
                </Columns>
            </dx:ASPxComboBox>
        </div>


        <dx:ASPxGridView ID="OrderDetailsGridView" runat="server"
            ClientInstanceName="grid"
            AutoGenerateColumns="False"
            DataSourceID="OrderDetailsDataSource"
            KeyFieldName="OrderID;ProductID"
            OnCustomCallback="OrderDetailsGridView_CustomCallback"
            Width="670px">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="OrderID" ReadOnly="True" VisibleIndex="0" Width="80px"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ProductID" ReadOnly="True" VisibleIndex="1" Width="80px"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ProductName" VisibleIndex="2" Width="150px"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="UnitPrice" VisibleIndex="3" Width="100px"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Quantity" VisibleIndex="4" Width="80px"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Discount" VisibleIndex="5" Width="80px"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ExtendedPrice" VisibleIndex="6" Width="100px"></dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="100"></SettingsPager>
            <Settings VerticalScrollBarMode="Visible" />
            <SettingsBehavior AllowFocusedRow="true" />
        </dx:ASPxGridView>

        <asp:SqlDataSource ID="OrderDetailsDataSource" runat="server"
            ConnectionString='<%$ ConnectionStrings:NorthwindConnectionString %>'
            SelectCommand="SELECT * FROM [Order Details Extended]"></asp:SqlDataSource>

        <asp:SqlDataSource ID="OrderDetailsSearchDataSource" runat="server"
            ConnectionString='<%$ ConnectionStrings:NorthwindConnectionString %>'
            SelectCommand="SELECT OrderID, ProductID, convert(NVARCHAR, [OrderID]) + '|' + convert(NVARCHAR, [ProductID]) as KeyValue FROM [Order Details Extended] WHERE ([Quantity] > @Quantity)">
            <SelectParameters>
                <asp:Parameter DefaultValue="60" Name="Quantity" Type="Int16"></asp:Parameter>
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
