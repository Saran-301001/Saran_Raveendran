using System.ComponentModel.DataAnnotations;
using System.Data;



namespace APP.Models{
    public class UserInput{
        
        [Required]
        public string? UserName{get;set;} 
        
        [Required]
        public string? SurName{get;set;} 
        
        [Required]
        public string? PersonalEmail{get;set;} 
        
        [Key]
        [Required]
        public string? Email{get;set;}
        
        [Required] 
        public string? Password{get;set;} 
        
        [Required]
        public String? Confirmpassword{get;set;}
        [Required]
        public int EmployeeID{get;set;} 
        
        [Required]
        public String? Role{get;set;}

        [Required]
        public string? MobileNumber {get;set;}

        [Required]
        public string? Project {get;set;}
        
        [Required]
        public string? Role_Project {get;set;}

        [Required]
        public string? Reset_Key {get;set;}

        
    }
}