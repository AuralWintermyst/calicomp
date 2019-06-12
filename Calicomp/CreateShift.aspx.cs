using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Calicomp
{
    public partial class CreateShift : System.Web.UI.Page
    {
        Database_Control dc = new Database_Control();
        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable shifts = dc.View_Shifts();
            if (shifts.Rows.Count > 0)
            {
                GridView1.DataSource = shifts;
                GridView1.DataBind();
            }
            else
            {
                DataTable dt = new System.Data.DataTable();
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }

        protected void GridView1_PreRender(object sender, EventArgs e)
        {
            if (GridView1.Rows.Count > 0)
                GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        protected void submit_shift_ServerClick(object sender, EventArgs e)
        {
            string get_id = Request.QueryString["StaffID"].ToString();
            string get_type = Request.QueryString["Type"].ToString();

            string getdate = datepicker.Value.ToString();
            string shift = task.Value.ToString();
            string parsetime = startime.Value.ToString();
            
            DateTime dt = DateTime.ParseExact(parsetime,
                                    "HH:mm", CultureInfo.InvariantCulture);
            string parse = endtime.Value.ToString();
            int duration = int.Parse(parse);
            DateTime end = dt.AddHours(duration);
            string getstarttime = dt.ToString("h:mm tt");
            string getendtime = end.ToString("h:mm tt");
            //Response.Write("<script>alert('" + getstarttime + "')</script>");
            dc.create_shift(getdate,shift,getstarttime,getendtime,duration);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "checkoutalart",
"alert('Add shift successfull! ');window.location ='managerHome.aspx?StaffID=" + get_id + "&Type=" + get_type + "' ;",
true);
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            this.DataBind();
        }
    }
}