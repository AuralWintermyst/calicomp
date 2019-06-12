<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="LeaveApplication.aspx.cs" Inherits="Calicomp.LeaveApplication" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Staff
        </a>
        <div class="dropdown-menu" aria-labelledby="dropdown01">
            <a class="dropdown-item" href="empLeaveView.aspx?StaffID=<%=Request.QueryString["StaffID"] %>&Type=<%=Request.QueryString["Type"] %>">Leave Submitted</a>
            <a class="dropdown-item" href="LeaveApplication.aspx?StaffID=<%=Request.QueryString["StaffID"] %>&Type=<%=Request.QueryString["Type"] %>">Leave Application</a>
        </div>
    </li>
    <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="dropdown02" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Schedule 
        </a>
        <div class="dropdown-menu" aria-labelledby="dropdown02">
            <a class="dropdown-item" href="EmpShiftView.aspx?StaffID=<%=Request.QueryString["StaffID"] %>&Type=<%=Request.QueryString["Type"] %>">Available Shifts</a>
            <a class="dropdown-item" href="viewCurrentShift.aspx?StaffID=<%=Request.QueryString["StaffID"] %>&Type=<%=Request.QueryString["Type"] %>">Current Shifts</a>
        </div>
    </li>
    <li class="nav-item active">
        <a class="nav-link" href="empViewPayroll.aspx?StaffID=<%=Request.QueryString["StaffID"] %>&Type=<%=Request.QueryString["Type"] %>">Payroll <span class="sr-only"></span></a>
    </li>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <main role="main" class="container">
        <div class="col-md-8 order-md-1">
            <h4 class="mb-3">Leave Application</h4>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="datepicker">Date</label>
                    <input type="date" class="form-control" id="datepicker" itemid="datepicker" runat="server" required />
                    <div class="invalid-feedback">
                        Please enter a valid date.
                    </div>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="leavetype">Leave Type</label>
                    <asp:DropDownList ID="leavetype" CssClass="custom-select" runat="server" itemid="leavetype">
                        <asp:ListItem Selected="True">Medical</asp:ListItem>
                        <asp:ListItem>Maternity</asp:ListItem>
                        <asp:ListItem>Study</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="duration">Duration (Days)</label>
                    <input type="number" value="2" data-decimals="0" min="1" max="9" step="1" id="duration" itemid="duration" runat="server"/>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="fileupload">Attachment</label>
                    <input type="file" class="form-control-file" id="fileupload" runat="server" required>
                    <div class="invalid-feedback">
                        Please upload an attachment.
                    </div>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="remark">Remark</label>
                    <textarea class="form-control" id="remark" rows="3" runat="server"></textarea>
                </div>
            </div>
            <hr class="mb-4">
            <asp:button Cssclass="btn btn-primary btn-lg btn-block" type="submit" runat="server" OnClick="submitleave_Click" ID="submitleave" Text="Submit Leave" />
        </div>
    </main>
</asp:Content>
