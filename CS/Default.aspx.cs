using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void OrderDetailsGridView_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e) {
        if(e.Parameters == "MakeVisible") {
            ASPxGridView grid = (ASPxGridView)sender;
            
            object key = GetKeyValue();
            int visibleIndex = grid.FindVisibleIndexByKeyValue(key);

            grid.MakeRowVisible(key);
            grid.ScrollToVisibleIndexOnClient = visibleIndex;
            grid.FocusedRowIndex = visibleIndex;
        }
    }

    object GetKeyValue() {
        return ASPxComboBox1.Value; // Returns composite key ("OrderID|ProductID") of the data row
                                    // Use "|" to separate keys (for example - "10564|17")
    }
}