using System.ComponentModel.DataAnnotations;
using System.Data;



namespace APP.Models{
    public class ChatData{
        [Key]
        public int Number {get;set;}
        [Required]
        public string? Email{get;set;} 
        
        [Required]
        public string? Content{get;set;} 
    }

}
        