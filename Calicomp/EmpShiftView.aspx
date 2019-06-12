<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="EmpShiftView.aspx.cs" Inherits="Calicomp.EmpShiftView" %>

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
            <h4 class="mb-3">List of Shifts</h4>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="manager">Manager</label>
                    <asp:DropDownList ID="inputManager" CssClass="custom-select" runat="server" itemid="manager" DataSourceID="SqlDataSource1" DataTextField="First_Name" DataValueField="Email">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:calicompConnection %>" SelectCommand="SELECT DISTINCT [First_Name], [Email] FROM [Staff] WHERE ([Type] = @Type)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="Manager" Name="Type" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="firstName" runat="server">First name</label>
                    <asp:TextBox ID="firstName" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                </div>
                <div class="col-md-6 mb-3">
                    <p>To request shift, select from <mark>Manager</mark> and then enter <mark>Request</mark> in the list of shifts.</p>
                </div>
            </div>
            <div class="container">
                <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource2" AutoGenerateColumns="False" DataKeyNames="Shift_ID" CssClass="table table-hover table-striped" BackColor="White" GridLines="None"
                    OnPreRender="GridView1_PreRender" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="5">
                    <Columns>
                        <%--<asp:BoundField DataField="Shift_ID" HeaderText="Shift ID" InsertVisible="False" ReadOnly="True" SortExpression="Shift_ID" />--%>
                        <asp:BoundField DataField="Staff_ID" HeaderText="Staff ID" SortExpression="Staff_ID" />
                        <asp:BoundField DataField="Shift" HeaderText="Shift" SortExpression="Shift" />
                        <asp:BoundField DataField="Start_time" HeaderText="Start time" SortExpression="Start_time" />
                        <asp:BoundField DataField="End_time" HeaderText="End time" SortExpression="End_time" />
                        <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}" SortExpression="Date" />
                        <asp:BoundField DataField="Duration" HeaderText="Duration" SortExpression="Duration" />
                        <asp:BoundField DataField="First_Name" HeaderText="First Name" SortExpression="First_Name" />
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:Button ID="request" CssClass="btn btn-primary" type="submit" runat="server" OnClick="request_Click" Text="Request" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        No Record Available
                    </EmptyDataTemplate>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:calicompConnection %>" SelectCommand="staff_viewshift" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="Staff_ID" QueryStringField="StaffID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </div>
    </main>
</asp:Content>
