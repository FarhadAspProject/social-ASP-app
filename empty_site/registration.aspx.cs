using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using MySql.Data.MySqlClient;

namespace db_a27401_asp
{
    public partial class registration : System.Web.UI.Page
    {
        MySql.Data.MySqlClient.MySqlConnection conn;
        MySql.Data.MySqlClient.MySqlCommand cmd;
        String queryStr;
        protected void Page_Load(object sender, EventArgs e)
        {
            //TextBox1.Attributes.Add("onkeyup", "ClientCheckUser()");

        }

        protected void RegistrationButton_Click(object sender, EventArgs e)
        {
            registerUser();

        }
        private void registerUser()
        {
            String connString = System.Configuration.ConfigurationManager.ConnectionStrings["WebAppConnString"].ToString();

            using (conn = new MySqlConnection(connString))
            {
                conn.Open();
                queryStr = "";                
                //////////////////// convert to string otherwise trouble ////////////////////               
                queryStr = "INSERT INTO db_a27401_asp.user_registration " +
                    "(first_name, middle_name,last_name, email, phone_number"+
                    ", username, password)" +
                    "VALUES('" + FirstNameTextBox.Text.ToString() + 
                    "','" + MiddleNameTextBox.Text.ToString() +
                    "','" + LastNameTextBox.Text.ToString() + "','" + 
                    EmailTextBox.Text.ToString() +
                    "','" + PhoneNumberTB.Value.ToString() +
                    " ','" + UserNameTB.Value.ToString() + "','" + 
                    PasswordTB.Value.ToString() + "')";
                cmd = new MySqlCommand(queryStr, conn);
                cmd.ExecuteReader();

                conn.Close();
            }

            Response.BufferOutput = true;
            Response.Redirect("home.aspx", false);

        }


        protected void LoginButton_Click(object sender, EventArgs e)
        {
            Response.BufferOutput = true;
            Response.Redirect("home.aspx", false);
        }
        
        [WebMethod]

        

        public static string CheckUser(string userName)
        {
            MySqlConnection conn;
            MySqlCommand cmd;
            
            
            String queryStr;
            String connString = System.Configuration.ConfigurationManager.ConnectionStrings["WebAppConnString"].ToString();
            using (conn = new MySqlConnection(connString))
            {
                conn.Open();
                queryStr = "";
                queryStr = "SELECT * FROM db_a27401_asp.user_registration WHERE username='" + userName + "'";
                cmd = new MySqlCommand(queryStr, conn);
                MySqlDataReader reader;
                reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    reader.Dispose();
                    conn.Close();
                    return "Username Not available";
                }
                else
                {
                    reader.Dispose();
                    conn.Close();
                    return "Username Available";
                }
            }
        }
    }
}