using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    /// <summary>
    /// 検索時のフィルタリング処理
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSearch_Click(object sender, EventArgs e)
    {

        var titleCriteria = this.txtTitle.Text;
        LinqDataSource1.Where = "";
        LinqDataSource1.WhereParameters.Clear();
        if (titleCriteria.Length > 0 )
        {
            LinqDataSource1.Where = "Title.Contains(@Title)";
            LinqDataSource1.WhereParameters.Add("Title", titleCriteria);
        }
    }

    /// <summary>
    /// thead,tbody,tfootなどを出力
    /// ※特にhtlm側でヘッダタグをどうにかしているわけではない
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void GridView1_RowCreated(object sender,GridViewRowEventArgs e)
    {
        switch (e.Row.RowType)
        {
            case DataControlRowType.Header:
                e.Row.TableSection = TableRowSection.TableHeader;   // theadを出力
                break;
            case DataControlRowType.DataRow:
                e.Row.TableSection = TableRowSection.TableBody;     // tbodyを出力
                break;
            case DataControlRowType.Footer:
                e.Row.TableSection = TableRowSection.TableFooter;   // tfootを出力
                break;
        }
    }

    /// <summary>
    /// 書籍削除イベント
    /// このメソッドは未使用、GridViewでOnRowCommandイベントを発生させたときに利用する
    /// データの削除は、CommandName="Delete" と、DataKeyNames="ISBN" の機能で実現している。
    /// </summary>
    protected void DataGrid1_DeleteCommand(object source, DataGridCommandEventArgs e)
    {
        var isbn = e.CommandArgument.ToString();
        using (BookshelfDSDataContext db = new BookshelfDSDataContext())
        {
            var existsRecord = db.Books.FirstOrDefault(s => s.ISBN == isbn);
            if (existsRecord != null)
            {
                db.Books.DeleteOnSubmit(existsRecord);
                db.SubmitChanges();
            }
        }
        this.GridView1.DataBind();
    }

}