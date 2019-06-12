<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="CreateShift.aspx.cs" Inherits="Calicomp.CreateShift" %>

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
                <h4 class="mb-3">Create Shift</h4>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="datepicker" runat="server">Date</label>
                        <input type="date" class="form-control" runat="server" id="datepicker" required />
                        <div class="invalid-feedback">
                            Please enter a valid date.
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="startime">Start Time</label>
                        <input type="time" class="form-control" runat="server" id="startime" required />
                        <div class="invalid-feedback">
                            Please enter a valid time.
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="endtime" runat="server">Duration (Hours)</label>
                        <input type="number" value="2" runat="server" data-decimals="0" min="1" max="9" step="1" id="endtime" itemid="endtime" runat="server" />
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="task" runat="server">Task</label>
                        <input type="text" class="form-control" runat="server" id="task" placeholder="" value="" required>
                        <div class="invalid-feedback">
                            Valid task is required.
                        </div>
                    </div>
                </div>
                <div class="container">
                    <asp:GridView ID="GridView1" runat="server" ShowHeaderWhenEmpty="True" AutoGenerateColumns="False" CssClass="table table-hover table-striped" BackColor="White" GridLines="None" OnPreRender="GridView1_PreRender" 
                        AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="5">
                        <Columns>
                            <asp:BoundField HeaderText="Shift" DataField="Shift" />
                            <asp:BoundField DataField="Start_time" HeaderText="Start Time" SortExpression="Start_time" />
                            <asp:BoundField DataField="End_time" HeaderText="End Time" SortExpression="End_time" />
                            <asp:BoundField HeaderText="Date" DataField="Date" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField DataField="Duration" HeaderText="Duration" SortExpression="Duration" />
                        </Columns>
                        <EmptyDataTemplate>
                            No Record Available
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
                <hr class="mb-4">
                <asp:Button ID="submit_shift" runat="server" Text="Add Shift" CssClass="btn btn-primary btn-lg btn-block" OnClick="submit_shift_ServerClick"/>
                <%--<button class="btn btn-primary btn-lg btn-block" runat="server" onserverclick="submit_shift_ServerClick" id="submit_shift" type="submit">Add Shift</button>--%>
            </div>
        </div>
    </main>
</asp:Content>
