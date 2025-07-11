<%@ Page Title="Profile" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Profile.aspx.cs" Inherits="UserProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: #f4f4f4;
        }

        .profile-container {
            max-width: 500px;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.15);
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            font-weight: 600;
            color: #333;
        }

        label {
            font-weight: 500;
            display: block;
            margin-top: 15px;
        }

        input[type="text"],
        input[type="email"],
        input[type="tel"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }

        .btn-save {
            margin-top: 25px;
            width: 100%;
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            font-weight: 600;
            border-radius: 8px;
            cursor: pointer;
        }

        .btn-save:hover {
            background-color: #45a049;
        }

        .message {
            text-align: center;
            margin-top: 20px;
            font-weight: 500;
            color: green;
        }
    </style>

    <div class="profile-container">
        <h2>My Profile</h2>
        
        <label>User ID</label>
        <asp:TextBox ID="txtUserId" runat="server" ReadOnly="true" />

        <label>Full Name</label>
        <asp:TextBox ID="txtFullName" runat="server" />

        <label>Email</label>
        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" />

        <label>Mobile Number</label>
        <asp:TextBox ID="txtMobile" runat="server" TextMode="Phone" />

        <label>Password</label>
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" />

        <asp:Button ID="btnSave" runat="server" Text="Save Changes" CssClass="btn-save" OnClick="btnSave_Click" />
        <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
    </div>
</asp:Content>
