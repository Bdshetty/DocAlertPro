using System;
using System.Configuration;
using System.Data.SqlClient;

public partial class Register : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        try
        {
            con.Open();

            // Check if UserID already exists
            SqlCommand checkCmd = new SqlCommand("SELECT COUNT(*) FROM Users WHERE DocUser_Userid = @UserID", con);
            checkCmd.Parameters.AddWithValue("@UserID", txtUserID.Text.Trim());

            int userExists = (int)checkCmd.ExecuteScalar();

            if (userExists > 0)
            {
                ShowAlert("❌ User ID already exists!");
            }
            else if (txtPassword.Text != txtConfirmPassword.Text)
            {
                ShowAlert("❌ Password and Confirm Password do not match!");
            }
            else
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO Users (DocUser_Userid, DocUser_Fullname, DocUser_Email, DocUser_Mobileno, DocUser_Password) VALUES (@UserID, @FullName, @Email, @Mobile, @Password)", con);
                cmd.Parameters.AddWithValue("@UserID", txtUserID.Text.Trim());
                cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());

                cmd.ExecuteNonQuery();

                ShowAlert("✔️ Registration Successful!",true);
                ClearFields();
            }
        }
        catch (Exception ex)
        {
            ShowAlert("❌ Error: " + ex.Message.Replace("'", "\\'"));
        }
        finally
        {
            con.Close();
        }
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        ClearFields();
    }

    private void ClearFields()
    {
        txtFullName.Text = "";
        txtEmail.Text = "";
        txtMobile.Text = "";
        txtUserID.Text = "";
        txtPassword.Text = "";
        txtConfirmPassword.Text = "";
    }

    private void ShowAlert(string message, bool redirectToLogin = false)
    {
        string safeMessage = message.Replace("'", "\\'");
        string script = string.Format("alert('{0}');", safeMessage);

        if (redirectToLogin)
        {
            script += "window.location='Login.aspx';";
        }

        ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
    }
}
