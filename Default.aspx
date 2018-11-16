<%@ Page Language="C#" Theme="Theme1"
    AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>本棚</title>
</head>
<body>
    <h1>書籍一覧</h1>
    <div><p>メニュー</p>
        <asp:HyperLink ID="HyperLinkSearch" runat="server">検索</asp:HyperLink>
        <asp:HyperLink ID="HyperLinkRegist" runat="server" NavigateUrl="~/BookRegister.aspx">登録</asp:HyperLink>
    </div>
<%--    <form id="form1" runat="server">
    <div >
        <asp:Label ID="isbnLabel" runat="server" Text="isbn"></asp:Label>
        <asp:TextBox ID="isbn" runat="server"></asp:TextBox>
        <asp:Label ID="titleLabel" runat="server" Text="title"></asp:Label>
        <asp:TextBox ID="title" runat="server"></asp:TextBox>
        <asp:Label ID="AuthorLabel" runat="server" Text="Author"></asp:Label>
        <asp:TextBox ID="Author" runat="server"></asp:TextBox>
        <p><asp:Button ID="btnSearch" runat="server" Text="Search" /></p>
    </div>
    </form>--%>
        <asp:DataGrid runat="server" DataSourceID="SqlDataSource1" CellPadding="4" ForeColor="Black" GridLines="Vertical" AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px">
             <Columns>
                <asp:BoundColumn DataField="ISBN" HeaderText="ISBN" ItemStyle-Width="100" />
                <asp:BoundColumn DataField="EAN" HeaderText="EAN" ItemStyle-Width="100"/>
                <asp:BoundColumn DataField="Title" HeaderText="Title" ItemStyle-Width="400"/>
                <asp:BoundColumn DataField="PublicationDateString" HeaderText="Publication" ItemStyle-Width="80"/>
                <asp:BoundColumn DataField="ListPrice" HeaderText="ListPrice" DataFormatString="{0:#,##0}円" ItemStyle-Width="80"/>
                <asp:BoundColumn DataField="Publisher" HeaderText="Publisher" ItemStyle-Width="100"/>
                <asp:BoundColumn DataField="Author" HeaderText="Author" ItemStyle-Width="150"/>
                <asp:HyperLinkColumn DataTextField="imageURL" ItemStyle-Width="50"
                    DataTextFormatString="<img src='{0}' alt='image'"
                    DataNavigateUrlField="DetailPageURL" HeaderText="URL" Target="_blank" />
            </Columns>
            <AlternatingItemStyle BackColor="White" />
            <FooterStyle BackColor="#CCCC99" />
            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
            <ItemStyle BackColor="#F7F7DE" />
            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" Mode="NumericPages" />
            <SelectedItemStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
    </asp:DataGrid>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BookshelfConnectionString %>"
            SelectCommand="SELECT *, isnull( TinyImageURL, 'image') as imageURL FROM [Books]">
        </asp:SqlDataSource>
    </body>
</html>
