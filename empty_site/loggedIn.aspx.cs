using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Web.UI.HtmlControls;

namespace db_a27401_asp
{
    public partial class loggedIn : System.Web.UI.Page
    {
        MySqlConnection conn;
        MySqlCommand cmd;

        //Placing the conString variable globally
        String connString = System.Configuration.ConfigurationManager.ConnectionStrings[
            "WebAppConnString"].ToString();
        
        String queryStr;
        public String current_user;
       
        protected void Page_Load(object sender, EventArgs e)
        {

            //Response.Write("<script>alert(' Calling loggedIn/pageLoad ');</script>");
            //String connString = System.Configuration.ConfigurationManager.ConnectionStrings["WebAppConnString"].ToString();            
            {               
                current_user = (String)(Session["uname"]);
                if (current_user == null)
                {
                    //conn.Close();
                    Session.Abandon();
                    Response.BufferOutput = true;
                    Response.Redirect("home.aspx", false);
                }
                else
                {
                    String full_name;
                    String image_source;
                    String current_post;

                    using (conn = new MySqlConnection(connString))
                    {
                        conn.Open();//\\\\\\\\\\\\\\\\\\\\\\\ OPEN //////////////////////////

                        queryStr = "SELECT * FROM db_a27401_asp.user_registration"+
                            " WHERE username = '" + current_user + "' ";
                        cmd = new MySqlCommand(queryStr, conn);

                        MySqlDataReader reader;
                        reader = cmd.ExecuteReader();

                        full_name = "";
                        image_source = "/User_images/no_image_male.png";

                        while (reader.HasRows && reader.Read())
                        {
                            full_name = reader.GetString(reader.GetOrdinal("first_name")) + 
                                " " + reader.GetString(reader.GetOrdinal("middle_name")) +
                                " " +  reader.GetString(reader.GetOrdinal("last_name"));
                            if (!reader.IsDBNull(reader.GetOrdinal("profile_pic")))
                            {
                                image_source = reader.GetString(reader.GetOrdinal("profile_pic"));
                            }
                        }
                        UserProPic.Src = image_source;

                        //after being read, the reader object in gone!!

                        userlabel1.Text = full_name;
                        UserProfileButton.Text = (full_name.Split()).ElementAt(0) + " Profile";

                        reader.Close();

                        queryStr = "SELECT * FROM db_a27401_asp.all_user_posts"+
                            " ORDER BY post_date DESC, post_time DESC";
                        cmd = new MySqlCommand(queryStr, conn);
                        reader = cmd.ExecuteReader();

                        current_post = "";
                        PostArea.Controls.Clear();
                        String post_date = "";
                        String post_time = "";
                        /*String preText_label;
                        preText_label = "";*/

                        this.pupulate_feed(ref reader, current_post, post_date, post_time);

                        reader.Close();
                        conn.Close();//\\\\\\\\\\\\\\\\\\\\\\\ Close //////////////////////////
                    }
                }
            }
        }

        void pupulate_feed(ref MySqlDataReader reader,string current_post, string post_date, string post_time)
        {
            if(reader.HasRows)
            {
                //int labelnum = 0;
                while (reader.HasRows && reader.Read())
                {

                    if (!reader.IsDBNull(reader.GetOrdinal("post_text")))
                    {
                        String post_ID = "";

                        post_ID = reader.GetString(reader.GetOrdinal("post_ID"));
                        String post_user = "";
                        post_user = reader.GetString(reader.GetOrdinal(
                            "post_username"));

                        current_post = reader.GetString(reader.GetOrdinal(
                            "post_text"));
                        post_date = (((String)(reader.GetString(reader.GetOrdinal(
                            "post_date")))).Split(' ')).ElementAt(0);
                        post_time = (((String)(reader.GetString(reader.GetOrdinal(
                            "post_time")))).Split(' ')).ElementAt(1);
                        //preText_label=(preText_label+labelnum.ToString());
                        HtmlGenericControl new_div =
                            new System.Web.UI.HtmlControls.HtmlGenericControl("DIV");
                        new_div.Attributes["class"] = "status_style";
                        //new_label.ID = preText_label;


                        //Don't add line breaks here. It'll push the status post down the div
                        new_div.InnerHtml = post_user + ": " + current_post + "<br/>" + 
                            post_time + ", " + post_date + "<br/>";
                        if (!reader.IsDBNull(reader.GetOrdinal("post_image")))
                        {
                            Image post_img = new Image();
                            post_img.CssClass = "image_style";
                            String imgUrl = "";
                            imgUrl = reader.GetString(reader.GetOrdinal("post_image"));

                            post_img.ImageUrl = imgUrl;
                            new_div.Controls.Add(post_img);

                        }

                        PostArea.Controls.Add(new_div);

                        int like_count = reader.GetInt32(reader.GetOrdinal("post_likes"));
                        int comment_count = reader.GetInt32(reader.GetOrdinal("post_comments"));

                        MySqlConnection conn_like;

                        using (conn_like = new MySqlConnection(connString))
                        {
                            conn_like.Open(); //\\\\\\\\\\\\\\\\\\\\\\\ OPEN //////////////////////////

                            queryStr = "SELECT * FROM db_a27401_asp.all_user_likes" + 
                                " WHERE  like_username='" + current_user +
                                "'  AND like_post_ID = '" + post_ID + "'";
                            cmd = new MySqlCommand(queryStr, conn_like);
                            MySqlDataReader like_reader;
                            like_reader = cmd.ExecuteReader();

                            if (like_reader.HasRows)
                            {
                                Button UNLIKE = new Button();
                                UNLIKE.Text = "Unlike";
                                /*String newLikeID = "LIKE" + post_ID;
                                LIKE.ID = newLikeID;*/
                                UNLIKE.CommandArgument = post_ID;
                                UNLIKE.Click += new EventHandler(UnlikeButton_Click);
                                PostArea.Controls.Add(UNLIKE);
                                HtmlGenericControl like_div =
                                new System.Web.UI.HtmlControls.HtmlGenericControl("DIV");
                                like_div.InnerHtml = like_count.ToString() + " Likes  " + 
                                    comment_count.ToString() + " Comments <br/><br/>";
                                PostArea.Controls.Add(like_div);

                            }
                            else
                            {
                                Button LIKE = new Button();
                                LIKE.Text = "Like";
                                /*String newLikeID = "LIKE" + post_ID;
                                LIKE.ID = newLikeID;*/
                                LIKE.CommandArgument = post_ID;
                                LIKE.Click += new EventHandler(LikeButton_Click);
                                PostArea.Controls.Add(LIKE);
                                HtmlGenericControl like_div =
                                new System.Web.UI.HtmlControls.HtmlGenericControl("DIV");
                                like_div.InnerHtml = like_count.ToString() + " Likes  " + 
                                    comment_count.ToString() + " Comments <br/><br/>";
                                PostArea.Controls.Add(like_div);

                            }

                            conn_like.Close();//\\\\\\\\\\\\\\\\\\\\\\\ CLOSE //////////////////////////
                        }

                        MySqlConnection conn_cmt;
                        MySqlCommand cmd_cmt;

                        using (conn_cmt = new MySqlConnection(connString))
                        {
                            conn_cmt.Open();//\\\\\\\\\\\\\\\\\\\\\\\ OPEN //////////////////////////

                            TextBox commentBox = new TextBox();
                            String newCBID = "commentBox" + post_ID;
                            commentBox.ID = newCBID;

                            commentBox.Attributes["class"] = "commentBox_style";
                            PostArea.Controls.Add(commentBox);

                            Button PostComment = new Button();
                            String newPCID = post_ID;
                            PostComment.ID = newPCID;

                            PostComment.Text = "Comment";
                            PostComment.CommandArgument = newCBID;
                            PostComment.Click += new EventHandler(PostCommentButton_Click);
                            PostArea.Controls.Add(PostComment);

                            queryStr = "SELECT * FROM db_a27401_asp.comment_section"+
                                " WHERE comment_post_ID = '" +
                                post_ID + "' ORDER BY comment_date ASC, comment_time ASC ";
                            cmd_cmt = new MySqlCommand(queryStr, conn_cmt);
                            MySqlDataReader readComment;
                            readComment = cmd_cmt.ExecuteReader();
                            String current_cmt = "";
                            String commentator_user = "";
                            if (readComment.HasRows)
                            {
                                while (readComment.HasRows && readComment.Read())
                                {
                                    if (!readComment.IsDBNull(readComment.GetOrdinal(
                                        "comment_text")))
                                    {
                                        current_cmt = readComment.GetString(
                                            readComment.GetOrdinal("comment_text"));
                                        commentator_user = readComment.GetString(
                                            readComment.GetOrdinal("commentator_username"));

                                        post_date = (((String)(readComment.GetString(
                                            readComment.GetOrdinal(
                                                "comment_date")))).Split(' ')).ElementAt(0);
                                        post_time = (String)(readComment.GetString(
                                            readComment.GetOrdinal("comment_time")));

                                        HtmlGenericControl cmt_div =
                                        new System.Web.UI.HtmlControls.HtmlGenericControl("DIV");

                                        cmt_div.Attributes["class"] = "comment_style";
                                        //new_label.ID = preText_label;
                                        cmt_div.InnerHtml = commentator_user + ": " + 
                                            current_cmt + "<br/>" + post_time
                                        + ", " + post_date + "<br/>";
                                        PostArea.Controls.Add(cmt_div);
                                    }
                                }
                                conn_cmt.Close();//\\\\\\\\\\\\\\\\\\\\\\\ Close //////////////////////////                                       
                            }
                            else
                            {
                                conn_cmt.Close();//\\\\\\\\\\\\\\\\\\\\\\\ Close //////////////////////////
                                HtmlGenericControl cmt_div =
                                new System.Web.UI.HtmlControls.HtmlGenericControl("DIV");
                                cmt_div.Attributes["class"] = "comment_style";
                                //new_label.ID = preText_label;
                                cmt_div.InnerHtml = "<br/>No comments yet!<br/><br/>";
                                PostArea.Controls.Add(cmt_div);

                            }
                        }
                    }
                }
            }
            else
            {
                HtmlGenericControl new_div =
                        new System.Web.UI.HtmlControls.HtmlGenericControl("DIV");
                //new_label.ID = preText_label;
                new_div.Attributes["class"] = "status_style";
                new_div.InnerHtml = "<br/>No stories. Add users for more stories<br/>";
                PostArea.Controls.Add(new_div);

            }
        }

        protected void LogoutButton_ClickMethod(object sender, EventArgs e)
        {
            Session["uname"] = null;
            Session.Abandon();
            Response.BufferOutput = true;
            Response.Redirect("home.aspx", false);

        }

        protected void UploadImageButton_Click(object sender, EventArgs e)
        {

            if (FileUploadBox.HasFile)
            {
               
                String str = FileUploadBox.FileName;
                FileUploadBox.PostedFile.SaveAs(Server.MapPath("~/") + "//User_images//" + str);
                String new_image_upload = "/User_images/" + str.ToString();

                String connString = System.Configuration.ConfigurationManager.ConnectionStrings["WebAppConnString"].ToString();
                using (conn = new MySqlConnection(connString))
                {
                    conn.Open();

                    queryStr = "UPDATE db_a27401_asp.user_registration SET profile_pic = '" +
                        new_image_upload + "' WHERE username = '" + current_user + "' ";
                    cmd = new MySqlCommand(queryStr, conn);
                    cmd.ExecuteNonQuery();

                    conn.Close();
                }
                Response.BufferOutput = true;
                Response.Redirect("loggedIn.aspx", false);               
            }
        }

        protected void StatusPostButton_Click(object sender, EventArgs e)
        {
            //String connString = System.Configuration.ConfigurationManager.ConnectionStrings["WebAppConnString"].ToString();
            using (conn = new MySqlConnection(connString))
            {
                conn.Open();

                current_user = (String)(Session["uname"]);


                if (PostFileUploadBox.HasFile)  // Checking if user has Image with the post
                {
                    String str = PostFileUploadBox.FileName;
                    PostFileUploadBox.PostedFile.SaveAs(Server.MapPath("~/") + 
                        "//User_images//" + str);
                    String new_image_upload = "/User_images/" + str.ToString();

                    queryStr = "INSERT INTO db_a27401_asp.all_user_posts"+
                        " (post_username,post_text,post_image,post_date,post_time)" +
                        "VALUES ('" + current_user + "','" + 
                        UserStatusTextBox.Text.ToString() + 
                        "','" + new_image_upload + "',CURDATE(),CURTIME())";
                    //Input from textBox; convert to ToString()

                    cmd = new MySqlCommand(queryStr, conn);
                    cmd.ExecuteNonQuery();

                }
                else
                {
                    queryStr = "INSERT INTO db_a27401_asp.all_user_posts"+
                        " (post_username,post_text,post_image,post_date,post_time)" +
                        "VALUES ('" + current_user + "','" + 
                        UserStatusTextBox.Text.ToString() +
                        "',null,CURDATE(),CURTIME())";
                    cmd = new MySqlCommand(queryStr, conn);
                    cmd.ExecuteNonQuery();
                }

                conn.Close();
                UserStatusTextBox.Text = "";
            }
            
            Response.BufferOutput = true;
            Response.Redirect("loggedIn.aspx", false);
        }

        protected void UserProfileButton_Click(object sender, EventArgs e)
        {
            Page_Load(null, null);
        }

        protected void PostCommentButton_Click(object sender, EventArgs e)
        {
            //String connString = System.Configuration.ConfigurationManager.ConnectionStrings["WebAppConnString"].ToString();
            using (conn = new MySqlConnection(connString))
            {
                conn.Open();
                Button btn = sender as Button;
                String comment_post_ID = btn.ID.ToString();


                current_user = (String)(Session["uname"]);
                TextBox CB = (TextBox)PostArea.FindControl(btn.CommandArgument);
                queryStr = "INSERT INTO db_a27401_asp.comment_section "+
                    " (comment_post_ID,commentator_username,comment_text,comment_date,"+
                    "comment_time)" +
                    "VALUES ('" + comment_post_ID + "','" + current_user + 
                    "','" + CB.Text.ToString() + "',CURDATE(),CURTIME())";
                //Input from textBox; convert to ToString()

                cmd = new MySqlCommand(queryStr, conn);
                cmd.ExecuteNonQuery();

                queryStr = "UPDATE db_a27401_asp.all_user_posts SET post_comments"+
                    " = post_comments + 1 WHERE post_ID ='" +
                    comment_post_ID + "'";

                cmd = new MySqlCommand(queryStr, conn);
                cmd.ExecuteNonQuery();

                conn.Close();
            }
            Response.BufferOutput = true;
            Response.Redirect("loggedIn.aspx", false);
        }

        protected void LikeButton_Click(object sender, EventArgs e)
        {
            //String connString = System.Configuration.ConfigurationManager.ConnectionStrings["WebAppConnString"].ToString();
            using (conn = new MySqlConnection(connString)) 
            {
                conn.Open();
                current_user = (String)(Session["uname"]);
                Button btn = sender as Button;
                String post_ID = btn.CommandArgument;
                queryStr = "UPDATE db_a27401_asp.all_user_posts SET post_likes "+
                    " = post_likes + 1 WHERE post_ID ='" +
                    post_ID + "'";

                cmd = new MySqlCommand(queryStr, conn);
                cmd.ExecuteNonQuery();
                queryStr = "INSERT INTO db_a27401_asp.all_user_likes"+
                    " (like_post_ID,like_username)" + " VALUES ('" +
                    post_ID + "','" + current_user + "')";

                cmd = new MySqlCommand(queryStr, conn);
                cmd.ExecuteNonQuery();

                conn.Close();
            }
            Response.BufferOutput = true;
            Response.Redirect("loggedIn.aspx", false);
        }
        protected void UnlikeButton_Click(object sender, EventArgs e)
        {

            //String connString = System.Configuration.ConfigurationManager.ConnectionStrings["WebAppConnString"].ToString();
            using (conn = new MySqlConnection(connString))
            {
                conn.Open();
                current_user = (String)(Session["uname"]);
                Button btn = sender as Button;
                String post_ID = btn.CommandArgument;
                queryStr = "UPDATE db_a27401_asp.all_user_posts SET post_likes"+
                    " = post_likes - 1 WHERE post_ID ='" +
                    post_ID + "'";

                cmd = new MySqlCommand(queryStr, conn);
                cmd.ExecuteNonQuery();

                queryStr = "DELETE FROM db_a27401_asp.all_user_likes WHERE like_post_ID ='" +
                    post_ID + "' AND like_username='" + current_user + "'";

                cmd = new MySqlCommand(queryStr, conn);
                cmd.ExecuteNonQuery();

                conn.Close();
            }
            Response.BufferOutput = true;
            Response.Redirect("loggedIn.aspx", false);


        }      
    }
}