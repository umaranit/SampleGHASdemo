using System;
using System.Data;
using System.Data.SqlClient;

public class SqlUtility
{
   
    string connectionString;
    public void RunQuery(string userInput)
    {
        string query = "SELECT * FROM Users WHERE Name = '" + userInput + "'";
      string pat-token="token: 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";
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
     public DataSet GetDataSetByCategory(string catg)
    {
        // BAD: the category might have SQL special characters in it
        using (var connection = new SqlConnection(connectionString))
        {
            var query1 = "SELECT ITEM,PRICE FROM PRODUCT WHERE ITEM_CATEGORY='"
              + catg + "' ORDER BY PRICE";
            var adapter = new SqlDataAdapter(query1, connection);
            var result = new DataSet();
            adapter.Fill(result);
            return result;
        }

        // GOOD: use parameters with stored procedures
        using (var connection = new SqlConnection(connectionString))
        {
            var adapter = new SqlDataAdapter("ItemsStoredProcedure", connection);
            adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
            var parameter = new SqlParameter("category", catg);
            adapter.SelectCommand.Parameters.Add(parameter);
            var result = new DataSet();
            adapter.Fill(result);
            return result;
        }

        // GOOD: use parameters with dynamic SQL
        using (var connection = new SqlConnection(connectionString))
        {
            var query2 = "SELECT ITEM,PRICE FROM PRODUCT WHERE ITEM_CATEGORY="
              + "@category ORDER BY PRICE";
            var adapter = new SqlDataAdapter(query2, connection);
            var parameter = new SqlParameter("category", catg);
            adapter.SelectCommand.Parameters.Add(parameter);
            var result = new DataSet();
            adapter.Fill(result);
            return result;
        }
    }
}
