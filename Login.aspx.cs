using System;
using System.Configuration;
using System.Data.SqlClient;

public partial class Login : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtUserID.Attributes.Add("placeholder", "Enter your User ID");
            txtPassword.Attributes.Add("placeholder", "Enter your Password");
            txtCaptchaInput.Attributes.Add("placeholder", "Enter Captcha");
            GenerateCaptcha();
        }
    }

    protected void btnRefreshCaptcha_Click(object sender, EventArgs e)
    {
        GenerateCaptcha();
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtCaptchaInput.Text.Trim() != lblCaptcha.Text.Trim())
            {
                ShowAlert("❌ Invalid CAPTCHA!");
                GenerateCaptcha();
                return;
            }

            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Users WHERE DocUser_Userid=@UserID AND DocUser_Password=@Password", con);
            cmd.Parameters.AddWithValue("@UserID", txtUserID.Text.Trim());
            cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());

            int count = (int)cmd.ExecuteScalar();

            if (count == 1)
            {
                SqlCommand cmdMid = new SqlCommand("SELECT DocUser_Mid FROM Users WHERE DocUser_Userid=@UserID", con);
                cmdMid.Parameters.AddWithValue("@UserID", txtUserID.Text.Trim());
                object result = cmdMid.ExecuteScalar();

                if (result != null)
                {
                    string mid = result.ToString();
                    Session["DocUser_Mid"] = mid;
                    Response.Redirect("Dashboard.aspx");
                }
            }
            else
            {
                ShowAlert("❌ Invalid User ID or Password!");
                GenerateCaptcha();
            }
        }
        catch (Exception ex)
        {
            ShowAlert("Error: " + ex.Message);
        }
        finally
        {
            con.Close();
        }
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        txtUserID.Text = "";
        txtPassword.Text = "";
        txtCaptchaInput.Text = "";
        GenerateCaptcha();
    }

    private void GenerateCaptcha()
    {
        Random rand = new Random();
        string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        string captcha = "";
        for (int i = 0; i < 6; i++)
        {
            captcha += chars[rand.Next(chars.Length)];
        }
        lblCaptcha.Text = captcha;
    }
    private void ShowAlert(string message)
    {
        ClientScript.RegisterStartupScript(this.GetType(), "alert", string.Format("alert('{0}');", message.Replace("'", "\\'")), true);
    }

}
