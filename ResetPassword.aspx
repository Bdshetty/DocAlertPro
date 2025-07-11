<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ResetPassword.aspx.cs" Inherits="WebPages_ResetPassword" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>Reset Password - DocAlert</title>
    <style>
        .container {
            width: 400px;
            margin: 100px auto;
            padding: 30px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            font-family: Arial;
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
            border: 1px solid #ccc;
            border-radius: 6px;
        }
        .btn {
            width: 100%;
            padding: 10px;
            background: #2563eb;
            color: white;
            border: none;
            border-radius: 6px;
        }
        .message {
            text-align: center;
            color: red;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Reset Your Password</h2>
            <asp:Panel ID="pnlReset" runat="server" Visible="false">
                <div class="form-group">
                    <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" placeholder="New Password" />
                </div>
                <div class="form-group">
                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Confirm Password" />
                </div>
                <asp:Button ID="btnReset" runat="server" Text="Reset Password" CssClass="btn" OnClick="btnReset_Click" />
            </asp:Panel>
            <asp:Label ID="lblMessage" runat="server" CssClass="message" />
        </div>
    </form>
</body>
</html>
