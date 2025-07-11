using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;

public partial class AddDocument : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Redirect if user not logged in
        if (Session["DocUser_Mid"] == null)
        {
            Response.Redirect("Login.aspx");
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        // Get user session
        string mid = Session["DocUser_Mid"].ToString();

        string docCustomID = txtDocCustomID.Text.Trim();
        string docType = ddlDocType.SelectedValue;
        string docName = txtDocName.Text.Trim();
        DateTime expiryDate;
        int alertBeforeDays;
        string fileName = "";

        bool isValid = true;

        // Reset all validation labels
        lblDocCustomID.Text = "";
        lblDocType.Text = "";
        lblDocName.Text = "";
        lblExpiryDate.Text = "";
        lblAlertBeforeDays.Text = "";

        // Field validations
        if (string.IsNullOrEmpty(docCustomID))
        {
            lblDocCustomID.Text = "This field is required.";
            isValid = false;
        }
        if (string.IsNullOrEmpty(docType))
        {
            lblDocType.Text = "Please select a document type.";
            isValid = false;
        }
        if (string.IsNullOrEmpty(docName))
        {
            lblDocName.Text = "This field is required.";
            isValid = false;
        }
        if (!DateTime.TryParse(txtExpiryDate.Text, out expiryDate))
        {
            lblExpiryDate.Text = "Enter a valid expiry date.";
            isValid = false;
        }
        if (!int.TryParse(ddlAlertBeforeDays.SelectedValue, out alertBeforeDays))
        {
            lblAlertBeforeDays.Text = "Select alert days.";
            isValid = false;
        }

        if (!isValid)
        {
            return; // Stop processing if validation fails
        }

        // File upload validation
        if (fileUpload.HasFile)
        {
            try
            {
                string ext = Path.GetExtension(fileUpload.FileName).ToLower();
                string[] allowedExts = { ".pdf", ".jpg", ".jpeg", ".png" };

                if (Array.IndexOf(allowedExts, ext) == -1)
                {
                    lblFileUpload.Text = "Only PDF, JPG, JPEG, and PNG files are allowed.";
                    return;
                }

                if (fileUpload.PostedFile.ContentLength > 2 * 1024 * 1024)
                {
                    lblFileUpload.Text = "File size must be less than 2MB.";
                    return;
                }

                fileName = Guid.NewGuid().ToString() + ext;
                string uploadFolder = Server.MapPath("~/UploadedDocs/");
                if (!Directory.Exists(uploadFolder))
                {
                    Directory.CreateDirectory(uploadFolder);
                }
                fileUpload.SaveAs(Path.Combine(uploadFolder, fileName));
            }
            catch (Exception ex)
            {
                lblFileUpload.Text = "Error uploading file: " + ex.Message;
                return;
            }
        }

        // Insert into DB
        string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            string query = @"INSERT INTO Documents 
                (DocUser_Mid, DocDmt_DId, DocDmt_Type, DocDmt_Name, DocDmt_Expirydate, 
                 DocDmt_Alertbeforedays, DocDmt_Uploaddate, DocDmt_Alertsent, 
                 DocDmt_Alertsentdate, DocDmt_Status, DocDmt_Uploadfile)
                VALUES 
                (@Mid, @DId, @Type, @Name, @ExpiryDate, @AlertBeforeDays, GETDATE(), 
                 0, NULL, 'Active', @FileName)";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Mid", mid);
            cmd.Parameters.AddWithValue("@DId", docCustomID);
            cmd.Parameters.AddWithValue("@Type", docType);
            cmd.Parameters.AddWithValue("@Name", docName);
            cmd.Parameters.AddWithValue("@ExpiryDate", expiryDate);
            cmd.Parameters.AddWithValue("@AlertBeforeDays", alertBeforeDays);
            cmd.Parameters.AddWithValue("@FileName", fileName);

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();

                // Popup success
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('✅ Document saved successfully.');", true);

                ClearForm();
            }
            catch (Exception ex)
            {
                lblFileUpload.Text = "Database error: " + ex.Message;
            }
        }
    }

    private void ClearForm()
    {
        txtDocCustomID.Text = "";
        ddlDocType.SelectedIndex = 0;
        txtDocName.Text = "";
        txtExpiryDate.Text = "";
        ddlAlertBeforeDays.SelectedIndex = 0;
    }
}
