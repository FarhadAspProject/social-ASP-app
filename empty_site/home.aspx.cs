using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace db_a27401_asp
{
    public partial class _home : System.Web.UI.Page
    {
        MySql.Data.MySqlClient.MySqlConnection conn;
        MySql.Data.MySqlClient.MySqlCommand cmd;
        MySql.Data.MySqlClient.MySqlDataReader reader;
        String queryStr;
        String name;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            UsernameTextBox.Attributes.Add("onkeyup", "UsernameValidation()");
            PasswordTextBox.Attributes.Add("onkeyup", "PasswordValidation()");

        }
        protected void LoginButton_Click(object sender, EventArgs e)
        {
            String connString = System.Configuration.ConfigurationManager.ConnectionStrings[
                "WebAppConnString"].ToString();

            using (conn = new MySql.Data.MySqlClient.MySqlConnection(connString))
            {
                conn.Open();
                queryStr = "";
                queryStr = "SELECT * FROM db_a27401_asp.user_registration WHERE username='"    
                    //////////////////// convert to string otherwise trouble ////////////////////
                    
                    + UsernameTextBox.Text.ToString() + "' AND password='" +
                    PasswordTextBox.Text.ToString() + "' ";
                cmd = new MySql.Data.MySqlClient.MySqlCommand(queryStr, conn);

                reader = cmd.ExecuteReader();

                name = "";
                while (reader.HasRows && reader.Read())
                {
                    name = reader.GetString(reader.GetOrdinal("username"));
                }

                if (reader.HasRows)
                {
                    Session["uname"] = name;
                    Response.BufferOutput = true;
                    Response.Redirect("loggedIn.aspx", false);
                }
                else
                {
                    LoginError.Text = "Invalid username password combination!";
                }
                reader.Close();

                conn.Close();
            }
        }      
    }
}