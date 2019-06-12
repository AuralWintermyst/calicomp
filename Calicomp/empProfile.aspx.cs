using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Calicomp
{
    public partial class empProfile : System.Web.UI.Page
    {
        Database_Control dc = new Database_Control();
        protected void Page_Load(object sender, EventArgs e)
        {
            string get_id = Request.QueryString["StaffID"].ToString();
            int id = int.Parse(get_id);
            DataTable dt = dc.viewProfile(id);
            firstName.Text = dt.Rows[0]["First_Name"].ToString();
            lastName.Text = dt.Rows[0]["Last_Name"].ToString();
            email.Text = dt.Rows[0]["Email"].ToString();
            phonenum.Text = dt.Rows[0]["Phone_No"].ToString();
            address.Text = dt.Rows[0]["Address"].ToString();
            type.Text = dt.Rows[0]["Type"].ToString();
            Payrate.Text = dt.Rows[0]["Pay_Rate"].ToString();
        }

        protected void logout_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        protected void changepw_Click(object sender, EventArgs e)
        {
            string get_id = Request.QueryString["StaffID"].ToString();
            string get_type = Request.QueryString["Type"].ToString();
            int id = int.Parse(get_id);

            string oldpass = oldpw.Value.ToString();
            string newpass = newpw.Value.ToString();
            int checker = dc.changepw(id, oldpass, newpass);

            if (checker == 1)
            {
                Response.Write("<script>alert('Password does not match.')</script>");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "checkoutalart",
                            "alert('Change password successfull! ');window.location ='ClockinMenu.aspx?StaffID=" + get_id + "&Type=" + get_type + "' ;",
                            true);
            }
        }
    }
}