using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Web.UI.HtmlControls;
using System.Web.Services;
using System.Diagnostics;

namespace db_a27401_asp
{
    public partial class inboxPage : System.Web.UI.Page
    {
        MySqlConnection conn;
        MySqlCommand cmd;
        String connString = System.Configuration.ConfigurationManager.ConnectionStrings[
            "WebAppConnString"].ToString();

        String queryStr;
        public String current_user;
        protected void Page_Load(object sender, EventArgs e)
        {
            
            List<String> ConvUserList = new List<String>();
            List<String> ConvUserListDateTime = new List<String>();
            MySqlDataReader reader;

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
                // was giving error because the if clause didn't contain an else extension
                else
                {
                    current_user = (String)(Session["uname"]);

                    ProfileButton.Text = current_user;
                    queryStr = "SELECT * FROM db_a27401_asp.user_messages WHERE user_from='" + 
                        current_user + "' OR user_to='" +
                        current_user + "' ORDER BY msg_date DESC, msg_time DESC";
                    cmd = new MySqlCommand(queryStr, conn);
                    reader = cmd.ExecuteReader();


                    

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
                                }

                                /*ConvUser.ID = convUser + "_" + convUserCount.ToString();
                                ConvUser.Text = "Conversation with " + convUser + " at " + msg_time + " " + msg_date;
                                ConvUser.Click += new EventHandler(ConvUser_click);
                       
                                PreConvArea_.Controls.Add(new LiteralControl("<br/>"));
                                PreConvArea_.Controls.Add(ConvUser);*/

                            }
                        }
                    }

                    for (int i = 0; i < ConvUserListDateTime.Count; i++)
                    {
                        LinkButton ConvUser = new LinkButton();

                        // adding an '@' sign at the end of the ID for uniqueness

                        ConvUser.ID = (ConvUserListDateTime[i].Split(' ')).ElementAt(0) + "@" +
                            i.ToString();
                        ConvUser.Text = (ConvUserListDateTime[i].Split(' ')).ElementAt(0) + 
                            "<br/>" +
                            (ConvUserListDateTime[i].Split(' ')).ElementAt(2) + ", " +
                            (ConvUserListDateTime[i].Split(' ')).ElementAt(1);

                        ConvUser.Click += new EventHandler(ConvUser_click);

                        PreConvArea.Controls.Add(new LiteralControl("<br/><br/>"));
                        PreConvArea.Controls.Add(ConvUser);
                    }
                    reader.Close();
                    //conn.Close();
                }

                
                //conn = new MySqlConnection(connString);
                //conn.Open();

                String user_To;

                // gettign the value from QueryString or the most recent conversation
                user_To = "";
                if (Request.QueryString["userConv"] != null)
                {
                    user_To = (String)Request.QueryString["userConv"];
                }
                else if (ConvUserList.Count<1)
                {
                    user_To = "None";
 
                }
                else
                {
                    user_To = ConvUserList[0];
                }

                // for denugging 
                Debug.WriteLine(user_To);

                if(user_To!="None")
                {
                    queryStr = "SELECT * FROM db_a27401_asp.user_messages WHERE (user_from='" +
                        current_user + "' AND user_to='" + user_To + "') OR (user_from='" +
                        user_To + "' AND user_to='" +
                        current_user + "') ORDER BY msg_date ASC, msg_time ASC";

                    cmd = new MySqlCommand(queryStr, conn);
                    reader = cmd.ExecuteReader();

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

                                HtmlGenericControl msg_div =
                                            new System.Web.UI.HtmlControls.HtmlGenericControl(
                                                "DIV");

                                //msg_div.Attributes["class"] = "msg_L_style";
                                if (user_from == current_user)
                                {
                                    msg_div.Attributes["class"] = "msg_R_style";
                                }
                                else 
                                {
                                    msg_div.Attributes["class"] = "msg_L_style";
                                }
                            
                                msg_div.InnerHtml += user_from + ": " + msg_text + "<br/>" +
                                         msg_time + ", " + msg_date;
                                MsgArea.Controls.Add(msg_div);

                            }
                        }
                    }
                    reader.Close();
                }
                UserTo.Text = user_To;
                UserFrom.InnerHtml = current_user;

                ConvUserList.Clear();
                ConvUserListDateTime.Clear();
              
                conn.Close();
            }                       
        }

        protected void NewMsgButton_Click(object sender, EventArgs e)
        {
            Response.BufferOutput = true;
            Response.Redirect("NewMessagePage.aspx", false);

        }

        protected void MsgReplyButton_Click(object sender, EventArgs e)
        {

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

            Response.Redirect("inboxPage.aspx?userConv="+
                ((link_btn.ID).Split('@')).ElementAt(0), false);
        }

        [WebMethod]


        // function for ajax calls
        public static string SendMessageToDb(string userFrom,string userTo,string msgText)
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
                queryStr = "INSERT INTO db_a27401_asp.user_messages"+
                    " (user_from,user_to,msg_text,msg_date,msg_time)" +
                    "VALUES('" + userFrom + "','" + userTo + "','" + msgText +
                    "',CURDATE(),CURTIME())";
                cmd = new MySqlCommand(queryStr, conn);
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            return "Success!";
        }       
    }
}