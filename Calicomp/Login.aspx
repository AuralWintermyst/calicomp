<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Calicomp.LoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Scheduling System for part time staff">
    <meta name="author" content="Brandon Butler">
    <title>Login</title>
    <!-- Stylesheets -->
    <link rel="stylesheet" href="Content/bootstrap.min.css">
    <link href="Content/login.css" rel="stylesheet">


</head>
<body class="text-center bg-img">
    <form class=" container form-signin" runat="server">
      <img class="mb-4" src="Images/Icon_16.ico" alt="" width="72" height="72">
      <h1 class="h3 mb-3 font-weight-normal">Calicomp</h1>
      <label for="inputEmail" class="sr-only" runat="server">Email address</label>
      <input type="email" id="inputEmail" class="form-control" placeholder="Email address" runat="server" required autofocus>
      <label for="inputPassword" class="sr-only" runat="server">Password</label>
      <input type="password" id="inputPassword" class="form-control" placeholder="Password" runat="server" required>
      <asp:Button ID="Button1" runat="server" Text="Login" OnClick="Button1_Click" CssClass="btn btn-lg btn-primary btn-block" />
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
      <p class="mt-5 mb-3 text-muted">&copy; Brandon Butler 2018-2019 Artwork by Miyuki Omori</p>
    </form>
  </body>
</html>
