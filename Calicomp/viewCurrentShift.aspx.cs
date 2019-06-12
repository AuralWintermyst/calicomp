using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Calicomp
{
    public partial class viewCurrentShift : System.Web.UI.Page
    {
        Database_Control dc = new Database_Control();
        protected void Page_Load(object sender, EventArgs e)
        {
            string get_id = Request.QueryString["StaffID"].ToString();
            int id = int.Parse(get_id);
            DataTable dt = dc.viewProfile(id);
            firstName.Text = dt.Rows[0]["First_Name"].ToString();
        }

        protected void GridView1_PreRender(object sender, EventArgs e)
        {
            if (GridView1.Rows.Count > 0)
                GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        protected void cancel_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string get_id = Request.QueryString["StaffID"].ToString();
            string get_type = Request.QueryString["Type"].ToString();
            string recepient = inputManager.SelectedValue.ToString();
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            string shift = row.Cells[1].Text;
            string date = row.Cells[4].Text;
            string start = row.Cells[2].Text;
            string end = row.Cells[3].Text;

            string msg = "Cancel " + shift + " at" + date + " from " + start + " to " + end;
            int id = int.Parse(get_id);
            dc.submit_msg(id, firstName.Text, msg);

            using (var message = new MailMessage("tempgarbo@gmail.com", recepient))
            {
                message.Subject = "CALICOMP STAFF REQUEST";
                message.Body = firstName.Text + " wants to cancel " + shift + " at " + date + " from " + start + " to " + end;
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
            "alert('Request Sent! ');window.location ='ClockinMenu.aspx?StaffID=" + get_id + "&Type=" + get_type + "' ;",
            true);
                }
            }
        }
    }
}