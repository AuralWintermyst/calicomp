<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="managerProfile.aspx.cs" Inherits="Calicomp.managerProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Staff
        </a>
        <div class="dropdown-menu" aria-labelledby="dropdown01">
            <a class="dropdown-item" href="AddStaff.aspx?StaffID=<%=Request.QueryString["StaffID"] %>&Type=<%=Request.QueryString["Type"] %>">Add Staff</a>
            <a class="dropdown-item" href="ViewLeave.aspx?StaffID=<%=Request.QueryString["StaffID"] %>&Type=<%=Request.QueryString["Type"] %>">Leave Submitted</a>
        </div>
    </li>
    <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="dropdown02" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Schedule 
        </a>
        <div class="dropdown-menu" aria-labelledby="dropdown02">
            <a class="dropdown-item" href="CreateShift.aspx?StaffID=<%=Request.QueryString["StaffID"] %>&Type=<%=Request.QueryString["Type"] %>">Create Shift</a>
            <a class="dropdown-item" href="AssignShift.aspx?StaffID=<%=Request.QueryString["StaffID"] %>&Type=<%=Request.QueryString["Type"] %>">Assign Shift</a>
        </div>
    </li>
    <li class="nav-item active">
        <a class="nav-link" href="GeneratePayroll.aspx?StaffID=<%=Request.QueryString["StaffID"] %>&Type=<%=Request.QueryString["Type"] %>">Payroll <span class="sr-only"></span></a>
    </li>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <main role="main" class="container">
        <div class="row">
            <div class="col-md-8 order-md-1">
                <h4 class="mb-3">Profile</h4>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="firstName" runat="server">First name</label>
                        <asp:TextBox ID="firstName" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="lastName">Last name</label>
                        <asp:TextBox ID="lastName" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="email">Email</label>
                    <asp:TextBox ID="email" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label for="phonenum">Phone Number</label>
                    <asp:TextBox ID="phonenum" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                </div>
                <div class="mb-3">
                    <label for="address">Address</label>
                    <asp:TextBox ID="address" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                </div>
                <div class="mb-3">
                    <label for="type">Type</label>
                    <asp:TextBox ID="type" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                </div>
                <hr class="mb-4">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="oldpw" runat="server">Old Password</label>
                        <input type="password" class="form-control" id="oldpw" runat="server" required>
                        <div class="invalid-feedback">
                            Please enter old password.
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="newpw" runat="server">New Password</label>
                        <input type="password" class="form-control" id="newpw" runat="server" required>
                        <div class="invalid-feedback">
                            Please enter new password.
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                         <asp:Button ID="changepw" CssClass="btn btn-primary" runat="server" Text="Change Password" OnClick="changepw_Click" />
                    </div>
                </div>
                <hr class="mb-4">
                <button class="btn btn-primary btn-lg btn-block" runat="server" id="logout" onserverclick="logout_ServerClick" type="button">Log Out</button>
            </div>
        </div>
    </main>
</asp:Content>
