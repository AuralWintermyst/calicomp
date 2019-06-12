<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="empViewPayroll.aspx.cs" Inherits="Calicomp.empViewPayroll" %>

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
        <div class="row">
            <div class="col-md-8 order-md-1">
                <h4 class="mb-3">Payroll</h4>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="datepicker">Date</label>
                        <input type="date" class="form-control" id="datepicker" itemid="datepicker" runat="server" required />
                        <div class="invalid-feedback">
                            Please enter a valid date.
                        </div>
                        <hr class="mb-4">
                        <asp:Button ID="refresh" CssClass="btn btn-primary" type="submit" runat="server" OnClick="refresh_Click" Text="Refresh" />
                    </div>
<%--                    <div class="col-md-6 mb-3">
                        
                    </div>--%>
                </div>
                <div class="container">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CssClass="table table-hover table-striped" BackColor="White" GridLines="None" OnPreRender="GridView1_PreRender">
                        <Columns>
                            <asp:BoundField DataField="Staff_ID" HeaderText="Staff_ID" SortExpression="Staff_ID" />
                            <asp:BoundField DataField="First_Name" HeaderText="First_Name" SortExpression="First_Name" />
                            <asp:BoundField DataField="Pay_Rate" HeaderText="Pay_Rate" SortExpression="Pay_Rate" />
                            <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}" SortExpression="Date" />
                            <asp:BoundField DataField="Hours_Worked" HeaderText="Hours_Worked" SortExpression="Hours_Worked" />
                            <asp:BoundField DataField="Total" HeaderText="Total" ReadOnly="True"  DataFormatString="{0:c}" SortExpression="Total" />
                        </Columns>
                        <EmptyDataTemplate>
                            No Record Available
                        </EmptyDataTemplate>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:calicompConnection %>" SelectCommand="Payroll_proc" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="Staff_ID" QueryStringField="StaffID" Type="Int32" />
                            <asp:Parameter DbType="Date" Name="Date_checker" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </div>
        </div>
    </main>
</asp:Content>
