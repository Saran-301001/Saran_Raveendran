using app.Models;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using Microsoft.EntityFrameworkCore;
using APP.Models;
using PasswordGenerator;

namespace app.Controllers;

public class ResetpasswordController:Controller{

     private readonly ApplicationDbContext _database;



    public ResetpasswordController(ApplicationDbContext database)
    {
        _database = database;
    }
    public IActionResult Index(){
        return View();
    }

    
    public IActionResult Resetpin(){
        return View();
    }

    [HttpPost]
   public IActionResult Index(UserInput userInput)
    {
        
        // userInput.Email = Request.Form["email"];
        var getemail = _database.EmployeeData.Where(email=>email.Email==userInput.Email && email.Reset_Key==userInput.Reset_Key).FirstOrDefault();
        
        if (getemail == null)
        {
            ViewBag.Message = string.Format("No Email Found");
        }
        
            // string? email = getemail.Email;
            // ViewBag.email = email;
            ViewBag.Mail=getemail.Email;
            return View("Resetpin");
        

       
    }

    [HttpPost]

    public IActionResult passkey(UserInput userInput){
         Console.WriteLine(userInput.Email);
        Console.WriteLine(userInput.Reset_Key);

        return View("Index");

    }


    [HttpPost]
    public IActionResult Resetpin(UserInput userInput){

        Console.WriteLine(userInput.Password);
        Console.WriteLine(userInput.Email);    
        var user=_database.EmployeeData.Find(userInput.Email);
        Console.WriteLine(user.Email);
        user.Password=userInput.Password;
        user.Confirmpassword=userInput.Confirmpassword;
        _database.EmployeeData.Update(user);
        _database.SaveChanges();
        ViewBag.pass = string.Format("Password changed successfully");
        return View();
    }
}