using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Calicomp
{
    public partial class ViewLeave : System.Web.UI.Page
    {
        Database_Control dc = new Database_Control();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void DownloadFile(object sender, EventArgs e)
        {
            int id = int.Parse((sender as LinkButton).CommandArgument);

            Tuple<string, string, byte[]> getValue = dc.getFile(id);

            Response.Clear();
            Response.Buffer = true;
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = getValue.Item2;
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + getValue.Item1);
            Response.BinaryWrite(getValue.Item3);
            Response.Flush();
            Response.End();

        }

        protected void ApproveLeave(object sender, EventArgs e)
        {
            //string get_id = Request.QueryString["StaffID"].ToString();
            //string get_type = Request.QueryString["Type"].ToString();

            int id = int.Parse((sender as LinkButton).CommandArgument);
            LinkButton link = (LinkButton)sender;

            GridViewRow row = (GridViewRow)link.NamingContainer;
            string status = row.Cells[5].Text;

            if (status.Equals("Pending"))
            {
                dc.approve_leave(id);
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "checkoutalart",
                //        "alert('Status updated successfully! ');window.location ='viewLeave.aspx?StaffID=" + get_id + "&Type=" + get_type + "' ;",
                //        true);
                Response.Write("<script>alert('Status updated successfully')</script>");
            }
            else
            {
                Response.Write("<script>alert('Status already updated')</script>");
            }
        }

        protected void RejectLeave(object sender, EventArgs e)
        {
            //string get_id = Request.QueryString["StaffID"].ToString();
            //string get_type = Request.QueryString["Type"].ToString();

            int id = int.Parse((sender as LinkButton).CommandArgument);
            LinkButton link = (LinkButton)sender;

            GridViewRow row = (GridViewRow)link.NamingContainer;
            string status = row.Cells[5].Text;

            if (status.Equals("Pending"))
            {
                dc.reject_leave(id);
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "checkoutalart",
                //        "alert('Status updated successfully! ');window.location ='viewLeave.aspx?StaffID=" + get_id + "&Type=" + get_type + "' ;",
                //        true);
                Response.Write("<script>alert('Status updated successfully')</script>");
            }
            else
            {
                Response.Write("<script>alert('Status already updated')</script>");
            }
        }

        protected void GridView1_PreRender(object sender, EventArgs e)
        {
            if (GridView1.Rows.Count > 0)
                GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }
}