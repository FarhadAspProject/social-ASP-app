<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="db_a27401_asp._home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Home</title>
    <style type="text/css">
        body {
            background-image: url("home_background.png");
        }
        .status_style  {
                
          width:953px;
          padding:10px;
          background-color:#EAF8EA;
          border: 0px solid white;
          margin: 0px;
            height: 577px;
        }
        .auto-style1 {
            width: 100%;
            height: 379px;
        }
        .auto-style2 {
            height: 23px;
        }
        .auto-style3 {
            width: 167px;
        }
        .auto-style4 {
            height: 23px;
            width: 167px;
        }
        .auto-style5 {
            width: 405px;
        }
        .auto-style6 {
            height: 23px;
            width: 405px;
        }
        .auto-style10 {
            width: 167px;
            height: 34px;
        }
        .auto-style11 {
            width: 405px;
            height: 34px;
        }
        .auto-style12 {
            height: 34px;
        }
        #Button1 {
            width: 94px;
            height: 28px;
        }
        #Text1 {
            width: 184px;
        }
        #Text2 {
            width: 185px;
        }
        #UserNameTB {
            width: 184px;
        }
        #PasswordTB {
            width: 185px;
        }
        .auto-style14 {
            width: 167px;
            height: 26px;
        }
        .auto-style15 {
            width: 405px;
            height: 26px;
        }
        .auto-style16 {
            height: 26px;
        }
    </style>
    <script type="text/javascript">

        function UsernameValidation() {

            var user = document.getElementById('<%=UsernameTextBox.ClientID%>').value;
            if ((user.length<1)||(/[<>=]/.test(user))) {             //That is amazing!!
                document.getElementById('<%=UserNameValidationMsg.ClientID%>').innerHTML = "Invalid charachterset!";
                return false;

            }
            else {
                document.getElementById('<%=UserNameValidationMsg.ClientID%>').innerHTML = "";
                return true;
            }

        }

        function PasswordValidation() {
            var pass = document.getElementById("PasswordTextBox").value;
            
            if ((pass.length<1)||(/[><=]/.test(pass))) {             //That is amazing!!
                document.getElementById('<%=PasswordValidationMsg.ClientID%>').innerHTML = "Invalid charachterset!";
                return false;

            }
            else {
                document.getElementById('<%=PasswordValidationMsg.ClientID%>').innerHTML = "";
                return true;
            }
        }

        function ValidateForm() {
            if (PasswordValidation() && UsernameValidation()) {
                document.getElementById('<%=FormValidateErrorMsg.ClientID%>').innerHTML = "";
                return true;
            }
            else {
                document.getElementById('<%=FormValidateErrorMsg.ClientID%>').innerHTML = "Please fix the errors!";
                return false;
            }
        }

      
    </script>
</head>
<body>

    <form id="form1" class="status_style" runat="server" style="width:100%; height:100%;
padding:0%;background-color: transparent;" onsubmit="return ValidateForm()">
        <table class="auto-style1" style="background-color:#EBEBE0; opacity: 0.9; height:80%;width:70%;padding:0%;
                margin-left:auto;margin-right:auto;margin-top:100px;">
            <tr>
                <td class="auto-style2"></td>
                <td class="auto-style4"></td>
                <td class="auto-style6"></td>
                <td class="auto-style2"></td>
                <td class="auto-style2"></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td class="auto-style3">&nbsp;</td>
                <td class="auto-style5">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td class="auto-style3" style="font-family: Arial, Helvetica, sans-serif; font-size: 16px">Enter your username:</td>
                <td class="auto-style5">
                    <asp:TextBox ID="UsernameTextBox" ToolTip="User name" runat="server" Width="182px" ClientIDMode="Static"></asp:TextBox>
                    <asp:Label ID="UserNameValidationMsg" runat="server"  ClientIDMode="Static"></asp:Label>
                </td>
                <td>Don&#39;t have an account?</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td class="auto-style3" style="font-family: Arial, Helvetica, sans-serif; font-size: 16px">&nbsp;</td>
                <td class="auto-style5">
                    &nbsp;</td>
                <td>
                    <input type="button" id="Button1"  onclick="location.href = 'registration.aspx';" value="Sign Up Here"  />
                    &nbsp;<br />
                    </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style16"></td>
                <td class="auto-style14" style="font-family: Arial, Helvetica, sans-serif; font-size: 16px" >Enter your password:</td>
                <td class="auto-style15">
                    <asp:TextBox ID="PasswordTextBox" runat="server" Width="179px" TextMode="Password" ClientIDMode="Static"></asp:TextBox>
                    
                    <asp:Label ID="PasswordValidationMsg" runat="server"  ClientIDMode="Static"></asp:Label>
                </td>
                <td class="auto-style16">It&#39;s Easy and free!!</td>
                <td class="auto-style16"></td>
            </tr>
            <tr>
                <td class="auto-style12"></td>
                <td class="auto-style10"></td>
                <td class="auto-style11" />
                    
                    <td class="auto-style12">&nbsp;</td>
                <td class="auto-style12"></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td class="auto-style3">&nbsp;</td>
                <td class="auto-style5">
                    <asp:Button ID="LoginButton" runat="server" Height="29px" OnClick="LoginButton_Click" Text="Log in" Width="97px" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Label ID="FormValidateErrorMsg" runat="server"  ClientIDMode="Static"></asp:Label>
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style2"></td>
                <td class="auto-style4"></td>
                <td class="auto-style6">
                </td>
                <td class="auto-style2">&nbsp;</td>
                <td class="auto-style2"></td>
            </tr>
            <tr>
                <td class="auto-style2"></td>
                <td class="auto-style4"></td>
                <td class="auto-style6">
                    
                    <asp:Label ID="LoginError" runat="server"></asp:Label>
                    
                </td>
                <td class="auto-style2"></td>
                <td class="auto-style2"></td>
            </tr>
            <tr>
                <td class="auto-style2"></td>
                <td class="auto-style4"></td>
                <td class="auto-style6">&nbsp;</td>
                <td class="auto-style2"></td>
                <td class="auto-style2"></td>
            </tr>
        </table>
    </form>
</body>
</html>
