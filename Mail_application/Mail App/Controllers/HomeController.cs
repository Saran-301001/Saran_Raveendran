using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using app.Models;
using System.Data.SqlClient;
using APP.Models;
using System.Data;


namespace app.Controllers;

public class HomeController : Controller
{
    private readonly ILogger<HomeController> _logger;

    public HomeController(ILogger<HomeController> logger)
    {
        _logger = logger;
    }

    public IActionResult Index()
    {
        //Connection.test();
        return View();
    }

    public IActionResult Privacy()
    {
        return View();
    }
    [HttpGet]
    public IActionResult Login_form()
    {
        return View();
    }

    public IActionResult Home()
    {

        ViewBag.Message = HttpContext.Session.GetString("session");
        return View();
    }

    [HttpPost]
    public IActionResult Login(UserInput login)
    {

        DataTable data = Connection.loginUser(login);

        foreach (DataRow row in data.Rows)
        {
            Console.WriteLine("Row1"+row[0]);
            Console.WriteLine("Row2"+row[1]);
            string? Adminname = row[0].ToString();
            string? AdminEmail = row[1].ToString();
            if (row[1].ToString() == "Admin")
            {
                HttpContext.Session.SetString("session", Adminname);
                return RedirectToAction("Index","Admin");
            }
            else if (row[1].ToString() == "Employee")
            {
                HttpContext.Session.SetString("session", Adminname);
                Console.WriteLine(Adminname);
                return RedirectToAction("Index","Employee");
            }
        }
        ViewBag.Message = string.Format("Invalid Username and password!");
        return View("Signin");

    }

    public IActionResult ForgotPassword()
    {
        return View();
    }

    [HttpGet]
    public IActionResult Forgot()
    {
        return View();
    }

    [HttpPost]
    public IActionResult forgotpassword()
    {
        UserInput UserData = new UserInput();
        UserData.Email = Convert.ToString(Request.Form["Email"]);
        UserData.Password = Convert.ToString(Request.Form["Password"]);
        UserData.Confirmpassword = Convert.ToString(Request.Form["confirmpassword"]);

        if (UserData.Password == UserData.Confirmpassword)
        {

            ViewBag.forgotpwd = Connection.forgot(UserData);
        }

        else
        {
            ViewBag.Message = string.Format("Passwords not Match");
            return View("Forgot");
        }

        if (ViewBag.forgotpwd)
        {
            return View("Index");
        }
        else
        {
            return View("signin");
        }

    }

    [HttpGet]
    public IActionResult Signin()
    {
        return View();
    }

    [HttpPost]
    public IActionResult Input()
    {
        UserInput employee = new UserInput();

        employee.UserName = Convert.ToString(Request.Form["UserName"]);
        employee.Email = Convert.ToString(Request.Form["Email"]);
        employee.Password = Convert.ToString(Request.Form["Password"]);
        employee.EmployeeID = Convert.ToInt32(Request.Form["Id"]);

        ViewBag.status = Connection.insert(employee);

        return View("Index");
    }



    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
        return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }
}
