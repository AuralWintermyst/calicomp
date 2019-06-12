using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Calicomp
{
    public partial class empViewPayroll : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void refresh_Click(object sender, EventArgs e)
        {
            string dt = datepicker.Value.ToString();
            DateTime date = Convert.ToDateTime(dt);
            SqlDataSource1.SelectParameters["Date_checker"].DefaultValue = dt;
            GridView1.DataBind();
        }

        protected void GridView1_PreRender(object sender, EventArgs e)
        {
            if (GridView1.Rows.Count > 0)
                GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }
}