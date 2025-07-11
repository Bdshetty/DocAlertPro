using System;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["DocUser_Mid"] == null)
        {
            Response.Redirect("Login.aspx");
        }
    }


    protected void btnHome_Click(object sender, EventArgs e)
    {
        if (Session["DocUser_Mid"] != null)
            Response.Redirect("Com.aspx");
        else
            Response.Redirect("Login.aspx");
    }

    protected void btnDashboard_Click(object sender, EventArgs e)
    {
        if (Session["DocUser_Mid"] != null)
            Response.Redirect("Dashboard.aspx");
        else
            Response.Redirect("Login.aspx");
    }

    protected void btnAddDocument_Click(object sender, EventArgs e)
    {
        if (Session["DocUser_Mid"] != null)
            Response.Redirect("AddDocument.aspx");
        else
            Response.Redirect("Login.aspx");
    }

    protected void btnProfile_Click(object sender, EventArgs e)
    {        Response.Redirect("Profile.aspx");
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Session.Abandon();
        Response.Redirect("Login.aspx");
    }
}
