using app.Models;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using Microsoft.EntityFrameworkCore;
using APP.Models;
using PasswordGenerator;

namespace app.Controllers;

public class EmployeeController : Controller
{

    private readonly ApplicationDbContext _database;



    public EmployeeController(ApplicationDbContext database)
    {
        _database = database;
    }


    public IActionResult Index()
    {
        if (!String.IsNullOrEmpty(HttpContext.Session.GetString("session")))
        {
            ViewBag.user = HttpContext.Session.GetString("session");
            return View();
        }
        return RedirectToAction("Signin", "Home");
    }


    public IActionResult EmployeeUpdate(string id)
    {
        if (!String.IsNullOrEmpty(HttpContext.Session.GetString("session")))
        {
            ViewBag.user = HttpContext.Session.GetString("session");
            Console.WriteLine(id);
            string Adminuser = id;
            var profile = _database.EmployeeData.Where(user => user.UserName == Adminuser).FirstOrDefault();
            return View(profile);

        }
        return RedirectToAction("Signin", "Home");
    }

    public IActionResult Viewprofile(){
        if (!String.IsNullOrEmpty(HttpContext.Session.GetString("session")))
        {
            return View();
        }
        return RedirectToAction("Signin", "Home");
    }
}