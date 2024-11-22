using System.Data.SqlClient;
using System.Data;

namespace APP.Models
{
    public static class Connection
    {

        public static SqlConnection _connection;

        public static SqlCommand command;
        public static string? querycommand = "";


        static Connection()
        {
            _connection = new SqlConnection();
            command = new SqlCommand();
            command.Connection = _connection;


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

        public static void test()
        {

            _connection.ConnectionString = getConnectionString();
            try
            {
                _connection.Open();
                Console.Write("Connected");

            }
            catch (Exception error)
            {
                Console.WriteLine(error.Message);
            }

            finally
            {
                _connection.Close();
            }

        }

        public static dynamic insert(UserInput employee)
        {
            _connection.ConnectionString = getConnectionString();
            string? fname = employee.UserName;
            string? mail = employee.Email;
            string? password = employee.Password;
            int id = employee.EmployeeID;
            querycommand = $"insert into Details values ('{fname}','{mail}','{password}',{id},'employee')";

            command.CommandText = querycommand;

            try
            {
                _connection.Open();
                command.ExecuteNonQuery();

                _connection.Close();
                return true;
            }
            catch (Exception err)
            {
                Console.WriteLine(err.Message);
                return false;
            }
            //throw new NotImplementedException();
        }

        /////////Login Validation //////////////////

        public static dynamic loginUser(UserInput login)
        {
            _connection.ConnectionString = getConnectionString();
            string? Email = login.Email;
            string? password = login.Password;
            Console.WriteLine(Email);
            Console.WriteLine(password);
            querycommand = $"select Username,Role from EmployeeData where Email = '{Email}' and password = '{password}'";
            SqlDataAdapter Admindetails = new SqlDataAdapter(querycommand, _connection);

            using (DataTable Admindata = new DataTable())
            {


                Admindetails.Fill(Admindata);
                Console.WriteLine(Admindata);

                return Admindata;
            }

        }

        public static dynamic forgot(UserInput userData)
        {
            _connection.ConnectionString = getConnectionString();
            string? Email = userData.Email;
            string? password = userData.Password;
            _connection.Open();
            querycommand = $"select * from Details where Email='{Email}'";
            SqlCommand sqlCommand = new SqlCommand(querycommand, _connection);
            SqlDataReader forgot = sqlCommand.ExecuteReader();
            command.CommandText = querycommand;
            if (forgot.Read())
            {
                _connection.Close();
                _connection.Open();
                querycommand = $"update Details set Password = '{password}' where UserName ='{Email}'";
                SqlCommand Command = new SqlCommand(querycommand, _connection);
                Command.ExecuteReader();
                command.CommandText = querycommand;
                _connection.Close();
                return true;
            }
            else
            {
                _connection.Close();
                return false;
            }
        }
    }
}