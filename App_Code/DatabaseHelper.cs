using System.Configuration;
using System.Data.SqlClient;

public class DatabaseHelper
{
    private static string connStr = ConfigurationManager.ConnectionStrings["DocExpiryDB"].ConnectionString;

    public static SqlConnection GetConnection()
    {
        return new SqlConnection(connStr);
    }
}
