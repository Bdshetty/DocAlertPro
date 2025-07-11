using System;
using System.Configuration;
using System.Data.SqlClient;

public partial class WebPages_ResetPassword : System.Web.UI.Page
{
    string email = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string queryEmail = Request.QueryString["email"];
            if (!string.IsNullOrEmpty(queryEmail))
            {
                ViewState["email"] = queryEmail; // Store it here
                pnlReset.Visible = true;
            }
            else
            {
                lblMessage.Text = "Invalid or missing email.";
            }
        }
    }


    protected void btnReset_Click(object sender, EventArgs e)
    {
        if (ViewState["email"] != null)
            email = ViewState["email"].ToString();
        else
        {
            lblMessage.Text = "Session expired. Please try again.";
            return;
        }

        string newPwd = txtNewPassword.Text.Trim();
        string confirmPwd = txtConfirmPassword.Text.Trim();

        if (string.IsNullOrEmpty(newPwd) || string.IsNullOrEmpty(confirmPwd))
        {
            lblMessage.Text = "Both password fields are required.";
            return;
        }

        if (newPwd != confirmPwd)
        {
            lblMessage.Text = "Passwords do not match.";
            return;
        }

        string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("UPDATE Users SET DocUser_Password = @Password WHERE DocUser_Email = @Email", con);
            cmd.Parameters.AddWithValue("@Password", newPwd);
            cmd.Parameters.AddWithValue("@Email", email);
            int rows = cmd.ExecuteNonQuery();

            if (rows > 0)
            {
                // ✅ This is the part that adds popup + delay redirect
                string script = @"
                <script>
                    alert('Password reset successful! Redirecting to login page...');
                    setTimeout(function() {
                        window.location.href = 'Login.aspx';
                    }, 4000);
                </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "Redirect", script);
            }
            else
            {
                lblMessage.Text = "Failed to reset password.";
            }
        }
    }

}
