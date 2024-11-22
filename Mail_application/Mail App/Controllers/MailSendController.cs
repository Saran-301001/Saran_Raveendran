using app.Models;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using System.IO;
using System.Net;
using System.Net.Mail;


using APP.Models;

namespace app.Controllers;

public class MailSendController : Controller
{

    public IActionResult Index()
    {
        return View();
    }

    [HttpPost]

    public IActionResult Index(APP.Models.EmailModel Model)
    {
        Console.WriteLine(Model.Email);
        Console.WriteLine(Model.To);
        using (MailMessage Msg = new MailMessage(Model.Email, Model.To))
        {

            //using (MailMessage Msg = new MailMessage(Model.Email, Model.To)){
            Msg.Subject = Model.Subject;
            Msg.Body = Model.Body;

            if (Model.Attachment.Length > 0)
            {
                string fileName = Path.GetFileName(Model.Attachment.FileName);

                Msg.Attachments.Add(new Attachment(Model.Attachment.OpenReadStream(), fileName));
            }

            Msg.IsBodyHtml = false;
            using (SmtpClient smtp = new SmtpClient())
            {

                smtp.EnableSsl = true;
                NetworkCredential Credentials = new NetworkCredential(Model.Email, Model.Password);
                smtp.UseDefaultCredentials = false;
                smtp.Credentials = Credentials;
                // smtp.Host = "smtpout.secureserver.net";
                smtp.Host = "smtp.gmail.com";
                smtp.Port = 587;
                //smtp.Port = 465;
                Console.WriteLine("Port is Working");
                try
                {
                    smtp.Send(Msg);
                    ViewBag.Message = "Email send Sucessfully.";
                }

                catch (System.Net.Mail.SmtpException smtpexception)
                {
                    Console.WriteLine(smtpexception.Message);

                }
                catch (Exception smtperror)
                {
                    Console.WriteLine(smtperror.Message);
                }
            }
        }

        return View();
    }
}