using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;


public partial class Dashboard : System.Web.UI.Page
{
    public int TotalDocuments = 0;
    public int ExpiringSoon = 0;
    public int ExpiredCount = 0;

    private string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    private string mid;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["DocUser_Mid"] == null)
        {
            Response.Redirect("Login.aspx");
            return;
        }

        mid = Session["DocUser_Mid"].ToString();

        if (!IsPostBack)
        {
            LoadDashboardData();
        }
    }

    private void LoadDashboardData(string searchQuery = "", string sortOrder = "ExpiryAsc")
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            string query = @"
                SELECT 
                    DocDmt_Name,
                    DocDmt_Type,
                    DocDmt_DId,
                    DocDmt_Expirydate,
                    DocDmt_Status,
                    DATEDIFF(DAY, GETDATE(), DocDmt_Expirydate) AS DaysRemaining
                FROM Documents
                WHERE DocUser_Mid = @Mid AND DocDmt_ActiveFlag = 1";

            if (!string.IsNullOrEmpty(searchQuery))
            {
                query += " AND DocDmt_Name LIKE @Search";
            }

            switch (sortOrder)
            {
                case "ExpiryDesc": query += " ORDER BY DocDmt_Expirydate DESC"; break;
                case "NameAsc": query += " ORDER BY DocDmt_Name ASC"; break;
                case "NameDesc": query += " ORDER BY DocDmt_Name DESC"; break;
                default: query += " ORDER BY DocDmt_Expirydate ASC"; break;
            }

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Mid", mid);

            if (!string.IsNullOrEmpty(searchQuery))
            {
                cmd.Parameters.AddWithValue("@Search", "%" + searchQuery + "%");
            }

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            dt.Columns.Add("StatusBadge", typeof(string));
            foreach (DataRow row in dt.Rows)
            {
                int daysRemaining = Convert.ToInt32(row["DaysRemaining"]);
                string status = row["DocDmt_Status"].ToString();

                if (status == "Expired" || daysRemaining < 0)
                {
                    row["StatusBadge"] = "Expired";
                    row["DocDmt_Status"] = "Expired";
                }
                else if (daysRemaining <= 15)
                {
                    row["StatusBadge"] = "Soon";
                    row["DocDmt_Status"] = "Expiring Soon";
                }
                else
                {
                    row["StatusBadge"] = "Active";
                    row["DocDmt_Status"] = "Active";
                }
            }

            rptDocuments.DataSource = dt;
            rptDocuments.DataBind();

            TotalDocuments = dt.Rows.Count;
            ExpiringSoon = dt.Select("StatusBadge = 'Soon'").Length;
            ExpiredCount = dt.Select("StatusBadge = 'Expired'").Length;
        }
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        string searchQuery = txtSearch.Text.Trim();
        string sortOrder = ddlSort.SelectedValue;
        LoadDashboardData(searchQuery, sortOrder);
    }

    protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e)
    {
        string searchQuery = txtSearch.Text.Trim();
        string sortOrder = ddlSort.SelectedValue;
        LoadDashboardData(searchQuery, sortOrder);
    }
    protected void btnDelete_Command(object sender, CommandEventArgs e)
    {
        string docDId = e.CommandArgument.ToString();

        using (SqlConnection con = new SqlConnection(constr))
        {
            string query = "UPDATE Documents SET DocDmt_ActiveFlag = 0 WHERE DocDmt_DId = @DocDId AND DocUser_Mid = @Mid";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@DocDId", docDId);
            cmd.Parameters.AddWithValue("@Mid", mid);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }

        // Refresh the dashboard after deletion
        LoadDashboardData(txtSearch.Text.Trim(), ddlSort.SelectedValue);
    }

}
