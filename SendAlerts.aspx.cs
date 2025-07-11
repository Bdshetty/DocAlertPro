using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class SendAlerts : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            SendExpiryAlerts();
            Response.Write("<p style='color:green;'>✅ Email alert process completed.</p>");
        }
        catch (Exception ex)
        {
            Response.Write("<p style='color:red;'>❌ Error: " + ex.Message + "</p>");
        }
    }

    private void SendExpiryAlerts()
    {
        string connStr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = @"
SELECT d.DocDmt_Id, d.DocDmt_Name, d.DocDmt_Expirydate, d.DocDmt_Alertbeforedays,
       d.DocDmt_DId, d.DocDmt_Uploadfile,
       u.DocUser_Email, u.DocUser_Fullname
FROM Documents d
INNER JOIN Users u ON d.DocUser_Mid = u.DocUser_Mid
WHERE d.DocDmt_Status = 'Active'
  AND d.DocDmt_Alertsent = 0
AND d.DocDmt_ActiveFlag = 1
  AND CAST(GETDATE() AS DATE) >= CAST(DATEADD(DAY, -d.DocDmt_Alertbeforedays, d.DocDmt_Expirydate) AS DATE)
";


            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                string docName = rdr["DocDmt_Name"].ToString();
                DateTime expiry = Convert.ToDateTime(rdr["DocDmt_Expirydate"]);
                string email = rdr["DocUser_Email"].ToString();
                string fullName = rdr["DocUser_Fullname"].ToString();
                int docId = Convert.ToInt32(rdr["DocDmt_Id"]);
                string docIdStr = rdr["DocDmt_DId"].ToString();
                string uploadedFile = rdr["DocDmt_Uploadfile"].ToString();  // ✅ ADD THIS LINE

                string subject = "📅 Document Expiry Reminder!";
                string body = string.Format(
                    "<p>Hello <strong>{0}</strong>,</p>" +
                    "<p>This is a reminder that your document <strong>{1}</strong> (ID: <strong>{3}</strong>) is expiring on <strong>{2:dd-MMM-yyyy}</strong>.</p>" +
                    "<p>Please take action before the expiry date.</p><br/><p>– DocAlert Pro</p>",
                    fullName, docName, expiry, docIdStr);

                try
                {
                    string filePath = Server.MapPath("~/UploadedDocs/") + uploadedFile;  // ✅ now no error
                    EmailSender.SendEmail(email, subject, body, filePath);
                    MarkAlertSentAfterReading(docId, connStr);

                    Response.Write(string.Format("<p style='color:blue;'>✅ Sent to {0} for '{1}'</p>", email, docName));
                }
                catch (Exception ex)
                {
                    Response.Write(string.Format("<p style='color:red;'>❌ Error for {0}: {1}</p>", docName, ex.Message));
                }
            }

           

            rdr.Close(); // good practice
            con.Close();
        }
    }


    private void MarkAlertSentAfterReading(int docId, string connStr)
    {
        using (SqlConnection con2 = new SqlConnection(connStr))
        {
            string update = @"UPDATE Documents 
                          SET DocDmt_Alertsent = 1, 
                              DocDmt_Alertsentdate = GETDATE() 
                          WHERE DocDmt_Id = @DocId";

            SqlCommand cmd = new SqlCommand(update, con2);
            cmd.Parameters.AddWithValue("@DocId", docId);
            con2.Open();
            cmd.ExecuteNonQuery();
            con2.Close();
        }
    }


}
