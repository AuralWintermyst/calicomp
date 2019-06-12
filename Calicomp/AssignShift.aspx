<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="AssignShift.aspx.cs" Inherits="Calicomp.AssignShift" %>

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
                <h2 class="mb-3">Assign Shift</h2>
                <div class="row">
                    <asp:GridView ID="GridView1" runat="server" ShowHeaderWhenEmpty="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" DataKeyNames="Shift_ID" OnRowUpdating="GridView1_RowUpdating" CssClass="table table-hover table-striped" BackColor="White" GridLines="None"
                        OnPreRender="GridView1_PreRender" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="5">
                        <Columns>
                            <asp:BoundField HeaderText="Shift" DataField="Shift" ReadOnly="True" />
                            <asp:BoundField DataField="Start_time" HeaderText="Start Time" SortExpression="Start_time" ReadOnly="True" />
                            <asp:BoundField DataField="End_time" HeaderText="End Time" SortExpression="End_time" ReadOnly="True" />
                            <asp:BoundField HeaderText="Date" DataField="Date" DataFormatString="{0:dd/MM/yyyy}" ReadOnly="True" />
                            <asp:BoundField DataField="Duration" HeaderText="Duration" SortExpression="Duration" ReadOnly="True" />
                            <asp:TemplateField HeaderText="First Name" SortExpression="First_Name">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" SelectedValue='<%# Bind("Staff_ID") %>' AppendDataBoundItems="True" DataTextField="First_Name" DataValueField="Staff_ID" Height="28px">
                                        <asp:ListItem Text="Select" Value="" />
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:calicompConnection %>" SelectCommand="SELECT DISTINCT [Staff_ID], [First_Name] FROM [Staff] WHERE ([Type] = @Type)">
                                        <SelectParameters>
                                            <asp:Parameter DefaultValue="Employee" Name="Type" Type="String" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("First_Name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField ButtonType="Button" ShowEditButton="True" ControlStyle-CssClass="btn btn-primary" CausesValidation="False" />
                        </Columns>
                        <EmptyDataTemplate>
                            No Record Available
                        </EmptyDataTemplate>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:calicompConnection %>" SelectCommand="Select_shifts" SelectCommandType="StoredProcedure" UpdateCommand="ShiftDateValidation" UpdateCommandType="StoredProcedure" OnUpdated="SqlDataSource2_Updated">
                        <UpdateParameters>
                            <asp:Parameter Name="Staff_ID" Type="Int32" />
                            <asp:Parameter Name="Shift_ID" Type="Int32" />
                            <asp:Parameter Direction="InputOutput" Name="checker" Type="Int32" DefaultValue="0" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </div>
                <hr class="mb-4">
                <h4 class="mb-3">Automate assignment</h4>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="datepicker">Date</label>
                        <input type="date" class="form-control" id="datepicker" itemid="datepicker" runat="server" required />
                        <div class="invalid-feedback">
                            Please enter a valid date.
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="duration">Duration (Days)</label>
                        <input type="number" value="2" data-decimals="0" min="1" max="9" step="1" id="duration" itemid="duration" runat="server" />
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="time_constraint">Time Constraint (Hours)</label>
                        <input type="number" value="2" data-decimals="0" min="1" max="9" step="1" id="time_constraint" itemid="duration" runat="server" />
                    </div>
                    <div class="col-md-6 mb-3">
                        <p>
                            To automate assignment of staff, select the range of dates and time constraint to filter the data.  
                        </p>
                    </div>
                    <hr class="mb-4">
                    <asp:Button CssClass="btn btn-primary btn-lg btn-block" type="submit" runat="server" OnClick="automate_Click" ID="automate" Text="Automate" />
                </div>
            </div>
        </div>
    </main>
</asp:Content>
