using app.Models;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using Microsoft.EntityFrameworkCore;
using APP.Models;
using PasswordGenerator;

namespace app.Controllers;

public class Chatcontroller : Controller
{

    private readonly ApplicationDbContext _database;



    public Chatcontroller(ApplicationDbContext database)
    {
        _database = database;
    }


    public IActionResult Index()
    {
        if (!String.IsNullOrEmpty(HttpContext.Session.GetString("session")))
        {
            ViewBag.user = HttpContext.Session.GetString("session");
            var employeedata = _database.EmployeeData.ToList();
            DataTable Details = AdminConnection.Details();
            return View(Details);
        }
        return RedirectToAction("Signin", "Home");
    }

    public IActionResult Chat(string id)
    {
        if (!String.IsNullOrEmpty(HttpContext.Session.GetString("session")))
        {
            
              Console.WriteLine(id);
              ViewBag.chat = id;
            // var Email = id;
            // var profile = _database.EmployeeData.Find(Email);
            return View();
            
        }
        return RedirectToAction("Signin", "Home");
    }


    [HttpPost]

    public IActionResult Chat(ChatData chatData)
    {
        if (!String.IsNullOrEmpty(HttpContext.Session.GetString("session")))
        {
            Console.WriteLine("Chat Mail " + chatData.Email);
            Console.WriteLine(chatData.Content);
            _database.Chat.Add(chatData);
            _database.SaveChanges();
            return View();
        }
        return RedirectToAction("Signin", "Home");
    }
}

