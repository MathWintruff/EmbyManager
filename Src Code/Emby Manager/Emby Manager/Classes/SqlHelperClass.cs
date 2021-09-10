using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace EmbyManager
{
    public class SqlHelperClass
    {
        SqlConnection SqlDbConnection = new SqlConnection();
        SqlCommand SqlCommandObject = new SqlCommand();
        SqlDataAdapter DataReciver = new SqlDataAdapter();
        DataSet QueryResult = new DataSet();
        public string connectionString;
        public string SqlResponse;



        public SqlHelperClass(string _connectionString)
        {
            connectionString = _connectionString;
            SqlDbConnection.ConnectionString = connectionString;
            SqlCommandObject.Connection = SqlDbConnection;
        }

        public void ExecuteQuery(string QueryCommand)
        {
            try
            {
                SqlDbConnection.Open();
                SqlCommandObject.CommandText = QueryCommand;
                SqlResponse = Convert.ToString(SqlCommandObject.ExecuteNonQuery());
                SqlDbConnection.Close();
            }
            catch(Exception Error)
            {
                MessageBox.Show(Error.Message.ToString() , "Error de Query", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                SqlDbConnection.Close();
                return;
            }
        }

        public DataSet ReturnQueryResult(string QueryCommand)
        {
            try
            {
                QueryResult = new DataSet();
                SqlDbConnection.Open();
                SqlCommandObject.CommandText = QueryCommand;
                DataReciver.SelectCommand = SqlCommandObject;

                DataReciver.Fill(QueryResult);
                SqlDbConnection.Close();

                return QueryResult;
            }

            catch (Exception Error)
            {
                MessageBox.Show(Error.Message.ToString(), "Error de Query", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                SqlDbConnection.Close();
                return new DataSet();
            }
        }

        #region Connection test
        public bool IsConnection
        {
            get
            {
                try
                {
                    if (SqlDbConnection.State == System.Data.ConnectionState.Closed)
                        SqlDbConnection.Open();
                        SqlDbConnection.Close();

                    return true;
                }
                catch
                {
                    return false;
                }

            }
        }
        #endregion


    }
}
