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
    public partial class GeneratePayroll : System.Web.UI.Page
    {
        decimal salary = (decimal)0.0;
        Database_Control dc = new Database_Control();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void refresh_Click(object sender, EventArgs e)
        {
            string id = inputStaff.SelectedValue.ToString();
            string dt = datepicker.Value.ToString();
            //Response.Write("<script>alert('" + dt + "')</script>");
            DateTime date = Convert.ToDateTime(dt);
            SqlDataSource2.SelectParameters["Staff_ID"].DefaultValue = id;
            SqlDataSource2.SelectParameters["Date_checker"].DefaultValue = dt;
            GridView1.DataBind();
        }

        protected void submit_salary_Click(object sender, EventArgs e)
        {
            string get_id = Request.QueryString["StaffID"].ToString();
            string get_type = Request.QueryString["Type"].ToString();

            string id = inputStaff.SelectedValue.ToString();
            string getfooter = GridView1.FooterRow.Cells[5].Text;
            decimal amount = decimal.Parse(getfooter, System.Globalization.NumberStyles.Currency);
            int convertid = int.Parse(id);
            string dt = datepicker.Value.ToString();
            DateTime date = Convert.ToDateTime(dt);
            dc.save_payroll(convertid, date, amount);

            int id_convert = int.Parse(id);
            string email = dc.getemail(id_convert);
            using (var message = new MailMessage("tempgarbo@gmail.com", email))
            {
                message.Subject = "CALICOMP SALARY NOTIFICATION";
                message.Body = "Salary: RM" + amount;
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
                        "alert('Saving payroll successfull! ');window.location ='managerHome.aspx?StaffID=" + get_id + "&Type=" + get_type + "' ;",
                        true);
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                    salary += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Total"));
            }
            else if (e.Row.RowType == DataControlRowType.Footer)
            {
                e.Row.Cells[5].Text = String.Format("{0:c}", salary);
            }
        }

        protected void GridView1_PreRender(object sender, EventArgs e)
        {
            if (GridView1.Rows.Count > 0)
                GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }
}