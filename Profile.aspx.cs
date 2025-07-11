using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class UserProfile : System.Web.UI.Page
{
    string connectionString = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["DocUser_Mid"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                LoadUserDetails();
            }
        }
    }

    private void LoadUserDetails()
    {
        string mid = Session["DocUser_Mid"].ToString();

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT DocUser_Userid, DocUser_Fullname, DocUser_Email, DocUser_Mobileno, DocUser_Password FROM Users WHERE DocUser_Mid = @Mid";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Mid", mid);
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                txtUserId.Text = reader["DocUser_Userid"].ToString();
                txtFullName.Text = reader["DocUser_Fullname"].ToString();
                txtEmail.Text = reader["DocUser_Email"].ToString();
                txtMobile.Text = reader["DocUser_Mobileno"].ToString();
                txtPassword.Text = reader["DocUser_Password"].ToString();
            }

            con.Close();
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        string mid = Session["DocUser_Mid"].ToString();

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = @"UPDATE Users 
                         SET DocUser_Fullname = @Fullname, 
                             DocUser_Email = @Email, 
                             DocUser_Mobileno = @Mobile, 
                             DocUser_Password = @Password
                         WHERE DocUser_Mid = @Mid";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Fullname", txtFullName.Text.Trim());
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
            cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());
            cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
            cmd.Parameters.AddWithValue("@Mid", mid);

            con.Open();
            int rows = cmd.ExecuteNonQuery();
            con.Close();

            if (rows > 0)
            {
                // Show popup alert for success
                string script = "alert('✅ Profile updated successfully!');";
                ClientScript.RegisterStartupScript(this.GetType(), "SuccessAlert", script, true);

            }
            else
            {
                // Show popup alert for failure
                string script = "alert('❌ Update failed. Please try again.');";
                ClientScript.RegisterStartupScript(this.GetType(), "ErrorAlert", script, true);

               
            }
        }
    }

}
