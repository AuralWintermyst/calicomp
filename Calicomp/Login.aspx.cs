using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Calicomp
{
    public partial class LoginPage : System.Web.UI.Page
    {
        Database_Control dc = new Database_Control();
        string constring = ConfigurationManager.ConnectionStrings["calicompConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            int flag = 0;
            string email = inputEmail.Value;
            string id = "";
            string type ="";
            string password = inputPassword.Value;
            DataTable dt = dc.View();

            foreach(DataRow row in dt.Rows)
            {
                if (email.Equals(row["Email"].ToString()) && password.Equals(row["Password"].ToString()))
                {
                    flag = 1;
                    type = row["Type"].ToString();
                    id = row["Staff_ID"].ToString();
                    break;
                }
            }

            if(flag == 1 && type.Equals("Manager"))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "checkoutalart",
"alert('Login Successfull!');window.location ='managerHome.aspx?StaffID=" + id+"&Type="+ type +"' ;",
true);

            }
            else if (flag == 1 && type.Equals("Employee"))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "checkoutalart",
"alert('Login Successfull! ');window.location ='clockinMenu.aspx?StaffID=" + id + "&Type=" + type + "' ;",
true);

            }
            else
            {
                Response.Write("<script>alert('Login Fail. Invalid username or password. Please try again.')</script>");
            }
        }


    }
}