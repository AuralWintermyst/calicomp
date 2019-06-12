<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="managerHome.aspx.cs" Inherits="Calicomp.managerHome" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

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
                <h1 class="mb-3"><%= DateTime.Now.ToString("dddd, MMMM dd") %></h1>
                <h2 class="mb-3" id="txt"></h2>
                <hr class="mb-4">
                <h4 class="mb-3">Number of Staff</h4>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CssClass="table table-hover table-striped" BackColor="White" GridLines="None" OnPreRender="GridView1_PreRender">
                            <Columns>
                                <asp:BoundField DataField="Assigned" HeaderText="Assigned" ReadOnly="True" SortExpression="Assigned" />
                                <asp:BoundField DataField="Idle" HeaderText="Idle" ReadOnly="True" SortExpression="Idle" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:calicompConnection %>" SelectCommand="checkAmountofStaff" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                    </div>
                    <div class="col-md-6 mb-3">
                        <p>
                            Welcome. If there are idle staff, you can assign them a shift in the schedule menu.  
                        </p>
                    </div>
                </div>
                <hr class="mb-4">
                <h4 class="mb-3">Staff Requests</h4>
                <div class="row">
                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3" CssClass="table table-hover table-striped" BackColor="White" GridLines="None" OnPreRender="GridView2_PreRender">
                        <Columns>
                            <asp:BoundField DataField="Staff_ID" HeaderText="Staff ID" SortExpression="Staff_ID" />
                            <asp:BoundField DataField="First_Name" HeaderText="First Name" SortExpression="First_Name" />
                            <asp:BoundField DataField="Message" HeaderText="Message" SortExpression="Message" />
                        </Columns>
                        <EmptyDataTemplate>
                            No Record Available
                        </EmptyDataTemplate>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:calicompConnection %>" SelectCommand="SELECT DISTINCT * FROM [StaffMessages]"></asp:SqlDataSource>

                </div>
                <hr class="mb-4">
                <h4 class="mb-3">Staff expense</h4>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource2" BackColor="#FFCCFF" BackGradientStyle="LeftRight" Height="452px" Width="585px">
                            <Series>
                                <asp:Series Name="Series1" XValueMember="Date" YValueMembers="Amount"></asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1" BackColor="#FFCCFF"></asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>
                    </div>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:calicompConnection %>" SelectCommand="Select_salary" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <%-- <asp:Parameter Name="Staff_ID" Type="Int32" />--%>
                            <%--<asp:Parameter Name="Date" Type="DateTime" />--%>
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <div class="col-md-6 mb-3">
                        <%--<label for="datepicker">Date</label>
                        <input type="date" class="form-control" id="datepicker" itemid="datepicker" runat="server" required />
                        <div class="invalid-feedback">
                            Please enter a valid date.
                        </div>--%>
                        <%--<label for="staff">Staff</label>
                        <asp:DropDownList ID="inputStaff" CssClass="custom-select" runat="server" itemid="staff" DataSourceID="SqlDataSource3" DataTextField="First_Name" DataValueField="Staff_ID">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:calicompConnection %>" SelectCommand="SELECT DISTINCT [Staff_ID], [First_Name] FROM [Staff] WHERE ([Type] = @Type)">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="Employee" Name="Type" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>--%>
                        <%--<hr class="mb-4">
                        <asp:Button ID="refresh" CssClass="btn btn-primary" type="submit" runat="server" OnClick="refresh_Click" Text="Refresh" />--%>
                    </div>
                    <div class="col-md-6 mb-3">
                    </div>
                </div>

            </div>
        </div>
    </main>
</asp:Content>
