using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;

namespace Calicomp
{
    public partial class managerHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Chart1.DataBind();
        }

        //protected void refresh_Click(object sender, EventArgs e)
        //{
        //    ////string id = inputStaff.SelectedValue.ToString();
        //    //string dt = datepicker.Value.ToString();
        //    ////Response.Write("<script>alert('" + dt + "')</script>");
        //    //DateTime date = Convert.ToDateTime(dt);
        //    ////SqlDataSource2.SelectParameters["Staff_ID"].DefaultValue = id;
        //    //SqlDataSource2.SelectParameters["Date"].DefaultValue = dt;
        //    //Chart1.DataBind();
        //}

        protected void GridView1_PreRender(object sender, EventArgs e)
        {
            if (GridView1.Rows.Count > 0) 
                GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        protected void GridView2_PreRender(object sender, EventArgs e)
        {
            if (GridView1.Rows.Count > 0)
                GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }
}