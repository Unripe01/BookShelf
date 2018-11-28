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
        <%--<asp:HyperLink ID="HyperLinkRegist" runat="server" NavigateUrl="~/BookRegister.aspx">登録</asp:HyperLink>--%>
    </div>

    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div>
                    <asp:Label ID="titleLabel" runat="server" Text="タイトルであいまい検索"></asp:Label>
                    <asp:TextBox ID="txtTitle" runat="server"></asp:TextBox>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
                        DataKeyNames="ISBN" 
                        AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" 
                        BorderStyle="None" BorderWidth="1px" CellPadding="4" 
                        DataSourceID="LinqDataSource1" ForeColor="Black" GridLines="Vertical" 
                        OnRowCreated="GridView1_RowCreated" Width="100%"
                        >
                        <Columns>
                            <asp:BoundField DataField="ISBN" HeaderText="ISBN" ItemStyle-Width="100" SortExpression="ISBN">
                            <ItemStyle Width="100px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Title" HeaderText="Title" ItemStyle-Width="400" SortExpression="Title">
                            <ItemStyle Width="400px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="PublicationDateString" HeaderText="Publication" ItemStyle-Width="80" SortExpression="PublicationDateString">
                            <ItemStyle Width="80px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ListPrice" DataFormatString="{0:#,##0}円" HeaderText="ListPrice" ItemStyle-Width="80">
                            <ItemStyle Width="80px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Publisher" HeaderText="Publisher" ItemStyle-Width="100">
                            <ItemStyle Width="100px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Author" HeaderText="Author" ItemStyle-Width="150">
                            <ItemStyle Width="150px" />
                            </asp:BoundField>
                            <asp:HyperLinkField DataTextField="TinyImageURL" 
                                DataTextFormatString="<img src='{0}' alt='image'>" 
                                HeaderText="URL" ItemStyle-Width="40" 
                                NavigateUrl="DetailPageURL" Target="_blank" 
                                DataNavigateUrlFields="DetailPageURL"
                                Text="No Image"
                                ><ItemStyle Width="40px" />
                            </asp:HyperLinkField>
                            <asp:BoundField DataField="Location" HeaderText="Location" ItemStyle-Width="100" SortExpression="Location">
                            <ItemStyle Width="100px" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="削除">
                                <ItemTemplate>
                                    <asp:Button runat="server" CausesValidation="false" 
                                        CommandName="Delete" 
                                        OnClientClick="return confirm('本当に削除しますか？');" 
                                        Text="削除" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <AlternatingRowStyle BackColor="White" />
                        <FooterStyle BackColor="#CCCC99" />
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <RowStyle BackColor="#F7F7DE" Height="100px" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                    </asp:GridView>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

           <asp:LinqDataSource ID="LinqDataSource1" 
               runat="server" 
               ContextTypeName="BookshelfDSDataContext" 
               EntityTypeName="" TableName="Books" EnableDelete="True"
           />
        </form>

           </body>
</html>
