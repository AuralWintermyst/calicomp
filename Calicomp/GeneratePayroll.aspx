<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="GeneratePayroll.aspx.cs" Inherits="Calicomp.GeneratePayroll" %>

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
                <h4 class="mb-3">Payroll</h4>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="staff">Staff</label>
                        <asp:DropDownList ID="inputStaff" CssClass="custom-select" runat="server" itemid="staff" DataSourceID="SqlDataSource1" DataTextField="First_Name" DataValueField="Staff_ID">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:calicompConnection %>" SelectCommand="SELECT DISTINCT [Staff_ID], [First_Name] FROM [Staff] WHERE ([Type] = @Type)">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="Employee" Name="Type" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="datepicker">Date</label>
                        <input type="date" class="form-control" id="datepicker" itemid="datepicker" runat="server" required />
                        <div class="invalid-feedback">
                            Please enter a valid date.
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <asp:Button ID="refresh" CssClass="btn btn-primary" type="submit" runat="server" OnClick="refresh_Click" Text="Refresh" />
                    </div>
                </div>
                <div class="container">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" ShowFooter="True" DataSourceID="SqlDataSource2" OnRowDataBound="GridView1_RowDataBound" CssClass="table table-hover table-striped" BackColor="White" GridLines="None" OnPreRender="GridView1_PreRender">
                        <Columns>
                            <asp:BoundField DataField="Staff_ID" HeaderText="Staff ID" SortExpression="Staff_ID" />
                            <asp:BoundField DataField="First_Name" HeaderText="First Name" SortExpression="First_Name" />
                            <asp:BoundField DataField="Pay_Rate" HeaderText="Pay Rate" SortExpression="Pay_Rate" />
                            <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}" SortExpression="Date" />
                            <asp:BoundField DataField="Hours_Worked" HeaderText="Hours Worked" SortExpression="Hours_Worked" />
                            <asp:BoundField DataField="Total" HeaderText="Total" ReadOnly="True" DataFormatString="{0:c}" SortExpression="Total" />
                        </Columns>
                        <EmptyDataTemplate>
                            No Record Available
                        </EmptyDataTemplate>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:calicompConnection %>" SelectCommand="Payroll_proc" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="inputStaff" Name="Staff_ID" PropertyName="SelectedValue" Type="Int32" />
                            <asp:Parameter DbType="Date" Name="Date_checker" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
                <hr class="mb-4">
                <asp:Button ID="submit_salary" runat="server" CssClass="btn btn-primary btn-lg btn-block" OnClick="submit_salary_Click" type="submit" Text="Save Payroll" />
            </div>
        </div>
    </main>
</asp:Content>
