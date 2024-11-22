using System.Data.SqlClient;
using System.Data;
using APP.Models;

namespace app.Models
{
    public static class AdminConnection
    {

        public static SqlConnection _connectionstring;

        public static SqlCommand command;
        public static string? querycommand = "";


        static AdminConnection()
        {
            _connectionstring = new SqlConnection();
            command = new SqlCommand();
            command.Connection = _connectionstring;


        }

        public static String getConnectionString()
        {
            var build = new ConfigurationBuilder()
           .SetBasePath(Directory.GetCurrentDirectory())
           .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true);

            IConfiguration configuration = build.Build();

            String? connectionString = Convert.ToString(configuration.GetConnectionString("connectionstring"));

            if (connectionString is not null)
            {
                return connectionString;
            }

            return "";
        }
        public static dynamic insert(Employee admin)
        {
            _connectionstring.ConnectionString = getConnectionString();
            string? fname = admin.Name;
            string? mail = admin.Mail;
            string? password = admin.Password;
            int id = admin.ID;
            string? Position = admin.Position;
            querycommand = $"insert into EmployeeDetails values ('{fname}','{mail}','{password}',{id},'{Position}')";

            command.CommandText = querycommand;

            try
            {
                _connectionstring.Open();
                command.ExecuteNonQuery();
                _connectionstring.Close();
                return true;
            }
            catch (Exception err)
            {
                Console.WriteLine(err.Message);
                return false;
            }
            //throw new NotImplementedException();
        }


        public static dynamic login(Employee admin)
        {

            _connectionstring.ConnectionString = getConnectionString();
            string? Employeename = admin.Name;
            string? Password = admin.Password;
            _connectionstring.Open();
            querycommand = $"select * from EmployeeData where EmployeeName='{Employeename}'and EmployeePassword = '{Password}'";
            SqlCommand sqlCommand = new SqlCommand(querycommand, _connectionstring);
            SqlDataReader log = sqlCommand.ExecuteReader();
            command.CommandText = querycommand;

            if (log.Read())
            {
                _connectionstring.Close();
                return true;
            }
            else
            {
                _connectionstring.Close();
                return false;
            }
        }

        public static dynamic forgotpassword(Employee forgotpass)
        {
            _connectionstring.ConnectionString = getConnectionString();
            string? name = forgotpass.Name;
            string? password = forgotpass.Password;
            _connectionstring.Open();
            querycommand = $"select * from EmployeeData where EmployeeName='{name}'";
            SqlCommand sqlCommand = new SqlCommand(querycommand, _connectionstring);
            SqlDataReader forgot = sqlCommand.ExecuteReader();
            command.CommandText = querycommand;

            if (forgot.Read())
            {
                _connectionstring.Close();
                _connectionstring.Open();
                querycommand = $"update EmployeeData set EmployeePassword = '{password}' where EmployeeName = '{name}'";
                SqlCommand Command = new SqlCommand(querycommand, _connectionstring);
                Command.ExecuteReader();
                command.CommandText = querycommand;
                _connectionstring.Close();
                return true;
            }
            else
            {
                _connectionstring.Close();
                return false;
            }


        }

        public static DataTable Details()
        {
            _connectionstring.ConnectionString = getConnectionString();
            querycommand = $"select UserName, Email, EmployeeID, Role from EmployeeData;";
            // SqlCommand sqlCommand = new SqlCommand(querycommand,conn);
            SqlDataAdapter Details = new SqlDataAdapter(querycommand, _connectionstring);
            DataTable UserDetails = new DataTable();

            Details.Fill(UserDetails);

            return UserDetails;
        }
    }
}
