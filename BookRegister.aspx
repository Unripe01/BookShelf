<%@ Page Language="C#" Theme="Theme1"
    AutoEventWireup="true" CodeFile="BookRegister.aspx.cs" Inherits="BookRegister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>書籍登録</title>
    <style type="text/css">
        <!--
        .active {ime-mode: active;}
        .disabled {ime-mode: disabled;}
        -->
    </style>

</head>
<body>
    <h1>書籍登録</h1>
    <div><p>メニュー</p>
        <asp:HyperLink ID="HyperLinkSearch" runat="server" NavigateUrl="~/Default.aspx">検索</asp:HyperLink>
        <asp:HyperLink ID="HyperLinkRegist" runat="server">登録</asp:HyperLink>
    </div>

    <form id="form1" runat="server">
    <div>
        <asp:Label ID="isbnLabel" runat="server" Text="isbn"></asp:Label>
        <asp:TextBox ID="isbn" runat="server" type="tel" CssClass="disabled"></asp:TextBox>
        <asp:Button ID="btnRegist" runat="server" Text="Regist" OnClick="btnRegist_Click" />
    </div>
    <div>
        <p>
        <asp:Button ID="Button1" runat="server" Text="Clear" OnClick="Button1_Click" />
        </p>
        <p>
        <asp:Label ID="LabelMessage" runat="server" Text=""></asp:Label>
        </p>
    </div>
    </form>
    </body>
</html>
