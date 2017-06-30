﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewMessagePage.aspx.cs" Inherits="db_a27401_asp.NewMessagePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .status_style  {
                
          width:260px;
          height:auto;
          padding:10px;
          background-color:#e6f7ff;
          border: 4px solid white ;
          margin: 5px;
        }
        .auto-style1 {
            width: 539px;
        }
        .auto-style3 {
            width: 343px;
        }
        .auto-style5 {
            width: 344px;
        }
        .auto-style6 {
            width: 612px;
        }
        .auto-style7 {
            width: 345px;
        }
        .auto-style8 {
            width: 397px;
        }
        .auto-style9 {
            width: 612px;
            height: 31px;
        }
        .auto-style10 {
            height: 31px;
        }
        .auto-style11 {
            height: 31px;
            width: 132px;
        }
        .auto-style12 {
            width: 132px;
        }
        #MsgReplyButton {
            width: 72px;
        }
        #Text1 {
            width: 298px;
            height: 24px;
            margin-top: 0px;
        }
        #UserNameValidationMsg {
            height: 21px;
        }
    </style>
    <script src="Scripts/jquery-1.10.2.min.js" ></script>
    <!--Reference the SignalR library. -->
    <script src="Scripts/jquery.signalR-2.0.0.min.js"></script>
    <!--Reference the autogenerated SignalR hub script. -->
    <script src="signalr/hubs"></script>
    <script type="text/javascript">



        $(function () {

            var chat = $.connection.myHub1;
            var UserToVar = $('#UserTo').html();
            var UserFromVar = $('#UserFrom').html();
            //alert(UserFromVar);

            $.connection.hub.qs = { "userName": UserFromVar };

            // updateMessage() function not needed here because RT msg update won't ne needed in thid page

            // Function that will be called on the browser of local client
            $.connection.hub.start().done(function () {

                $('#MsgReplyButton').click(function () {

                    var UserToVar = $("#user_to").val();
                    var UserFromVar = $('#UserFrom').html();

                    //window.alert(String(user));

                    ajaxCheckUser(String(UserToVar));

                    //window.alert($("#UserNameValidationMsg").text());

                    if ($("#UserNameValidationMsg").text() != "Username found!") {
                        window.alert("Invalid username!");

                    }
                    else if (UserToVar == UserFromVar) {
                        window.alert("You can't send messages to yourself!!");
                    }
                    else {

                        

                        var currentdate = new Date();
                        var datetime = currentdate.getHours() + ":"
                                        + currentdate.getMinutes() + ":"
                                        + currentdate.getSeconds() + " , "
                                        + currentdate.getDate() + "/"
                                        + (currentdate.getMonth() + 1) + "/"
                                        + currentdate.getFullYear();

                        // Initiating Ajax and other server broadcast methods

                        ajaxPostMsg(String(UserFromVar), String(UserToVar), String($('#<%=NewMsgTextBox.ClientID%>').val()));

                        chat.server.broadcastMessage(String(UserFromVar), String(UserToVar), String($('#<%=NewMsgTextBox.ClientID%>').val()));

                        alert("Message sent!");

                        $('#<%=NewMsgTextBox.ClientID%>').val("");
                        $("#user_to").val("");




                        // local browser operations
                    }


                    
                });
            });
        });

        // Ajax method for database operations

        function ajaxPostMsg(userFROM, userTO, msgTEXT) {
            $.ajax({
                type: 'POST',
                url: 'inboxPage.aspx/sendMessageToDb',//make "CheckUser" lower case or it won't work!!!!!
                data: JSON.stringify({ userFrom: userFROM, userTo: userTO, msgText: msgTEXT }),
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {

                    //alert(msg.d);
                }
            });

        }

        function ajaxCheckUser(user) {
            $.ajax({
                type: 'POST',
                url: 'NewMessagePage.aspx/checkuser',     //make "CheckUser" lower case here or it won't work!!!!!
                data: JSON.stringify({ userName: user }),
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {

                    //alert(String(msg.d));
                    $("#UserNameValidationMsg").html(msg.d);
                }
            });

        }

        // the following method is redundant but is kept for function scope understading 

        function UserNameValidation() {

            var user = $("#user_to").val();
            
            ajaxCheckUser(user);
            if ($("#UserNameValidationMsg").text() == "Username found!") {
                //alert("Username Found!");
                return true;
            }
            else {
                //alert("Username not found!");
                return false;
            }
            

        }

    </script>
</head>
<body>
    <form id="form1" style="width:100%;height:100%;padding:10%; background-color:#e6f7ff;" runat="server" >
    
        
        <table class="auto-style1" style="width:80%;height: 441px; background-color:#EBEBE0;">
                <tr>
                    <td class="auto-style8" rowspan="14"style="vertical-align:top;">
                        <asp:HyperLink ID="ToNewsfeed" runat="server" ImageHeight="20px" ImageUrl="icon_images/icon_newsfeed.png" ImageWidth="20px" NavigateUrl="loggedIn.aspx"></asp:HyperLink>
                        <asp:HyperLink ID="ToNewsfeedText" runat="server" NavigateUrl="~/loggedIn.aspx">Newsfeed</asp:HyperLink>
                        <br />
                        <br />
                        <asp:Button ID="InboxMsgButton"  OnClick="InboxMsgButton_Click"  Text="Inbox" runat="server" Height="23px" Width="83px" style="margin-top: 2px" />
                        <br />
                        <br />
                         Previous conversations<br />
                        <br />
                        <asp:Panel ID="PreConvArea_" runat="server" Height="400px" ScrollBars="Vertical" Width="245px">
                        </asp:Panel>
                        
                    </td>
                    <td class="auto-style6">
                        &nbsp;Send message to :</td>
                    <td class="auto-style12">
                        &nbsp;<a href="loggedIn.aspx"><img alt="" src="/icon_images/icon_notification.png" style="height: 24px; width: 26px; margin-top: 4px" id="notification_image" /></a>&nbsp;&nbsp; <a href="loggedIn.aspx" ><img alt="icon_images" src="icon_images/icon_friendrequest.png" style="height: 23px; width: 22px" id="photo_image0" /></a></td>
                    <td class="auto-style76">
                        <asp:Button ID="LogoutButton" Text="Log out" OnClick="LogoutButton_ClickMethod" runat="server" Height="23px" style="margin-top: 0px" Width="59px" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">

                        <!--.///////////////////////////////.Hidden div for user names//////////////////////////// .-->

                        <div id="UserFrom" style="width: 99px;display: none" runat="server">
                        </div>

                        <input id="user_to" type="text" runat="server" onchange="UserNameValidation()" /></td>
                    <td class="auto-style12">
                        <asp:Button ID="ProfileButton" runat="server" Text="Button" Width="132px" />
                        </td>
                    <td class="auto-style7"></td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        
                        <div id="UserNameValidationMsg" style="width: 282px;">
                        </div>
                    </td>
                    <td class="auto-style12">
                        </td>
                    <td class="auto-style100"></td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:TextBox ID="NewMsgTextBox" runat="server" Height="67px" Width="302px" TextMode="MultiLine"></asp:TextBox>
                    </td>
                    <td class="auto-style12"> 
                    </td>
                    <td class="auto-style3"></td>
                </tr>
                <tr>
                    <td class="auto-style6"> 
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:FileUpload ID="PostFileUploadBox" runat="server" style="margin-bottom: 0px" /> 
                    </td>
                    <td class="auto-style12"> 
                        &nbsp;</td>
                    <td class="auto-style100"></td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input id="MsgReplyButton" type="button" value="Send" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                    <td class="auto-style12"></td>
                    <td class="auto-style76"></td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        &nbsp;</td>
                    <td class="auto-style12"></td>
                    <td class="auto-style104"></td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        &nbsp;</td>
                    <td class="auto-style12"></td>
                    <td class="auto-style108"></td>
                </tr>
                <tr>
                    <td class="auto-style6"></td>
                    <td class="auto-style12"></td>
                    <td class="auto-style5"></td>
                </tr>
                <tr>
                    <td class="auto-style6">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
                    <td class="auto-style12"></td>
                    <td class="auto-style81"></td>
                </tr>
                <tr>
                    <td class="auto-style6">&nbsp;
                        
                    </td>
                    <td class="auto-style12"></td>
                    <td class="auto-style82"></td>
                </tr>
                <tr>
                    <td class="auto-style6"></td>
                    <td class="auto-style12"></td>
                    <td class="auto-style81"></td>
                </tr>
                <tr>
                    <td class="auto-style6">&nbsp;</td>
                    <td class="auto-style12">&nbsp;</td>
                    <td class="auto-style109">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style9"></td>
                    <td class="auto-style11"></td>
                    <td class="auto-style10"></td>
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
