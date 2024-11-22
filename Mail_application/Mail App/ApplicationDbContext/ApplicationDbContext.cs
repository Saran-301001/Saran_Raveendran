using System;

namespace APP.Models;

using Microsoft.EntityFrameworkCore;

public class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
    {

    }

    public DbSet<UserInput> EmployeeData { get; set; }

    public DbSet<ChatData> Chat {get;set;}
}
