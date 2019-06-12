using Quartz;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Calicomp
{
    public partial class AssignShift : System.Web.UI.Page
    {
        Database_Control dc = new Database_Control();
        int recepient;
        string parse;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GridView1.Rows[e.RowIndex];
            DropDownList ddl = row.FindControl("DropDownList1") as DropDownList;
            string dt = row.Cells[3].Text;
            int shiftid = (int)GridView1.DataKeys[e.RowIndex].Value;

            parse = DateTime.ParseExact(dt, "dd/MM/yyyy", null).ToString("MM/dd/yyyy");
            SqlDataSource2.UpdateParameters.Add("Date_checker", parse);
            string getid = ddl.SelectedValue.ToString();
            if (!string.IsNullOrEmpty(getid))
            {
                recepient = int.Parse(getid);
            }
            
        }

        protected void SqlDataSource2_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows < 0)
            {
                Response.Write("<script>alert('User unavailable on that date')</script>");
                //Response.Write("<script>alert('"+parse+"')</script>");
            }
            else if (recepient != 0)
            {
                string email = dc.getemail(recepient);
                JobScheduler.Start(email, parse);
                Response.Write("<script>alert('User successfully assigned!')</script>");
            }
        }

        protected void automate_Click(object sender, EventArgs e)
        {
            string get_id = Request.QueryString["StaffID"].ToString();
            string get_type = Request.QueryString["Type"].ToString();

            string constraint = time_constraint.Value.ToString();
            int hours = int.Parse(constraint);

            string number = duration.Value.ToString();
            int days = int.Parse(number);
            string dt = datepicker.Value.ToString();

            DateTime date = Convert.ToDateTime(dt);
            string enddate = date.AddDays(days).ToShortDateString();
            string parse_enddate = DateTime.ParseExact(enddate, "d/M/yyyy", null).ToString("MM/dd/yyyy");

            dc.automate_shift(dt, parse_enddate, hours);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "checkoutalart",
"alert('Assignment Successfull! ');window.location ='AssignShift.aspx?StaffID=" + get_id + "&Type=" + get_type + "' ;",
true);
        }

        protected void GridView1_PreRender(object sender, EventArgs e)
        {
            if (GridView1.Rows.Count > 0)
                GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            this.DataBind();
        }
    }
}