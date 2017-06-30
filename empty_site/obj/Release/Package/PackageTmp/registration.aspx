<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="registration.aspx.cs" Inherits="db_a27401_asp.registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registration</title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
            border-color: #FFFFCC;
            margin-right: 0px;
            background-color: #CCFFFF;
            margin-top: 0px;
        }
         body {
            background-image: url("home_background.png");
        }
        .auto-style67 {
            height: 27px;
            width: 10px;
        }
        .auto-style68 {
            height: 22px;
            width: 10px;
        }
        .auto-style69 {
            width: 10px;
        }
        .auto-style70 {
            height: 24px;
            width: 10px;
        }
        .auto-style71 {
            height: 34px;
            width: 10px;
        }
        #Text1 {
            width: 193px;
        }
        #Text2 {
            width: 192px;
        }
        #Passwordtext {
            width: 186px;
            margin-left: 0px;
        }
        #RepeatPasswordtext {
            width: 184px;
        }
        #Password1 {
            width: 183px;
        }
        .auto-style103 {
            height: 30px;
            width: 10px;
        }
        .auto-style108 {
            height: 29px;
            width: 10px;
        }
        .auto-style113 {
            width: 10px;
            height: 26px;
        }
        #UserNameTB {
            width: 184px;
        }
        #PasswordTB {
            width: 182px;
        }
        #UserNameTB0 {
            width: 184px;
        }
        #PhoneNumberTB {
            width: 184px;
        }
        .auto-style118 {
            width: 10px;
            height: 25px;
        }
        .auto-style123 {
            height: 27px;
            width: 133px;
        }
        .auto-style124 {
            height: 22px;
            width: 133px;
        }
        .auto-style125 {
            width: 133px;
        }
        .auto-style126 {
            height: 24px;
            width: 133px;
        }
        .auto-style127 {
            width: 133px;
            height: 25px;
        }
        .auto-style128 {
            height: 34px;
            width: 133px;
        }
        .auto-style129 {
            width: 133px;
            height: 26px;
        }
        .auto-style130 {
            height: 30px;
            width: 133px;
        }
        .auto-style131 {
            height: 29px;
            width: 133px;
        }
        .auto-style141 {
            height: 27px;
            width: 176px;
        }
        .auto-style142 {
            height: 22px;
            width: 176px;
        }
        .auto-style143 {
            width: 176px;
        }
        .auto-style144 {
            height: 24px;
            width: 176px;
        }
        .auto-style145 {
            width: 176px;
            height: 25px;
        }
        .auto-style146 {
            height: 34px;
            width: 176px;
        }
        .auto-style147 {
            width: 176px;
            height: 26px;
        }
        .auto-style148 {
            height: 30px;
            width: 176px;
        }
        .auto-style149 {
            height: 29px;
            width: 176px;
        }
        .auto-style160 {
            height: 32px;
            width: 10px;
        }
        .auto-style161 {
            height: 32px;
            width: 133px;
        }
        .auto-style163 {
            height: 32px;
            width: 176px;
        }
        #Button1 {
            width: 98px;
            height: 30px;
        }
        .auto-style175 {
            height: 20px;
        }
        .auto-style177 {
            height: 27px;
            width: 185px;
        }
        .auto-style178 {
            height: 22px;
            width: 185px;
        }
        .auto-style179 {
            width: 185px;
        }
        .auto-style180 {
            height: 24px;
            width: 185px;
        }
        .auto-style181 {
            width: 185px;
            height: 25px;
        }
        .auto-style182 {
            height: 34px;
            width: 185px;
        }
        .auto-style183 {
            width: 185px;
            height: 26px;
        }
        .auto-style184 {
            height: 30px;
            width: 185px;
        }
        .auto-style185 {
            height: 29px;
            width: 185px;
        }
        .auto-style186 {
            height: 32px;
            width: 185px;
        }
        .auto-style187 {
            height: 27px;
            width: 39px;
        }
        .auto-style188 {
            height: 22px;
            width: 39px;
        }
        .auto-style190 {
            height: 24px;
            width: 39px;
        }
        .auto-style191 {
            width: 39px;
            height: 25px;
        }
        .auto-style192 {
            height: 34px;
            width: 39px;
        }
        .auto-style193 {
            width: 39px;
            height: 26px;
        }
        .auto-style194 {
            height: 30px;
            width: 39px;
        }
        .auto-style195 {
            height: 29px;
            width: 39px;
        }
        .auto-style196 {
            height: 32px;
            width: 39px;
        }
        .auto-style197 {
            width: 39px;
        }
    </style>
    <script type='text/javascript' src="jquery-1.11.3.js"></script>

    <script type="text/javascript">

        
      
        function RBmale_changed() {
            document.getElementById("CheckBoxFemale").checked = false;
        }
        function RBfemale_changed() {
            document.getElementById("CheckBoxMale").checked = false;
        }

        function PasswordError()
        {
            var pass = document.getElementById("PasswordTB").value;
            var repass = document.getElementById("RepeatPasswordtext").value;
            
            if ((pass != repass) && (pass.length>1)) {
                document.getElementById("PasswordErrorMsg").innerHTML = "Passwords don't match!";
                return false;
            }
            else {
                document.getElementById("PasswordErrorMsg").innerHTML = "";
                return true;
            }
        }

        // Ajax method called by the client browser

        function ajaxReq(user) {          
            $.ajax({
                type: 'POST',
                url: 'registration.aspx/checkuser',     //make "CheckUser" lower case here or it won't work!!!!!
                data: JSON.stringify({userName:user}),
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {

                    $("#UserNameValidationMsg").html(msg.d);
                }
            });
            
        }

        function UserNameValidation()
        {

            var user = $("#UserNameTB").val();
            if ((/[><=@%^&|~]/.test(user))) {             //That is amazing!!
                
                $("#UserNameValidationMsg").html("Some characters are not allowd!");
                return false;

            }
            
            else {
                ajaxReq(user);
                if ($("#UserNameValidationMsg").text() == "Username Available") {
                    return true;
                }
                else {                    
                    return false;
                }
            }

        }

        function PasswordValidation() {
            var pass = document.getElementById("PasswordTB").value;
            if ((/[><=%^&|@~]/.test(pass))) {             //That is amazing!!
                $("#PasswordWeakMsg").html("Some characters are not allowd!");
                return false;
            }
            else if (pass.length < 6) {
                $("#PasswordWeakMsg").html("At least 6 characters!");
                return false;
            }
            else {
                document.getElementById("PasswordWeakMsg").innerHTML = "";
                return true;
            }
        }

        function PhoneNumberValidation() {
            var num=document.getElementById("PhoneNumberTB").value;
            if ((/[^0-9+-]/.test(num))) {             //That is amazing!!RegExp
                document.getElementById("PhoneNumberValidationMsg").innerHTML = "Invalid number!";
                return false;
            }
            else {
                document.getElementById("PhoneNumberValidationMsg").innerHTML = "";
                return false;

            }
            

        }

        function ValidateForm()
        {
            if (PasswordValidation() && PasswordError() && UserNameValidation())
            {
                alert("Registration Successful! Now login please.");
                return true;
            }
            else {
                FormValidateErrorMsg.innerHTML = "Please fix the errors.";
                return false;
            }
        }
    </script>

</head>




<body>
    
    
    <form id="UserRegistrationForm" runat="server" style="width:100%;height:100%;padding:0%;
background-color:transparent"  onsubmit="return ValidateForm()">
        &nbsp;<table class="auto-style1" style="width:80%;height:70%;background-color:#EBEBE0;opacity: 0.9;
        margin-left:auto;margin-right:auto; margin-top:100px;"; >
            <tr>
                <td class="auto-style67">&nbsp;</td>
                <td class="auto-style123"></td>
                <td class="auto-style177"></td>
                <td class="auto-style141"></td>
                <td class="auto-style187"></td>
            </tr>
            <tr>
                <td class="auto-style68"></td>
                <td class="auto-style124"></td>
                <td class="auto-style178">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; First name</td>
                <td class="auto-style142">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Middle name &nbsp;</td>
                <td class="auto-style188">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Last&nbsp;&nbsp; name</td>
            </tr>
            <tr>
                <td class="auto-style69"></td>
                <td class="auto-style125">Enter your name here</td>
                <td class="auto-style179">
                    <asp:TextBox ID="FirstNameTextBox" runat="server" Width="188px"></asp:TextBox>
                </td>
                <td class="auto-style143">
                    <asp:TextBox ID="MiddleNameTextBox" runat="server" Width="168px"></asp:TextBox>
                </td>
                <td class="auto-style197">
                    <asp:TextBox ID="LastNameTextBox" runat="server" Width="179px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style70"></td>
                <td class="auto-style126">Your Email</td>
                <td class="auto-style180">
                    <asp:TextBox ID="EmailTextBox" runat="server" Width="188px"></asp:TextBox>
                </td>
                <td class="auto-style144"></td>
                <td class="auto-style190"></td>
            </tr>
            <tr>
                
                <td class="auto-style118"></td>
                <td class="auto-style127">Your Gender</td>
                <td class="auto-style181">
                    
                     <input id="CheckBoxFemale" runat="server"  type="checkbox" onchange="RBfemale_changed()" />&nbsp;&nbsp;&nbsp; Female</td>
                    
                <td class="auto-style145">
                     
                    
                    <input id="CheckBoxMale" runat="server"  type="checkbox" onchange="RBmale_changed()"  />&nbsp;&nbsp;&nbsp; Male</td>
                <td class="auto-style191"></td>
            </tr>
            <tr>
                <td class="auto-style71"></td>
                <td class="auto-style128">Date of birth</td>
                <td class="auto-style182">&nbsp;Day&nbsp;
                    <asp:DropDownList ID="DropDownList2" runat="server" Width="67px">
                        <asp:ListItem>1</asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                        <asp:ListItem>4</asp:ListItem>
                        <asp:ListItem>5</asp:ListItem>
                        <asp:ListItem>6</asp:ListItem>
                        <asp:ListItem>7</asp:ListItem>
                        <asp:ListItem>8</asp:ListItem>
                        <asp:ListItem>9</asp:ListItem>
                        <asp:ListItem>10</asp:ListItem>
                        <asp:ListItem>11</asp:ListItem>
                        <asp:ListItem>12</asp:ListItem>
                        <asp:ListItem>13</asp:ListItem>
                        <asp:ListItem>14</asp:ListItem>
                        <asp:ListItem>15</asp:ListItem>
                        <asp:ListItem>16</asp:ListItem>
                        <asp:ListItem>17</asp:ListItem>
                        <asp:ListItem>18</asp:ListItem>
                        <asp:ListItem>19</asp:ListItem>
                        <asp:ListItem>20</asp:ListItem>
                        <asp:ListItem>21</asp:ListItem>
                        <asp:ListItem>22</asp:ListItem>
                        <asp:ListItem>23</asp:ListItem>
                        <asp:ListItem>24</asp:ListItem>
                        <asp:ListItem>25</asp:ListItem>
                        <asp:ListItem>26</asp:ListItem>
                        <asp:ListItem>27</asp:ListItem>
                        <asp:ListItem>28</asp:ListItem>
                        <asp:ListItem>29</asp:ListItem>
                        <asp:ListItem>30</asp:ListItem>
                        <asp:ListItem>31</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="auto-style146">Month&nbsp;
                    <asp:DropDownList ID="DropDownList1" runat="server">
                        <asp:ListItem Value="1">January</asp:ListItem>
                        <asp:ListItem Value="2">February</asp:ListItem>
                        <asp:ListItem Value="3">March</asp:ListItem>
                        <asp:ListItem Value="4">April</asp:ListItem>
                        <asp:ListItem>May</asp:ListItem>
                        <asp:ListItem Value="6">June</asp:ListItem>
                        <asp:ListItem Value="7">July</asp:ListItem>
                        <asp:ListItem Value="8">August</asp:ListItem>
                        <asp:ListItem Value="9">September</asp:ListItem>
                        <asp:ListItem Value="10">October</asp:ListItem>
                        <asp:ListItem Value="11">November</asp:ListItem>
                        <asp:ListItem Value="12">December</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="auto-style192">Year
                    <asp:DropDownList ID="DropDownList3" runat="server">
                        <asp:ListItem>1975</asp:ListItem>
                        <asp:ListItem Value="1976"></asp:ListItem>
                        <asp:ListItem Value="1977"></asp:ListItem>
                        <asp:ListItem Value="this.index+1">1978</asp:ListItem>
                        <asp:ListItem>1979</asp:ListItem>
                        <asp:ListItem>1980</asp:ListItem>
                        <asp:ListItem Value="1981"></asp:ListItem>
                        <asp:ListItem Value="1982"></asp:ListItem>
                        <asp:ListItem>1983</asp:ListItem>
                        <asp:ListItem>1984</asp:ListItem>
                        <asp:ListItem>1985</asp:ListItem>
                        <asp:ListItem>1986</asp:ListItem>
                        <asp:ListItem>1987</asp:ListItem>
                        <asp:ListItem>1988</asp:ListItem>
                        <asp:ListItem>1989</asp:ListItem>
                        <asp:ListItem>1990</asp:ListItem>
                        <asp:ListItem>1991</asp:ListItem>
                        <asp:ListItem>1992</asp:ListItem>
                        <asp:ListItem>1993</asp:ListItem>
                        <asp:ListItem>1994</asp:ListItem>
                        <asp:ListItem>1995</asp:ListItem>
                        <asp:ListItem>1996</asp:ListItem>
                        <asp:ListItem>1997</asp:ListItem>
                        <asp:ListItem>1998</asp:ListItem>
                        <asp:ListItem>1999</asp:ListItem>
                        <asp:ListItem>2000</asp:ListItem>
                        <asp:ListItem>2001</asp:ListItem>
                        <asp:ListItem>2002</asp:ListItem>
                        <asp:ListItem>2003</asp:ListItem>
                        <asp:ListItem>2004</asp:ListItem>
                        <asp:ListItem>2005</asp:ListItem>
                        <asp:ListItem>2006</asp:ListItem>
                        <asp:ListItem>2007</asp:ListItem>
                        <asp:ListItem>2008</asp:ListItem>
                        <asp:ListItem>2009</asp:ListItem>
                        <asp:ListItem>2010</asp:ListItem>
                        <asp:ListItem>2011</asp:ListItem>
                        <asp:ListItem>2012</asp:ListItem>
                        <asp:ListItem>2013</asp:ListItem>
                        <asp:ListItem>2014</asp:ListItem>
                        <asp:ListItem>2015</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="auto-style113"></td>
                <td class="auto-style129">Phone Nunmber</td>
                <td class="auto-style183" >
                   
                    <input id="PhoneNumberTB" type="text" runat="server" onchange="PhoneNumberValidation()" /></td>
                <td class="auto-style147">
                   
                    <div id="PhoneNumberValidationMsg" style="width: 176px">
                    </div>
                   
                    </td>
                <td class="auto-style193"></td>
            </tr>
            <tr>
                <td class="auto-style103"></td>
                <td class="auto-style130">Choose an username</td>
                <td class="auto-style184">
                   
                    <input id="UserNameTB" type="text" runat="server" onchange="UserNameValidation()" /></td>
                <td class="auto-style148">
                   
                    <div id="UserNameValidationMsg" style="width: 176px">
                    </div>
                   
                </td>
                <td class="auto-style194">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style108"></td>
                <td class="auto-style131">
                    
                    <div id="UserAvailableMsg" style="width: 175px">
                    </div>
                   
                </td>
                <td class="auto-style185">
                    
                    &nbsp;</td>
                <td class="auto-style149">
                   
                    &nbsp;</td>
                <td class="auto-style195">
                    
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style160"></td>
                <td class="auto-style161">Choose a password</td>
                <td class="auto-style186">
                    
                    <input id="PasswordTB" type="password" runat="server" onkeyup="PasswordValidation()" /></td>
                <td class="auto-style163">
                   
                    <div id="PasswordWeakMsg" style="width: 175px">
                    </div>
                   
                </td>
                <td class="auto-style196">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style160"></td>
                <td class="auto-style161">Repeat password</td>
                <td class="auto-style186">
                    
                    <input id="RepeatPasswordtext" type="password" onchange="PasswordError()" /></td>
                <td class="auto-style163">
                   
                    <div id="PasswordErrorMsg" style="width: 175px">
                    </div>
                   
                </td>
                <td class="auto-style196">
                    </td>
            </tr>
            <tr>
                <td class="auto-style160">
                    
                    &nbsp;</td>
                <td class="auto-style161">
                    &nbsp;</td>
                <td class="auto-style186">
                    
                    <div id="FormValidateErrorMsg" style="width: 236px">
                    </div>
                   
                    </td>
                <td class="auto-style163">
                   
                    </td>
                <td class="auto-style196">
                    </td>
            </tr>
            <tr>
                <td class="auto-style160">&nbsp;</td>
                <td class="auto-style161">
                    &nbsp;</td>
                <td class="auto-style186">
                    
                    <asp:Button ID="RegistrationButton" runat="server" OnClick="RegistrationButton_Click" Text="Register" Width="113px" Height="32px" />
                </td>
                <td class="auto-style163">
                    
                   
    <input type="button" id="Button1"  onclick="location.href='home.aspx';" value="Log in page"  />
    
                </td>
                <td class="auto-style196">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style175">&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            </table>
        
                    
                   
    </form>
        
</body>
</html>
