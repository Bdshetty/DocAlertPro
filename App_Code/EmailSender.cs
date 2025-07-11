using System.Net;
using System.Net.Mail;
using System.IO;

public class EmailSender
{
    public static void SendEmail(string toEmail, string subject, string body, string attachmentPath = null)
    {
        MailMessage message = new MailMessage();
        message.To.Add(toEmail);
        message.Subject = subject;
        message.Body = body;
        message.IsBodyHtml = true;
        message.From = new MailAddress("phoenixeco2@gmail.com");

        if (!string.IsNullOrEmpty(attachmentPath) && File.Exists(attachmentPath))
        {
            Attachment attachment = new Attachment(attachmentPath);
            message.Attachments.Add(attachment);
        }

        SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
        smtp.EnableSsl = true;
        smtp.Credentials = new NetworkCredential("phoenixeco2@gmail.com", "mqrw qbcm rzpc bsac");
        smtp.Send(message);
    }
}
