<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ClockinMenu.aspx.cs" Inherits="Calicomp.ClockinMenu" %>

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
                <h1 class="mb-3"><%= DateTime.Now.ToString("dddd, MMMM dd") %></h1>
                <h2 class="mb-3" id="txt"></h2>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <p>
                            Welcome. If you have any available shifts today, you can select the shifts from the list and 
                             press clock in/out in accordance to the time set by the manager. 
                        </p>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="inputShift">Today's shifts</label>
                        <asp:DropDownList ID="inputShift" CssClass="custom-select" runat="server" itemid="staff" DataSourceID="SqlDataSource1" DataTextField="Shift" DataValueField="Shift_ID" >
                        </asp:DropDownList>
                    </div>
                </div>
                <hr class="mb-4">
                <div class="container">
                    <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" CssClass="table table-hover table-striped" BackColor="White" GridLines="None" OnPreRender="GridView1_PreRender">
                        <Columns>
                            <asp:BoundField DataField="Shift" HeaderText="Shift" SortExpression="Shift" />
                            <asp:BoundField DataField="Start_time" HeaderText="Start time" SortExpression="Start_time" />
                            <asp:BoundField DataField="End_time" HeaderText="End time" SortExpression="End_time" />
                            <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField DataField="Duration" HeaderText="Duration" SortExpression="Duration" />
                        </Columns>
                        <EmptyDataTemplate>
                            No Record Available
                        </EmptyDataTemplate>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:calicompConnection %>" SelectCommand="ViewTodayShift" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="Staff_ID" QueryStringField="StaffID" Type="Int32" />
                            <asp:Parameter Name="Date_checker" DbType="DateTime" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
                <hr class="mb-4">
                <div class="col-md-6 mb-3">
                    <asp:button Cssclass="btn btn-primary btn-lg btn-block" type="submit" runat="server" ID="clockinButton" onClick="clockinButton_Click" Text="Clock In"/>
                </div>
                <div class="col-md-6 mb-3">
                    <asp:button Cssclass="btn btn-primary btn-lg btn-block" type="submit" runat="server" ID="clockoutButton" onClick="clockoutButton_Click" Text="Clock Out"/>
                </div>
                
            </div>
        </div>
    </main>
</asp:Content>
