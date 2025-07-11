<%--<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>--%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>DocAlert Pro - Home</title>
    <link href="Assets/css/style.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            background: linear-gradient(to bottom right, #f0f4ff, #ffffff);
        }

        /* Navbar */
        .navbar {
            background-color: #ffffff;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            position: sticky;
            top: 0;
            z-index: 100;
        }

            .navbar .logo {
                display: flex;
                align-items: center;
                font-weight: bold;
                font-size: 20px;
                color: #4a00e0;
            }

                .navbar .logo i {
                    background: linear-gradient(to right, #4a00e0, #8e2de2);
                    color: white;
                    padding: 8px;
                    border-radius: 10px;
                    margin-right: 10px;
                }


            .navbar .buttons a {
                text-decoration: none;
                margin-left: 15px;
                padding: 8px 16px;
                border-radius: 20px;
                border: 1px solid #6C63FF;
                color: #6C63FF;
                transition: 0.3s;
            }

                .navbar .buttons a.login {
                    background-color: #6C63FF;
                    color: white;
                }

                .navbar .buttons a:hover {
                    background-color: #6C63FF;
                    color: white;
                }

        /* Hero Section */
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

        .alert {
            background: #ffe082;
            color: #a67c00;
        }

        .active {
            background: #c8e6c9;
            color: #388e3c;
        }

        .urgent {
            background: #ffcccb;
            color: #d32f2f;
        }

        /* Moving Text */
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
                animation-duration: calc(20s / var(--speed));
            }

        @keyframes scrollText {
            0% {
                transform: translateX(0);
            }

            100% {
                transform: translateX(-100%);
            }
        }

        /* Footer Styles */
        .footer {
            background-color: #2c2c2c;
            color: white;
            padding: 40px 30px 10px;
            text-align: center;
        }

            .footer .footer-box-container {
                display: flex;
                justify-content: center;
                gap: 50px;
                flex-wrap: wrap;
                margin-bottom: 20px;
            }

            .footer .box h3 {
                font-size: 20px;
                margin-bottom: 10px;
                color: #ffffff;
            }

            .footer .box a {
                display: block;
                text-decoration: none;
                color: #ccc;
                margin: 5px 0;
                transition: 0.3s;
            }

                .footer .box a:hover {
                    color: #6C63FF;
                }

                .footer .box a i {
                    margin-right: 8px;
                }

        .copyright {
            color: #aaa;
            font-size: 14px;
            margin-top: 10px;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <!-- Navbar -->
        <div class="navbar">
            <div class="logo">
                <i class="fa fa-file-alt"></i>DocAlert Pro
            </div>
            <div class="buttons">
                <a class="login" href="Login.aspx">Login</a>
                <a href="Register.aspx">Sign Up</a>
            </div>
        </div>


        <!-- Hero Section -->
        <div class="hero">
            <h1>Never Miss Your <span>Document Expiry</span> Dates Again</h1>
            <p>
                Get notified before your documents expire. Stay safe and organized with
                <br />
                intelligent alerts for passports, licenses, certificates, and more.
            </p>
            <a href="Register.aspx" class="cta-btn">Get Started Free →</a>

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
        <div class="moving-text" style="--speed: 1" data-speed="1">
            <span>📢 Stay on top of your document expiries with DocAlert Pro. Never miss a renewal! 🚀 | Secure | Reliable | Fast | Trusted by hundreds of users. 📢</span>
        </div>

        <!-- Footer -->
        <section class="footer">
            <div class="footer-box-container">
                <div class="box">
                    <h3>Contact Us</h3>
                    <a href="tel:+916361141710"><i class="fa-solid fa-phone"></i>+91 6361141710</a>
                    <a href="mailto:bhuvandshetty999@gmail.com"><i class="fa-solid fa-envelope"></i>bhuvandshetty999@gmail.com</a>
                    <a href="https://maps.app.goo.gl/nwSoLBe6LXJySiUw6"><i class="fa-solid fa-location-dot"></i>Mangalore, India</a>
                </div>

                <div class="box">
                    <h3>Follow Us</h3>
                    <a href="https://github.com/Bdshetty"><i class="fa-brands fa-github"></i>GitHub</a>
                    <a href="https://www.instagram.com/b..d..s._/"><i class="fa-brands fa-instagram"></i>Instagram</a>
                    <a href="https://www.linkedin.com/in/bhuvandshetty/"><i class="fa-brands fa-linkedin"></i>LinkedIn</a>
                </div>
            </div>
            <div class="copyright">
                © 2025 DocAlert Pro | All rights reserved
           
            </div>
        </section>

    </form>
</body>
</html>
