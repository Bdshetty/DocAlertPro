<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>DocAlert Pro - Register</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <style>
        body {
            background: linear-gradient(to right, #f0f4ff, #ffffff);
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .container {
            width: 400px;
            background-color: #fff;
            margin: 60px auto;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
        }

        .logo {
            text-align: center;
            margin-bottom: 20px;
        }

        .logo .icon {
            display: inline-flex;
            background: linear-gradient(90deg, #0066FF, #A633FF);
            color: white;
            width: 40px;
            height: 40px;
            justify-content: center;
            align-items: center;
            border-radius: 10px;
            font-size: 18px;
        }

        .logo span {
            font-weight: bold;
            font-size: 24px;
            background: linear-gradient(90deg, #0066FF, #A633FF);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-left: 10px;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 5px;
        }

        p {
            text-align: center;
            color: #777;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            color: #555;
            margin-bottom: 5px;
            font-size: 14px;
        }

        .required {
            color: red;
            margin-left: 4px;
            font-weight: bold;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border-radius: 10px;
            border: 1px solid #ccc;
            outline: none;
        }

        .button-group {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }

        .submit-btn, .reset-btn {
            flex: 1;
            background-color: #6C63FF;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 30px;
            cursor: pointer;
            font-size: 16px;
            transition: 0.3s;
        }

        .reset-btn {
            background: linear-gradient(to right, #6C63FF, #A633FF);
        }

        .submit-btn:hover, .reset-btn:hover {
            background-color: #4d40b1;
        }

        .login-link {
            text-align: center;
            margin-top: 10px;
            font-size: 13px;
        }

        .login-link a {
            color: #6C63FF;
            text-decoration: none;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .footer {
            background-color: #101010;
            color: white;
            padding: 30px 20px 10px;
            margin-top: auto;
        }

        .footer-content {
            max-width: 1100px;
            margin: auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            padding-bottom: 15px;
        }

        .footer-left {
            display: flex;
            align-items: center;
        }

        .footer-left .icon {
            background: linear-gradient(90deg, #0066FF, #A633FF);
            color: white;
            width: 32px;
            height: 32px;
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: 8px;
            font-size: 16px;
        }

        .footer-left span {
            margin-left: 8px;
            font-weight: bold;
            font-size: 16px;
        }

        .footer-right a {
            color: #aaa;
            margin-left: 20px;
            text-decoration: none;
            font-size: 14px;
        }

        .footer-right a:hover {
            color: white;
        }

        .copyright {
            text-align: center;
            font-size: 12px;
            color: #888;
            margin-top: 10px;
        }

        .validator {
            color: red;
            font-size: 12px;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" />

        <div class="container">
            <div class="logo">
                <div class="icon"><i class="fa-regular fa-file-lines"></i></div>
                <span>DocAlert Pro</span>
            </div>
            <h2>Create Your Account</h2>
            <p>Join thousands who never miss document renewals</p>

            <div class="form-group">
                <label>Full Name<span class="required">*</span></label>
                <asp:TextBox ID="txtFullName" runat="server" placeholder="Enter your full name" />
                <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName"
                    ErrorMessage="Full Name is required" CssClass="validator" Display="Dynamic" />
            </div>

            <div class="form-group">
                <label>Email Address<span class="required">*</span></label>
                <asp:TextBox ID="txtEmail" runat="server" placeholder="Enter your email" />
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                    ErrorMessage="Email is required" CssClass="validator" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                    ValidationExpression="^\S+@\S+\.\S+$" ErrorMessage="Invalid email format" CssClass="validator" Display="Dynamic" />
            </div>

            <div class="form-group">
                <label>Mobile Number<span class="required">*</span></label>
                <asp:TextBox ID="txtMobile" runat="server" placeholder="Enter your mobile number" />
                <ajaxToolkit:FilteredTextBoxExtender ID="fteMobile" runat="server" TargetControlID="txtMobile" FilterType="Numbers" />
                <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ControlToValidate="txtMobile"
                    ErrorMessage="Mobile number is required" CssClass="validator" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revMobile" runat="server" ControlToValidate="txtMobile"
                    ValidationExpression="^\d{10}$" ErrorMessage="Enter valid 10-digit mobile number" CssClass="validator" Display="Dynamic" />
            </div>

            <div class="form-group">
                <label>User ID<span class="required">*</span></label>
                <asp:TextBox ID="txtUserID" runat="server" placeholder="Choose a unique user ID" />
                <asp:RequiredFieldValidator ID="rfvUserID" runat="server" ControlToValidate="txtUserID"
                    ErrorMessage="User ID is required" CssClass="validator" Display="Dynamic" />
            </div>

            <div class="form-group">
                <label>Password<span class="required">*</span></label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Create a strong password" />
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                    ErrorMessage="Password is required" CssClass="validator" Display="Dynamic" />
            </div>

            <div class="form-group">
                <label>Confirm Password<span class="required">*</span></label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Confirm your password" />
                <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword"
                    ErrorMessage="Confirm Password is required" CssClass="validator" Display="Dynamic" />
            </div>

            <div class="button-group">
                <asp:Button ID="btnRegister" runat="server" Text="Sign Up" CssClass="submit-btn" OnClick="btnRegister_Click" />
                <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="reset-btn" OnClick="btnReset_Click" />
            </div>

            <div class="login-link">
                Already have an account? <a href="Login.aspx">Login here</a>
            </div>
        </div>

        <div class="footer">
            <div class="footer-content">
                <div class="footer-left">
                    <div class="icon"><i class="fa-regular fa-file-lines"></i></div>
                    <span>DocAlert Pro</span>
                </div>
                <div class="footer-right">
                    <a href="#">About</a>
                    <a href="#">Contact</a>
                    <a href="#">Privacy Policy</a>
                </div>
            </div>
            <div class="copyright">
                © 2024 DocAlert Pro. All rights reserved.
            </div>
        </div>
    </form>
</body>
</html>
