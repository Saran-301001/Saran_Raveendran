using app.Models;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using Microsoft.EntityFrameworkCore;
using APP.Models;
using PasswordGenerator;

namespace app.Controllers;

public class AdminController : Controller
{
    private readonly ApplicationDbContext _database;



    public AdminController(ApplicationDbContext database)
    {
        _database = database;
    }


    [HttpGet]
    public IActionResult Login(APP.Models.UserInput login)
    {
        return View(login);
    }

    public IActionResult generatepassword()
    {
        var pwd = new Password(includeLowercase: true, includeUppercase: true, includeNumeric: true, includeSpecial: true, passwordLength: 12);
        var password = pwd.Next();
        ViewBag.pass = password;
        Console.WriteLine("Create Password");
        Console.WriteLine(password);
        return View("CreateAccount");
    }

    public IActionResult Dashboard()
    {
        if (!String.IsNullOrEmpty(HttpContext.Session.GetString("session")))
        {
            ViewBag.user = HttpContext.Session.GetString("session");
            var employeedata = _database.EmployeeData.ToList();
            DataTable Details = AdminConnection.Details();
            Console.WriteLine(Details);
            return View(Details);
        }
        return RedirectToAction("Signin", "Home");
    }

    public IActionResult Index(APP.Models.UserInput login)
    {
        if (!String.IsNullOrEmpty(HttpContext.Session.GetString("session")))
        {
            ViewBag.user = HttpContext.Session.GetString("session");
            return View();
        }
        return RedirectToAction("Signin", "Home");

    }

    [HttpGet]
    public IActionResult CreateAccount()
    {
        if (!String.IsNullOrEmpty(HttpContext.Session.GetString("session")))
        {
            ViewBag.user = HttpContext.Session.GetString("session");
            //ViewBag.user = login.UserName;
            return View();
        }
        return RedirectToAction("Signin", "Home");
    }

    [HttpPost]
    public IActionResult CreateAccount(UserInput data)
    {


        if (!String.IsNullOrEmpty(HttpContext.Session.GetString("session")))
        {

            var pwd = new Password(includeLowercase: true, includeUppercase: true, includeNumeric: true, includeSpecial: true, passwordLength: 12);
            var password = pwd.Next();

            var Reset_Pass_key = new Password(includeLowercase: true, includeUppercase: true, includeNumeric: true, includeSpecial: true, passwordLength: 32);
            var Pass_key = pwd.Next();
            Console.WriteLine(Pass_key);

            Console.WriteLine(Pass_key);
            // ViewBag.pass = password;
            data.Password = password;
            data.Confirmpassword = password;
            data.Reset_Key = Pass_key;
            _database.EmployeeData.Add(data);
            _database.SaveChanges();

            return RedirectToAction("Dashboard");
        }
        return RedirectToAction("Signin", "Home");



    }

    public IActionResult Forgotpassword()
    {
        return View();
    }

    public IActionResult Logout()
    {
        HttpContext.Session.SetString("session", "");
        return RedirectToAction("Index", "Home");
    }

    public IActionResult UserDetails(UserInput User)
    {
        return View();
    }

    public IActionResult Forgot()
    {
        Employee forgotpass = new Employee();
        forgotpass.Name = Convert.ToString(Request.Form["UserName"]);
        forgotpass.Password = Convert.ToString(Request.Form["Password"]);
        forgotpass.Confirmpassword = Convert.ToString(Request.Form["Confirmpassword"]);

        if (forgotpass.Password == forgotpass.Confirmpassword)
        {
            ViewBag.pass = AdminConnection.forgotpassword(forgotpass);
        }

        else
        {
            ViewBag.Message = string.Format("Password dosent match!");
            return View("Forgotpassword");
        }
        if (ViewBag.pass)
        {
            return View("Login");
        }
        else
        {
            return View("Forgotpassword");
        }
    }

    public IActionResult AdminLogin()
    {
        Employee Admin = new Employee();
        Admin.Name = Convert.ToString(Request.Form["UserName"]);
        Admin.Password = Convert.ToString(Request.Form["Password"]);

        ViewBag.adminlogin = AdminConnection.login(Admin);

        if (ViewBag.adminlogin)
        {
            return View("Index", Admin);
        }
        else
        {
            ViewBag.Message = string.Format("Invalid Username and password!");
            return View("Login");
        }
    }

    public IActionResult Viewprofile(string id)
    {
        if (!String.IsNullOrEmpty(HttpContext.Session.GetString("session")))
        {
            Console.WriteLine(id);
            var Email = id;
            var profile = _database.EmployeeData.Find(Email);
            return View(profile);

        }
        return RedirectToAction("Signin", "Home");
    }

    [HttpPost]

    public IActionResult Updateprofile(UserInput update)
    {

        _database.EmployeeData.Update(update);
        _database.SaveChanges();

        return RedirectToAction("Dashboard", "Admin");
    }


    public IActionResult Delete(string id)
    {

        Console.WriteLine(id);
        var Email = _database.EmployeeData.Find(id);

        Console.WriteLine(Email.Email);

        _database.EmployeeData.Remove(Email);
        _database.SaveChanges();
        return View("Index");

    }


    public IActionResult AdminUpdate(string id)
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

    public IActionResult DeleteEmployee(string id)
    {
        if (!String.IsNullOrEmpty(HttpContext.Session.GetString("session")))
        {
            Console.WriteLine(id);
            var Email = id;
            var profile = _database.EmployeeData.Find(Email);
            ViewBag.email = Email;
            Console.WriteLine(Email);
            return View(profile);

        }
        return RedirectToAction("Signin", "Home");
    }




}
