<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ViewLeave.aspx.cs" Inherits="Calicomp.ViewLeave" %>

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
                <h4 class="mb-3">Leave Submitted</h4>
                <div class="row">
                    <asp:GridView id="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" DataKeyNames="Leave_ID" CssClass="table table-hover table-striped" BackColor="White" GridLines="None" OnPreRender="GridView1_PreRender">
                        <Columns>
                            <asp:BoundField DataField="First_Name" HeaderText="Name" SortExpression="First_Name" />
                            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                            <asp:BoundField DataField="Leave_Type" HeaderText="Leave Type" SortExpression="Leave_Type" />
                            <asp:BoundField DataField="Start_Date" HeaderText="Start Date" DataFormatString="{0:dd/MM/yyyy}" SortExpression="Start_Date" />
                            <asp:BoundField DataField="End_Date" HeaderText="End Date" DataFormatString="{0:dd/MM/yyyy}" SortExpression="End_Date" />
                            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                            <asp:BoundField DataField="Remarks" HeaderText="Remarks" SortExpression="Remarks" />
                            <asp:TemplateField HeaderText="Evidence">
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# Eval("Leave_ID") %>'  OnClick="DownloadFile">
                                        <img src="Images/Icon_64.ico" />
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton2" runat="server" CommandArgument='<%# Eval("Leave_ID") %>' OnClick="ApproveLeave">
                                        <img src="Images/wb32_111.ico" />
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="LinkButton3" runat="server" CommandArgument='<%# Eval("Leave_ID") %>' OnClick="RejectLeave">
                                        <img src="Images/wb32_112.ico" />
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            No Record Available
                        </EmptyDataTemplate>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:calicompConnection %>" SelectCommand="Select_leaves" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                </div>
            </div>
        </div>
    </main>
</asp:Content>
