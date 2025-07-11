<%@ Page Title="Add New Document" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AddDocument.aspx.cs" Inherits="AddDocument" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet" />
    <style>
        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            background: #f3f4f6;
        }

        .container {
            max-width: 650px;
            margin: 40px auto;
            background-color: white;
            border-radius: 12px;
            padding: 40px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            font-weight: 700;
            margin-bottom: 10px;
        }

        p.subtitle {
            text-align: center;
            color: #6b7280;
            margin-bottom: 30px;
        }

        label {
            font-weight: 600;
            margin-top: 20px;
            display: block;
            margin-bottom: 6px;
            color: #374151;
        }

        .required {
            color: red;
            margin-left: 4px;
        }

        input[type="text"],
        input[type="date"],
        select {
            width: 100%;
            padding: 12px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            margin-bottom: 5px;
            font-size: 14px;
        }

        .error-label {
            color: red;
            font-size: 13px;
            margin-top: -5px;
            margin-bottom: 15px;
            display: block;
        }

        .file-upload-box {
            border: 2px dashed #d1d5db;
            padding: 30px;
            text-align: center;
            border-radius: 10px;
            color: #6b7280;
            margin-bottom: 10px;
        }

        .file-upload-box a {
            color: #2563eb;
            font-weight: 600;
        }

        .submit-btn {
            width: 100%;
            background-color: #2563eb;
            color: white;
            padding: 12px;
            font-weight: 600;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .submit-btn:hover {
            background-color: #1e40af;
        }

        .success {
            color: green;
            text-align: center;
            font-weight: bold;
            margin-top: 15px;
        }
    </style>

    <div class="container">
        <h2>Add New Document</h2>
        <p class="subtitle">Track and get alerts before your documents expire.</p>

        <label for="txtDocCustomID">Document ID<span class="required">*</span></label>
        <asp:TextBox ID="txtDocCustomID" runat="server" placeholder="e.g., A1234567" />
        <asp:Label ID="lblDocCustomID" runat="server" CssClass="error-label" />

        <label for="ddlDocType">Document Type<span class="required">*</span></label>
        <asp:DropDownList ID="ddlDocType" runat="server">
            <asp:ListItem Text="-- Select Type --" Value="" />
            <asp:ListItem Text="Gov ID" Value="Gov ID" />
            <asp:ListItem Text="Private ID" Value="Private ID" />
            <asp:ListItem Text="Other" Value="Other" />
        </asp:DropDownList>
        <asp:Label ID="lblDocType" runat="server" CssClass="error-label" />

        <label for="txtDocName">Document Name<span class="required">*</span></label>
        <asp:TextBox ID="txtDocName" runat="server" placeholder="e.g., Driving License" />
        <asp:Label ID="lblDocName" runat="server" CssClass="error-label" />

        <label for="txtExpiryDate">Expiry Date<span class="required">*</span></label>
        <asp:TextBox ID="txtExpiryDate" runat="server" TextMode="Date" />
        <asp:Label ID="lblExpiryDate" runat="server" CssClass="error-label" />

        <label for="ddlAlertBeforeDays">Alert Before Days<span class="required">*</span></label>
        <asp:DropDownList ID="ddlAlertBeforeDays" runat="server">
            <asp:ListItem Text="1 Day" Value="1" />
            <asp:ListItem Text="5 Days" Value="5" />
            <asp:ListItem Text="7 Days" Value="7" />
            <asp:ListItem Text="10 Days" Value="10" />
            <asp:ListItem Text="15 Days" Value="15" />
            <asp:ListItem Text="30 Days" Value="30" />
        </asp:DropDownList>
        <asp:Label ID="lblAlertBeforeDays" runat="server" CssClass="error-label" />

        <label>Upload File (PDF, JPG, PNG)</label>
        <div class="file-upload-box">
            <label for="fileUpload">Drop or <a href="#">browse</a></label>
            <asp:FileUpload ID="fileUpload" runat="server" />
            <div>Accepted formats: PDF, JPG, PNG. Max 2MB.</div>
        </div>
        <asp:Label ID="lblFileUpload" runat="server" CssClass="error-label" />

        <asp:Button ID="btnSubmit" runat="server" Text="Save Document" CssClass="submit-btn" OnClick="btnSubmit_Click" />
    </div>

    <script>
        document.getElementById('<%= fileUpload.ClientID %>').addEventListener('change', function () {
            const file = this.files[0];
            if (file && file.size > 2 * 1024 * 1024) {
                alert("File must be less than 2MB.");
                this.value = ""; // Clear file input
            }
        });
    </script>
</asp:Content>
