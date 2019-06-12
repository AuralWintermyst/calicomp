using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Calicomp
{
    public partial class LeaveApplication : System.Web.UI.Page
    {
        Database_Control dc = new Database_Control();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void submitleave_Click(object sender, EventArgs e)
        {
            int checker;
            string get_id = Request.QueryString["StaffID"].ToString();
            string get_type = Request.QueryString["Type"].ToString();
            int id = int.Parse(get_id);
            string leave_type = leavetype.SelectedValue.ToString();
            string remarks = remark.Value.ToString();
            string number = duration.Value.ToString();
            int days = int.Parse(number);
            string dt = datepicker.Value.ToString();
            DateTime date = Convert.ToDateTime(dt);
            string enddate = date.AddDays(days).ToShortDateString();
            string parse_enddate = DateTime.ParseExact(enddate, "d/M/yyyy", null).ToString("MM/dd/yyyy");
            //Response.Write("<script>alert('" + parse + "')</script>");
            string filename = Path.GetFileName(fileupload.PostedFile.FileName);
            string type = fileupload.PostedFile.ContentType;
            using (Stream fs = fileupload.PostedFile.InputStream)
            {
                using (BinaryReader br = new BinaryReader(fs))
                {
                    byte[] evidence = br.ReadBytes((Int32)fs.Length);
                    checker = dc.submit_leave(id,leave_type,dt,parse_enddate,evidence,"Pending",remarks,filename,type);
                }
            }
            if(checker == 1)
            {
                Response.Write("<script>alert('Leave in conflict with other dates')</script>");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "checkoutalart",
            "alert('Leave Sent! ');window.location ='ClockinMenu.aspx?StaffID=" + get_id + "&Type=" + get_type + "' ;",
            true);
            }
        }
    }
}