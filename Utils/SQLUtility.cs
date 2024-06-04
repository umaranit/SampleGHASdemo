using System;
using System.Data.SqlClient;

public class SqlUtility
{
    public void RunQuery(string userInput)
    {
        string query = "SELECT * FROM Users WHERE Name = '" + userInput + "'";

        using (SqlConnection connection = new SqlConnection("<Your Connection String>"))
        {
            SqlCommand command = new SqlCommand(query, connection);
            command.Connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                Console.WriteLine(String.Format("{0}", reader[0]));
            }
        }
    }
}