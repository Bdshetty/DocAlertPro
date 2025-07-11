<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ForgotPassword.aspx.cs" Inherits="WebPages_ForgotPassword" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>Forgot Password - DocAlert</title>
    <style>
        .container {
            width: 400px;
            margin: 100px auto;
            padding: 30px;
            border-radius: 10px;
            background: #fff;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            font-family: 'Segoe UI', sans-serif;
        }
        h2 {
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border-radius: 10px;
            border: 1px solid #ccc;
        }
        .btn {
            width: 100%;
            background-color: #6C63FF;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 30px;
            font-size: 16px;
            cursor: pointer;
        }
        .message {
            text-align: center;
            font-weight: bold;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Forgot Password</h2>

            <div class="form-group">
                <asp:TextBox ID="txtEmail" runat="server" placeholder="Enter your registered email" />
            </div>
            <asp:Button ID="btnSendCode" runat="server" Text="Send Code" CssClass="btn" OnClick="btnSendCode_Click" />

            <div class="form-group">
                <asp:TextBox ID="txtOTP" runat="server" placeholder="Enter verification code" />
            </div>
            <asp:Button ID="btnVerifyCode" runat="server" Text="Verify Code" CssClass="btn" OnClick="btnVerifyCode_Click" />

            <asp:Label ID="lblMessage" runat="server" CssClass="message" />
        </div>
    </form>
</body>
</html>
