using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Calicomp
{
    public partial class MasterPage1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void home_ServerClick(object sender, EventArgs e)
        {
            string get_id = Request.QueryString["StaffID"].ToString();
            string get_type = Request.QueryString["Type"].ToString();
            if (get_type.Equals("Manager"))
            {
                Response.Redirect("managerHome.aspx?StaffID=" + get_id +"&Type=" + get_type);
            }
            else
            {
                Response.Redirect("ClockinMenu.aspx?StaffID=" + get_id + "&Type=" + get_type);
            }
        }

        protected void profile_ServerClick(object sender, EventArgs e)
        {
            string get_id = Request.QueryString["StaffID"].ToString();
            string get_type = Request.QueryString["Type"].ToString();
            if (get_type.Equals("Manager"))
            {
                Response.Redirect("managerProfile.aspx?StaffID=" + get_id + "&Type=" + get_type);
            }
            else
            {
                Response.Redirect("empProfile.aspx?StaffID=" + get_id + "&Type=" + get_type);
            }
        }
    }
}