using Quartz;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;

namespace Calicomp
{
    public class EmailJob : IJob
    {
        public void Execute(IJobExecutionContext context)
        {
            JobDataMap dataMap = context.JobDetail.JobDataMap;
            //string sender = dataMap.GetString("sender");
            string recepient = dataMap.GetString("recepient");
            string dt = dataMap.GetString("date");

            using (var message = new MailMessage("tempgarbo@gmail.com", recepient))
            {
                message.Subject = "CALICOMP AUTOMATED SHIFT REMINDER";
                message.Body = "Hello your shift is at " + dt + ". View your account for more info";
                using (SmtpClient client = new SmtpClient
                {
                    EnableSsl = true,
                    Host = "smtp.gmail.com",
                    Port = 587,
                    Credentials = new NetworkCredential("tempgarbo@gmail.com", "brandonbutler")
                })
                {
                    client.Send(message);
                }
            }
        }

    }
}