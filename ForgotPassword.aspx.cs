using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;

public partial class WebPages_ForgotPassword : System.Web.UI.Page
{
    protected void btnSendCode_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();
        if (string.IsNullOrEmpty(email))
        {
            lblMessage.Text = "Please enter your registered email.";
            return;
        }

        string otp = new Random().Next(100000, 999999).ToString();
        DateTime expiry = DateTime.Now.AddMinutes(10);

        string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand checkCmd = new SqlCommand("SELECT COUNT(*) FROM Users WHERE DocUser_Email = @Email", con);
            checkCmd.Parameters.AddWithValue("@Email", email);
            int exists = Convert.ToInt32(checkCmd.ExecuteScalar());

            if (exists == 0)
            {
                lblMessage.Text = "No user found with that email.";
                return;
            }


            SqlCommand updateCmd = new SqlCommand("UPDATE Users SET DocUser_ResetOtp = @OTP, DocUser_OTPExpiry = @Expiry WHERE DocUser_Email = @Email", con);
            updateCmd.Parameters.AddWithValue("@OTP", otp);
            updateCmd.Parameters.AddWithValue("@Expiry", expiry);
            updateCmd.Parameters.AddWithValue("@Email", email);
            updateCmd.ExecuteNonQuery();
        }

        string subject = "DocAlert - OTP for Password Reset";
        string body = string.Format("<p>Your verification code is: <strong>{0}</strong></p><p>This OTP will expire in 10 minutes.</p>", otp);

        try
        {
            SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
            smtp.Credentials = new NetworkCredential("phoenixeco2@gmail.com", "mqrw qbcm rzpc bsac");
            smtp.EnableSsl = true;

            MailMessage message = new MailMessage();
            message.From = new MailAddress("phoenixeco2@gmail.com", "DocAlert Pro");
            message.To.Add(email);
            message.Subject = subject;
            message.Body = body;
            message.IsBodyHtml = true;

            smtp.Send(message);

            lblMessage.ForeColor = System.Drawing.Color.Green;
            lblMessage.Text = "OTP sent to your email.";
        }
        catch (Exception ex)
        {
            lblMessage.Text = "Error sending OTP: " + ex.Message;
        }
    }

    protected void btnVerifyCode_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();
        string otp = txtOTP.Text.Trim();

        if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(otp))
        {
            lblMessage.Text = "Please enter both email and code.";
            return;
        }

        string connStr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connStr))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Users WHERE DocUser_Email = @Email AND DocUser_ResetOtp = @OTP AND DocUser_OTPExpiry > GETDATE()", con);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@OTP", otp);

            int valid = Convert.ToInt32(cmd.ExecuteScalar());

            if (valid == 1)
            {
                SqlCommand clearCmd = new SqlCommand("UPDATE Users SET DocUser_ResetOtp=NULL, DocUser_OTPExpiry=NULL WHERE DocUser_Email=@Email", con);
                clearCmd.Parameters.AddWithValue("@Email", email);
                clearCmd.ExecuteNonQuery();

                Response.Redirect("ResetPassword.aspx?email=" + email);
            }
            else
            {
                lblMessage.Text = "Invalid or expired code.";
            }
        }
    }
}
