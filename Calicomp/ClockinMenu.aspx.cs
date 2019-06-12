using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Calicomp
{
    public partial class ClockinMenu : System.Web.UI.Page
    {
        Database_Control dc = new Database_Control();
        protected void Page_Load(object sender, EventArgs e)
        {
            string date = DateTime.Now.ToString();
            DateTime convert = Convert.ToDateTime(date);

            SqlDataSource1.SelectParameters["Date_checker"].DefaultValue = date;

        }

        protected void clockinButton_Click(object sender, EventArgs e)
        {
            string get_staffid = Request.QueryString["StaffID"].ToString();
            int staffid = int.Parse(get_staffid);
            string get_shift = inputShift.SelectedValue.ToString();

            if (!string.IsNullOrEmpty(get_shift))
            {
                int shiftid = int.Parse(get_shift);

                string date = DateTime.Now.ToString();
                DateTime convert = Convert.ToDateTime(date);

                int checker = dc.timeclock(staffid, shiftid, convert);
                if(checker != 1)
                {
                    Response.Write("<script>alert('" + convert + "')</script>");
                }
                else
                {
                    Response.Write("<script>alert('Shift already clocked in')</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('No shift selected')</script>");
            }

        }

        protected void GridView1_PreRender(object sender, EventArgs e)
        {
            if (GridView1.Rows.Count > 0)
            {
                GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void clockoutButton_Click(object sender, EventArgs e)
        {
            string get_staffid = Request.QueryString["StaffID"].ToString();
            int staffid = int.Parse(get_staffid);
            string get_shift = inputShift.SelectedValue.ToString();

            if (!string.IsNullOrEmpty(get_shift))
            {
                int shiftid = int.Parse(get_shift);

                string date = DateTime.Now.ToString();
                DateTime convert = Convert.ToDateTime(date);

                int checker = dc.timeclockout(staffid, shiftid, convert);
                if (checker != 1)
                {
                    Response.Write("<script>alert('" + convert + "')</script>");
                }
                else
                {
                    Response.Write("<script>alert('Shift already clocked out')</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('No shift selected')</script>");
            }
        }
    }
}