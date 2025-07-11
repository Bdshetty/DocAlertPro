<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f9fafb;
        }

        .container {
            display: flex;
            margin: 40px auto;
            gap: 30px;
            max-width: 1200px;
        }

        .sidebar {
            flex: 0 0 220px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .stat-card {
            background: #fff;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            text-align: center;
        }

            .stat-card h2 {
                font-size: 36px;
                margin: 0;
                color: #2563eb;
            }

            .stat-card p {
                color: #6b7280;
            }

        .main-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

            .header h1 {
                font-size: 24px;
                color: #111827;
                margin: 0;
            }

        .search-sort {
            display: flex;
            gap: 10px;
        }

            .search-sort input, .search-sort select {
                padding: 10px;
                border-radius: 8px;
                border: 1px solid #d1d5db;
            }

        .doc-table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            overflow: hidden;
        }

            .doc-table th, .doc-table td {
                padding: 14px 18px;
                border-bottom: 1px solid #e5e7eb;
            }

            .doc-table th {
                background: #f3f4f6;
                color: #374151;
                text-align: left;
            }

        .badge {
            padding: 5px 12px;
            border-radius: 20px;
            color: white;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }

            .badge.Active {
                background: #10b981;
            }

            .badge.Soon {
                background: #f59e0b;
            }

            .badge.Expired {
                background: #ef4444;
            }

        .btn-delete {
            background-color: #ef4444; /* red */
            color: white;
            padding: 6px 14px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            font-family: 'Inter', sans-serif;
            box-shadow: 0 2px 6px rgba(239, 68, 68, 0.3);
            transition: background-color 0.2s ease;
        }

            .btn-delete:hover {
                background-color: #dc2626; /* darker red */
            }
    </style>

    <div class="container">
        <!-- Sidebar Stats -->
        <div class="sidebar">
            <div class="stat-card">
                <h2><%= TotalDocuments %></h2>
                <p>Total Documents</p>
            </div>
            <div class="stat-card">
                <h2><%= ExpiringSoon %></h2>
                <p>Expiring Soon</p>
            </div>
            <div class="stat-card">
                <h2><%= ExpiredCount %></h2>
                <p>Expired</p>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <h1>Your Document Expiry Dashboard</h1>
                <div class="search-sort">
                    <asp:TextBox ID="txtSearch" runat="server" placeholder="Search documents..." AutoPostBack="true" OnTextChanged="txtSearch_TextChanged" />
                    <asp:DropDownList ID="ddlSort" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSort_SelectedIndexChanged">
                        <asp:ListItem Text="Sort by Expiry Date (Earliest)" Value="ExpiryAsc" />
                        <asp:ListItem Text="Sort by Expiry Date (Latest)" Value="ExpiryDesc" />
                        <asp:ListItem Text="Sort by Name (A-Z)" Value="NameAsc" />
                        <asp:ListItem Text="Sort by Name (Z-A)" Value="NameDesc" />
                    </asp:DropDownList>
                </div>
            </div>

            <!-- Document Table -->
            <asp:Repeater ID="rptDocuments" runat="server">
                <HeaderTemplate>
                    <table class="doc-table">
                        <thead>
                            <tr>
                                <th>Document Name</th>
                                <th>Type</th>
                                <th>Number</th>
                                <th>Expiry Date</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("DocDmt_Name") %></td>
                        <td><%# Eval("DocDmt_Type") %></td>
                        <td><%# Eval("DocDmt_DId") %></td>
                        <td><%# Eval("DocDmt_Expirydate", "{0:MMM dd, yyyy}") %></td>
                        <td>
                            <span class='badge <%# Eval("StatusBadge") %>'><%# Eval("DocDmt_Status") %></span>
                        </td>
                        <td>
                            <asp:Button ID="btnDelete" runat="server" Text="🗑 Delete" CommandArgument='<%# Eval("DocDmt_DId") %>' OnCommand="btnDelete_Command" CssClass="btn-delete" />
                        </td>

                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
