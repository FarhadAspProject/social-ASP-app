<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="loggedIn.aspx.cs" Inherits="db_a27401_asp.loggedIn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Log in</title>

    <style type="text/css">
        .status_style  { 
          width:560px;
          padding:5px;
          background-color:#ffffff;
          border: 4px solid white ;
          margin: 10px;
          margin-left:0px;
          margin-top:30px;
        }
        .comment_style  {
                
          width:400px;
          padding:5px;
          background-color:#E6F5F5;
          border: 2px solid white ;
          margin: 10px;
          margin-left:20px;
        }
        .image_style  {
                
          width:300px;
          height:250px;
          padding:7px;
          background-color:#E6F5F5;
          border: 4px solid white ;
          margin: 5px;
          
        }
        .commentBox_style  {
                
          width:400px;
          padding:7px;
          background-color:white;
          border: 1px solid #4dc3ff ;
          margin: 5px;
          margin-left:20px;
        }
          
        .auto-style1 {
            width: 191%;
            margin-right: 0px;
        }
        #TextArea1 {
            width: 275px;
            height: 103px;
            margin-top: 0px;
            margin-bottom: 0px;
        }
        #UserStatusTextBox {
            height: 75px;
            width: 290px;
            margin-top: 0px;
        }
        .auto-style48 {
            width: 440px;
            height: 28px;
        }
        .auto-style49 {
            width: 440px;
            height: 130px;
        }
        .auto-style51 {
            width: 440px;
            height: 26px;
        }
        .auto-style52 {
            width: 440px;
        }
        .auto-style53 {
            width: 440px;
            height: 23px;
        }
        .auto-style54 {
            width: 440px;
            height: 38px;
        }
        .auto-style76 {
            height: 28px;
            width: 197px;
        }
        .auto-style77 {
            height: 130px;
            width: 197px;
        }
        .auto-style79 {
            height: 26px;
            width: 197px;
        }
        .auto-style81 {
            height: 23px;
            width: 197px;
        }
        .auto-style82 {
            height: 38px;
            width: 197px;
        }
        .auto-style83 {
            width: 234px;
            height: 28px;
        }
        .auto-style84 {
            width: 234px;
            height: 130px;
        }
        .auto-style86 {
            width: 234px;
            height: 26px;
        }
        .auto-style87 {
            width: 234px;
        }
        .auto-style88 {
            width: 234px;
            height: 23px;
        }
        .auto-style89 {
            width: 234px;
            height: 38px;
        }
        .auto-style90 {
            width: 224px;
            height: 28px;
        }
        .auto-style91 {
            width: 224px;
            height: 130px;
        }
        .auto-style93 {
            width: 224px;
            height: 26px;
        }
        .auto-style94 {
            width: 224px;
        }
        .auto-style95 {
            width: 224px;
            height: 23px;
        }
        .auto-style96 {
            width: 224px;
            height: 38px;
        }
        .auto-style97 {
            width: 234px;
            height: 32px;
        }
        .auto-style98 {
            width: 440px;
            height: 32px;
        }
        .auto-style99 {
            width: 224px;
            height: 32px;
        }
        .auto-style100 {
            height: 32px;
            width: 197px;
        }
        .auto-style101 {
            width: 234px;
            height: 29px;
        }
        .auto-style102 {
            width: 440px;
            height: 29px;
        }
        .auto-style103 {
            width: 224px;
            height: 29px;
        }
        .auto-style104 {
            height: 29px;
            width: 197px;
        }
        .auto-style105 {
            width: 234px;
            height: 37px;
        }
        .auto-style106 {
            width: 440px;
            height: 37px;
        }
        .auto-style107 {
            width: 224px;
            height: 37px;
        }
        .auto-style108 {
            height: 37px;
            width: 197px;
        }
        .auto-style109 {
            width: 197px;
        }
    </style>
    <script type="text/javascript" src="jquery-1.11.3.js"></script>
    <script type="text/javascript">

    </script>
</head>
<body>
    <form id="form1" style="width:100%;height:100%;padding:10%; background-color:#e6f2ff;" runat="server" >
        <div>
           
        </div>
    
        
        <table class="auto-style1" style="width:80%;height: 80%; background-color:#EBEBE0;">
                <tr>
                    <td class="auto-style83">
                        <asp:Button ID="UserProfileButton"  OnClick="UserProfileButton_Click"  Text="" runat="server" Height="23px" Width="125px" style="margin-top: 2px" />
                    </td>
                    <td class="auto-style48">
                        <p>Home Page</p>
                    </td>
                    <td class="auto-style90">
                        &nbsp;<a href="loggedIn.aspx"><img alt="" src="/icon_images/icon_notification.png" style="height: 24px; width: 26px; margin-top: 4px" id="notification_image" /></a>&nbsp;&nbsp; <a href="loggedIn.aspx" ><img alt="icon_images" src="icon_images/icon_friendrequest.png" style="height: 23px; width: 22px" id="photo_image0" /></a></td>
                    <td class="auto-style76">
                        <asp:Button ID="LogoutButton" Text="Log out" OnClick="LogoutButton_ClickMethod" runat="server" Height="23px" style="margin-top: 0px" Width="59px" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style84">
                         <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
                         <p>Hello&nbsp;&nbsp;</p>
                        <p>&nbsp;<asp:label ID="userlabel1" Text="No user" runat="server" />
    
                        </p>
                    </td>
                    <td class="auto-style49">
                        <asp:TextBox ID="UserStatusTextBox" runat="server" Height="96px" Width="253px" TextMode="MultiLine"></asp:TextBox>
&nbsp;<asp:FileUpload ID="PostFileUploadBox" runat="server" style="margin-bottom: 0px" /> 
                    </td>
                    <td class="auto-style91">
                        <img src="no_image_male." id="UserProPic" runat="server" style="width:104px; height:121px; border:2px solid blue;padding:3px;" /></td>
                    <td class="auto-style77"></td>
                </tr>
                <tr>
                    <td class="auto-style97">
                      <a href="loggedIn.aspx" ><img alt="icon_images" src="icon_images/icon_newsfeed.png" style="height: 19px; width: 20px" id="newsfeed_image" />Newsfeed  </a>
                    </td>
                    <td class="auto-style98">
                        <asp:Button ID="StatusPostButton" runat="server" OnClick="StatusPostButton_Click" Text="Post" Width="69px" Height="27px" style="margin-bottom: 0px" />
                    </td>
                    <td class="auto-style99">
                        </td>
                    <td class="auto-style100"></td>
                </tr>
                <tr>
                    <td class="auto-style86">
                        <a href="NewMessagePage.aspx" ><img alt="icon_images" src="icon_images/icon_message.png" style="height: 19px; width: 20px" id="message_image" />Messages</a>
                    </td>
                    <td class="auto-style51">Or upload a photo</td>
                    <td class="auto-style93"> 
                        <asp:FileUpload ID="FileUploadBox" runat="server" style="margin-bottom: 0px" /> 
                    </td>
                    <td class="auto-style79"></td>
                </tr>
                <tr>
                    <td class="auto-style97">
                                            <a href="loggedIn.aspx" ><img alt="icon_images" src="icon_images/icon_photo.png" style="height: 19px; width: 20px" id="photo_image" />Photos</a>
                        &nbsp;</td>
                    <td class="auto-style98"> 
                        &nbsp;</td>
                    <td class="auto-style99"> 
                        <asp:Button ID="UploadImageButton" runat="server" Text="Upload image" onclick="UploadImageButton_Click" Height="21px"/>
                    </td>
                    <td class="auto-style100"></td>
                </tr>
                <tr>
                    <td class="auto-style83">
                        <a href="UserProfilePage.aspx" ><img alt="icon_images" src="icon_images/icon_edit.jpg" style="height: 19px; width: 20px" id="edit_profile_image" />Edit Profile</a>
                     &nbsp;</td>
                    <td class="auto-style48">
                        &nbsp;</td>
                    <td class="auto-style90"></td>
                    <td class="auto-style76"></td>
                </tr>
                <tr>
                    <td class="auto-style101">&nbsp;</td>
                    <td class="auto-style102">
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Your News Feed&nbsp;&nbsp;</td>
                    <td class="auto-style103"></td>
                    <td class="auto-style104"></td>
                </tr>
                <tr>
                    <td class="auto-style105">
                        </td>
                    <td class="auto-style106">
                        <asp:PlaceHolder ID="PostArea" runat="server"></asp:PlaceHolder>

                    </td>
                    <td class="auto-style107"></td>
                    <td class="auto-style108"></td>
                </tr>
                <tr>
                    <td class="auto-style87">&nbsp;</td>
                    <td class="auto-style52">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
                        
                    </td>
                    <td class="auto-style94">&nbsp;</td>
                    <td class="auto-style109">&nbsp;</td>
                </tr>
                </table>
        
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
    </form>
</body>
</html>
