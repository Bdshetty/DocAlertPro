<%@ Page Title="Home" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Com.aspx.cs" Inherits="Com" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Hidden user label -->
    <asp:Label ID="lblUserMid" runat="server" Text="12345" Visible="false" />

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            background: linear-gradient(to bottom right, #f0f4ff, #ffffff);
        }

        .hero {
            text-align: center;
            padding: 100px 30px 30px;
        }

        .hero h1 {
            font-size: 42px;
            color: #1a1a1a;
        }

        .hero h1 span {
            color: #6C63FF;
        }

        .hero p {
            font-size: 18px;
            color: #555;
            margin-top: 20px;
        }

        .hero .cta-btn {
            margin-top: 30px;
            padding: 15px 30px;
            background-color: #6C63FF;
            color: white;
            font-size: 16px;
            border-radius: 30px;
            text-decoration: none;
            display: inline-block;
            transition: 0.3s;
        }

        .hero .cta-btn:hover {
            background-color: #4d40b1;
        }

        .cards {
            display: flex;
            justify-content: center;
            margin-top: 50px;
            flex-wrap: wrap;
        }

        .card {
            background-color: white;
            border-radius: 15px;
            padding: 20px;
            margin: 15px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            width: 220px;
            transition: 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card h3 {
            margin: 0;
            color: #333;
        }

        .card p {
            margin: 10px 0;
            font-size: 14px;
            color: #555;
        }

        .card span {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
        }

        .alert { background: #ffe082; color: #a67c00; }
        .active { background: #c8e6c9; color: #388e3c; }
        .urgent { background: #ffcccb; color: #d32f2f; }

        .moving-text {
            background-color: #6C63FF;
            color: white;
            width: 100%;
            overflow: hidden;
            white-space: nowrap;
            box-sizing: border-box;
            padding: 10px 0;
            position: relative;
        }

        .moving-text span {
            display: inline-block;
            padding-left: 100%;
            animation: scrollText linear infinite;
            animation-duration: 20s;
        }

        @keyframes scrollText {
            0% { transform: translateX(0); }
            100% { transform: translateX(-100%); }
        }
    </style>

    <!-- Hero Section -->
    <div class="hero">
        <h1>Never Miss Your <span>Document Expiry</span> Dates Again</h1>
        <p>Get notified before your documents expire. Stay safe and organized with <br /> intelligent alerts for passports, licenses, certificates, and more.</p>
       <%-- <a href="Register.aspx" class="cta-btn">Get Started Free →</a>--%>

        <!-- Cards -->
        <div class="cards">
            <div class="card">
                <h3>📘 Passport</h3>
                <p>Expires in 45 days</p>
                <span class="alert">Alert Set</span>
            </div>
            <div class="card">
                <h3>🟩 License</h3>
                <p>Expires in 120 days</p>
                <span class="active">Active</span>
            </div>
            <div class="card">
                <h3>🟣 Certificate</h3>
                <p>Expires in 30 days</p>
                <span class="urgent">Urgent</span>
            </div>
        </div>
    </div>

    <!-- Moving Text -->
    <div class="moving-text">
        <span>📢 Stay on top of your document expiries with DocAlert Pro. Never miss a renewal! 🚀 | Secure | Reliable | Fast | Trusted by hundreds of users. 📢</span>
    </div>
</asp:Content>
