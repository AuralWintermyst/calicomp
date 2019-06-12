<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="AddStaff.aspx.cs" Inherits="Calicomp.EmployerMenu" %>

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
                <h4 class="mb-3">Add Staff</h4>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="firstName" runat="server">First name</label>
                        <input type="text" class="form-control" id="firstName" runat="server" placeholder="" value="" required>
                        <div class="invalid-feedback">
                            Valid first name is required.
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="lastName" runat="server">Last name</label>
                        <input type="text" class="form-control" id="lastName" runat="server" placeholder="" value="" required>
                        <div class="invalid-feedback">
                            Valid last name is required.
                        </div>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="email" runat="server">Email</label>
                    <input type="email" class="form-control" runat="server" id="email" placeholder="you@example.com" required>
                    <div class="invalid-feedback">
                        Please enter a valid email address.
                    </div>
                </div>

                <div class="mb-3">
                    <label for="phonenum" runat="server">Phone Number</label>
                    <input type="text" class="form-control" id="phonenum" runat="server" placeholder="XXX-XXX-XXXX" title="Telephone format" pattern="^\d{3}-\d{3}-\d{4}$" required>
                    <div class="invalid-feedback">
                        Please enter a valid phone number.
                    </div>
                </div>

                <div class="mb-3">
                    <label for="address" runat="server">Address</label>
                    <input type="text" class="form-control" id="address" runat="server" placeholder="1234 Main St" required>
                    <div class="invalid-feedback">
                        Please enter an address.
                    </div>
                </div>

                <div class="mb-3"> 
                    <label for="payrate" runat="server">Pay Rate (RM)</label>
                    <input type="number" id="payrate" value="4.5" runat="server" data-decimals="2" min="0" max="9" step="0.1"/>
                </div>

                <hr class="mb-4">
                <asp:Button ID="submitstaff" runat="server" Text="Add staff to roster" CssClass="btn btn-primary btn-lg btn-block" OnClick="submitstaff_ServerClick"/>
                <%--<button class="btn btn-primary btn-lg btn-block" runat="server" id="submitstaff" onserverclick="submitstaff_ServerClick" type="submit">Add staff to roster</button>--%>
            </div>
        </div>
    </main>
    <!-- /.container -->
</asp:Content>


