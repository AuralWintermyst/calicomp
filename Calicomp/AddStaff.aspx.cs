using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Calicomp
{
    public partial class EmployerMenu : System.Web.UI.Page
    {
        Database_Control dc = new Database_Control();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void submitstaff_ServerClick(object sender, EventArgs e)
        {
            string get_id = Request.QueryString["StaffID"].ToString();
            string get_type = Request.QueryString["Type"].ToString();
            int checker = 0;
            string fname = firstName.Value.ToString();
            string lname = lastName.Value.ToString();
            string getemail = email.Value.ToString();
            string phoneno = phonenum.Value.ToString();
            string getaddress = address.Value.ToString();
            string parse = payrate.Value.ToString();
            decimal pay = decimal.Parse(parse);

            checker = dc.submit_staff(fname,lname,getemail,phoneno,getaddress,"123","Employee",pay);
            if(checker == 1)
            {
                Response.Write("<script>alert('Staff already exist.')</script>");
            }
            else
            {
                using (var message = new MailMessage("tempgarbo@gmail.com", getemail))
                {
                    message.Subject = "CALICOMP ACCOUNT ACTIVATION";
                    message.Body = "Hi " + fname + ". You are registered to Calicomp. " +
                        "Please <a href=\"http://localhost:50448/Login.aspx\">click here to activate account</a>. " +
                        "Your current password will be 123. You can change it later.";
                    message.IsBodyHtml = true;
                    using (SmtpClient client = new SmtpClient
                    {
                        EnableSsl = true,
                        Host = "smtp.gmail.com",
                        Port = 587,
                        Credentials = new NetworkCredential("tempgarbo@gmail.com", "brandonbutler")
                    })
                    {
                        client.Send(message);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "checkoutalart",
                            "alert('Add staff successfull! ');window.location ='managerHome.aspx?StaffID=" + get_id + "&Type=" + get_type + "' ;",
                            true);
                    }
                }  
            }
        }
    }
}