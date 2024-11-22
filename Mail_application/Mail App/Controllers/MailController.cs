using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using app.Models;
using System.Data.SqlClient;
using APP.Models;
using System.Data;


namespace app.Controllers;

public class MailController:Controller{


    public IActionResult Sentmail(){
        return View();
    }
}