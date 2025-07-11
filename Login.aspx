<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>DocAlert Pro - Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <style>
        body {
            background: linear-gradient(to right, #f0f4ff, #ffffff);
            font-family: 'Segoe UI', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background-color: #fff;
            padding: 40px 30px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            width: 350px;
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

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            font-size: 14px;
            color: #444;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border-radius: 10px;
            border: 1px solid #ccc;
            margin-top: 5px;
        }

        .captcha-box {
            background-color: #f0f0f0;
            padding: 12px 20px;
            font-weight: bold;
            border-radius: 8px;
            font-family: monospace;
            font-size: 24px;
            text-align: center;
            width: 140px;
            letter-spacing: 4px;
            border: 2px dashed #888;
        }

        .refresh-icon {
            color: #6C63FF;
            font-size: 16px;
            padding: 4px;
            border: none;
            background: none;
            cursor: pointer;
            transition: transform 0.2s ease;
        }

        .refresh-icon:hover {
            transform: rotate(180deg);
            color: #A633FF;
        }

        .button-group {
            display: flex;
            justify-content: space-between;
            gap: 10px;
            margin-top: 10px;
        }

        .submit-btn, .reset-btn {
            flex: 1;
            padding: 12px;
            border-radius: 30px;
            font-size: 16px;
            cursor: pointer;
            border: none;
            transition: 0.3s;
        }

        .submit-btn {
            background: linear-gradient(to right, #6C63FF, #A633FF);
            color: white;
        }

        .reset-btn {
            background-color: #f1f1f1;
            color: #333;
            border: 1px solid #ccc;
        }

        .submit-btn:hover {
            background-color: #4d40b1;
        }

        .reset-btn:hover {
            background-color: #ddd;
        }

        .forgot-link {
            text-align: center;
            margin-top: 10px;
        }

        .forgot-link a {
            color: #6C63FF;
            font-size: 13px;
            text-decoration: none;
        }

        .forgot-link a:hover {
            text-decoration: underline;
        }

        .register-link {
            text-align: center;
            font-size: 13px;
            margin-top: 20px;
            border-top: 1px solid #ddd;
            padding-top: 10px;
        }

        .register-link a {
            color: #6C63FF;
            text-decoration: none;
            font-weight: bold;
        }

        .register-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="logo">
                <div class="icon"><i class="fa-regular fa-file-lines"></i></div>
                <span>DocAlert Pro</span>
            </div>
            <asp:Label ID="lblUserMid" runat="server" Visible="false"></asp:Label>

            <div class="form-group">
                <label>User ID</label>
                <asp:TextBox ID="txtUserID" runat="server" placeholder="Enter User ID"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter Password"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>CAPTCHA</label>
                <div style="display: flex; align-items: center; gap: 10px;">
                    <asp:Label ID="lblCaptcha" runat="server" CssClass="captcha-box"></asp:Label>
                    <asp:LinkButton ID="btnRefreshCaptcha" runat="server" CssClass="refresh-icon" OnClick="btnRefreshCaptcha_Click" ToolTip="Refresh CAPTCHA">
                        <i class="fa fa-refresh"></i>
                    </asp:LinkButton>
                </div>
            </div>

            <div class="form-group">
                <label>Enter CAPTCHA</label>
                <asp:TextBox ID="txtCaptchaInput" runat="server" placeholder="Enter CAPTCHA shown above"></asp:TextBox>
            </div>

            <div class="button-group">
                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="submit-btn" OnClick="btnLogin_Click" />
                <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="reset-btn" OnClick="btnReset_Click" />
            </div>

            <div class="forgot-link">
                <a href="ForgotPassword.aspx">Forgot Password?</a>
            </div>

            <div class="register-link">
                Don’t have an account? <a href="Register.aspx">Sign Up</a>
            </div>
        </div>
    </form>
</body>
</html>
