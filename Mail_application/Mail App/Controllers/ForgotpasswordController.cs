using app.Models;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using Microsoft.EntityFrameworkCore;
using APP.Models;
using PasswordGenerator;

namespace app.Controllers;

public class Forgotpassword : Controller
{
    private readonly ApplicationDbContext _database;



    public Forgotpassword(ApplicationDbContext database)
    {
        _database = database;
    }
    public IActionResult ForgotPassword()
    {
        return View();
    }

    public IActionResult Updatedpassword()
    {
        return View();
    }

    public IActionResult Verification()
    {
        return View();
    }

    [HttpPost]
    public IActionResult ForgotPassword(UserInput userInput)
    {


        var getnumber = _database.EmployeeData.Find(userInput.Email);
        if (getnumber == null)
        {
            ViewBag.Message = string.Format("No Email Found");
        }
        else
        {
            string? email = getnumber.Email;
            // Console.WriteLine(email);
            ViewBag.mail = email;
            Console.WriteLine(ViewBag.mail);
            return View("Verification");
        }
        return View();
    }

    public IActionResult Sendotp(string number){
        string mobilenumber=number;
        Console.WriteLine(mobilenumber);

        var profile = _database.EmployeeData.Where(number=>number.MobileNumber==mobilenumber).FirstOrDefault();
        var pwd = new Password(includeLowercase: true, includeUppercase: true, includeNumeric: true, includeSpecial: true, passwordLength: 12);
        var password = pwd.Next();
      Console.WriteLine(profile.Password);
      profile.Password=password;
      profile.Confirmpassword=password;
      _database.EmployeeData.Update(profile);
      _database.SaveChanges();

        return RedirectToAction("");

    }


    [HttpPost]

    public IActionResult Verification(UserInput userInput){

        Console.WriteLine("this"+userInput.Email);
        Console.WriteLine(userInput.Reset_Key);
        
        var getemail = _database.EmployeeData.Where(email=>email.Email==userInput.Email && email.Reset_Key==userInput.Reset_Key).FirstOrDefault();
        
        if (getemail == null)
        {
            ViewBag.Message = string.Format("No Email Found");
        }
            ViewBag.mail = userInput.Email;
            Console.WriteLine("password ku pora email ivan than :"+userInput.Email);
            
            return View("Changepassword");
    }


    public IActionResult Changepassword(){
        return View();
    }


    [HttpPost]

    public IActionResult Changepassword(UserInput userInput){
        
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