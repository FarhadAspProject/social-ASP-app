using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Web.UI.HtmlControls;
using System.Web.Services;

namespace db_a27401_asp
{
    public partial class NewMessagePage : System.Web.UI.Page
    {
        MySqlConnection conn;
        MySqlCommand cmd;

        String queryStr;
        public String current_user;
        protected void Page_Load(object sender, EventArgs e)
        {
            String connString = System.Configuration.ConfigurationManager.ConnectionStrings[
                "WebAppConnString"].ToString();

            using (conn = new MySqlConnection(connString))
            {
                conn.Open();


                //String msgUser = Request.QueryString["userConv"];

                if (Session["uname"] == null)
                {
                    conn.Close();
                    Session.Abandon();
                    Response.BufferOutput = true;
                    Response.Redirect("home.aspx", false);
                }
                else
                {
                    // was giving error because the if clause didn't contain an else extension
                    current_user = (String)(Session["uname"]);

                    ProfileButton.Text = current_user;
                    queryStr = "SELECT * FROM db_a27401_asp.user_messages WHERE user_from='" + 
                        current_user + "' OR user_to='" +
                        current_user + "' ORDER BY msg_date DESC, msg_time DESC";
                    cmd = new MySqlCommand(queryStr, conn);
                    MySqlDataReader reader;
                    reader = cmd.ExecuteReader();

                    // storing all conversations

                    List<String> ConvUserList = new List<String>();
                    List<String> ConvUserListDateTime = new List<String>();

                    int convUserCount = 0;
                    if (reader.HasRows)
                    {

                        while (reader.HasRows && reader.Read())
                        {

                            if (!reader.IsDBNull(reader.GetOrdinal("msg_text")))
                            {
                                String msg_ID = "";

                                msg_ID = reader.GetString(reader.GetOrdinal("msg_ID"));
                                String user_to = "";
                                user_to = reader.GetString(reader.GetOrdinal("user_to"));
                                String user_from = "";
                                user_from = reader.GetString(reader.GetOrdinal("user_from"));
                                String msg_text = "";
                                msg_text = reader.GetString(reader.GetOrdinal("msg_text"));
                                String msg_date = "";
                                msg_date = (((String)(reader.GetString(reader.GetOrdinal(
                                    "msg_date")))).Split(' ')).ElementAt(0);
                                String msg_time = "";
                                msg_time = (String)(reader.GetString(reader.GetOrdinal(
                                    "msg_time")));


                                //LinkButton ConvUser = new LinkButton();
                                String convUser = "";
                                if (current_user == user_from)
                                {
                                    convUser = user_to;
                                }
                                else
                                {
                                    convUser = user_from;
                                }

                                if (!ConvUserList.Contains(convUser))
                                {
                                    ConvUserList.Add(convUser);
                                    ConvUserListDateTime.Add(convUser + " " + msg_date + " " +
                                        msg_time);
                                    convUserCount++;
                                }

                            }
                        }
                    }

                    // looping for all previous conversations in descending time-date 

                    for (int i = 0; i < ConvUserListDateTime.Count; i++)
                    {
                        LinkButton ConvUser = new LinkButton();

                        // adding an '@' sign at the end of the ID for uniqueness

                        ConvUser.ID = (ConvUserListDateTime[i].Split(' ')).ElementAt(0) + 
                            "@" + i.ToString();
                        ConvUser.Text = (ConvUserListDateTime[i].Split(' ')).ElementAt(0) + 
                            "<br/>" +
                            (ConvUserListDateTime[i].Split(' ')).ElementAt(2) + ", " +
                            (ConvUserListDateTime[i].Split(' ')).ElementAt(1);

                        ConvUser.Click += new EventHandler(ConvUser_click);

                        PreConvArea_.Controls.Add(new LiteralControl("<br/><br>"));
                        PreConvArea_.Controls.Add(ConvUser);
                    }

                    UserFrom.InnerHtml = current_user;

                    ConvUserList.Clear();
                    ConvUserListDateTime.Clear();
                    reader.Close();
                }
                conn.Close();
            }
        }

        

        protected void LogoutButton_ClickMethod(object sender, EventArgs e)
        {
            Session["uname"] = null;
            Session.Abandon();
            Response.BufferOutput = true;
            Response.Redirect("home.aspx", false);
        }
        protected void ConvUser_click(object sender, EventArgs e)
        {
            LinkButton link_btn = sender as LinkButton;
            Response.BufferOutput = true;

            // using the '@' sign at the end of the ID for username extraction
            //passing username for dispalying messages

            Response.Redirect("inboxPage.aspx?userConv=" + 
                ((link_btn.ID).Split('@')).ElementAt(0), false);
        }

        
        protected void InboxMsgButton_Click(object sender, EventArgs e)
        {
            Response.BufferOutput = true;
            Response.Redirect("inboxPage.aspx", false);
        }

        [WebMethod]   // have to write [WebMethod] again for making other methods work!!!!


        // function for ajax calls
        public static string SendMessageToDb(string userFrom, string userTo, string msgText)
        {
            MySqlConnection conn;
            MySqlCommand cmd;


            String queryStr;
            String connString = System.Configuration.ConfigurationManager.ConnectionStrings[
                "WebAppConnString"].ToString();
            using (conn = new MySqlConnection(connString))
            {
                conn.Open();
                queryStr = "";
                queryStr = "INSERT INTO db_a27401_asp.user_messages" +
                    " (user_from,user_to,msg_text,msg_date,msg_time)" +
                    "VALUES('" + userFrom + "','" + userTo + "','" + msgText + 
                    "',CURDATE(),CURTIME())";
                cmd = new MySqlCommand(queryStr, conn);
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            return "Success!";
        }

        [WebMethod] // have to write [WebMethod] again for making CheckUser method work!!!!
        public static string CheckUser(string userName)
        {
            MySqlConnection conn;
            MySqlCommand cmd;
            
            String queryStr;
            String connString = System.Configuration.ConfigurationManager.ConnectionStrings[
                "WebAppConnString"].ToString();
            using (conn = new MySqlConnection(connString))
            {
                conn.Open();
                queryStr = "";
                queryStr = "SELECT * FROM db_a27401_asp.user_registration"+
                    " WHERE username='" + userName + "'";
                cmd = new MySqlCommand(queryStr, conn);
                MySqlDataReader reader;
                reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    reader.Dispose();
                    conn.Close();
                    return "Username found!";
                }
                else
                {
                    reader.Dispose();
                    conn.Close();
                    return "Username not found!";
                }
            }
        }
    }
}