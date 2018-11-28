using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Security.Cryptography;
using System.Net;
using System.Xml;
using System.Xml.Linq;

/// <summary>
/// Product Advertising API 
/// </summary>
public class PAAPI
{
    const int ISBN_LENGTH10 = 10;
    const int ISBN_LENGTH13 = 13;
    private const string MY_AWS_ACCESS_KEY_ID = SecretAWSKeys.ACCESS_KEY_ID;
    private const string MY_AWS_SECRET_KEY = SecretAWSKeys.AWS_SECRET_KEY;
    private const string DESTINATION = "webservices.amazon.co.jp";
    private const string ASSOCIATE_TAG = SecretAWSKeys.ASSOCIATE_TAG;

    public PAAPI()
    {
    }

    /// <summary>
    /// リクエストURL作成
    /// </summary>
    /// <param name="isbn"></param>
    /// <returns></returns>
    public string CreateRequestUrl(string isbn)
    {
        var isbnWithoutSign = isbn.Replace("-", "");
        if (isbnWithoutSign.Length != ISBN_LENGTH10
            && isbnWithoutSign.Length != ISBN_LENGTH13
            )
        {
            throw new ArgumentException("ISBNの長さ不正");
        }

        SignedRequestHelper helper = new SignedRequestHelper(MY_AWS_ACCESS_KEY_ID, MY_AWS_SECRET_KEY, DESTINATION, ASSOCIATE_TAG);

        IDictionary<string, string> request = new Dictionary<string, String>();
        request["Service"] = "AWSECommerceService";
        request["Operation"] = "ItemLookup";
        request["IdType"] = "ISBN";
        request["ItemId"] = isbnWithoutSign;
        request["SearchIndex"] = "Books";
        request["ResponseGroup"] = "Images,ItemAttributes,Offers";
        string requestUrl = helper.Sign(request);

        System.IO.File.AppendAllText(@"V:\localweb\log\bookshelf.log", "RequestUrl:" + requestUrl);
        return requestUrl;
    }

    /// <summary>
    /// リクエスト結果取得
    /// </summary>
    /// <param name="url"></param>
    /// <returns></returns>
    public XmlDocument GetResponse(string url)
    {
        HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(url);
        HttpWebResponse response = (HttpWebResponse)request.GetResponse();
        XmlDocument xmlDocument = new XmlDocument();
        xmlDocument.Load(response.GetResponseStream());
        return xmlDocument;
    }

    /// <summary>
    /// リクエスト結果解析
    /// </summary>
    /// <param name="response"></param>
    /// <returns></returns>
    public Books ParseResponse(XmlDocument response)
    {
        var bookTag = new Books();
        XmlNamespaceManager xmlNsManager = new XmlNamespaceManager(response.NameTable);
        xmlNsManager.AddNamespace("ns", "http://webservices.amazon.com/AWSECommerceService/2011-08-01");

        //ItemAttributes
        XmlNodeList itemAttributes = response.SelectNodes("/ns:ItemLookupResponse/ns:Items/ns:Item/ns:ItemAttributes[.//ns:ISBN]", xmlNsManager);
        if (itemAttributes.Count < 1)
        {
            throw new HttpParseException("XMLノード解析：ISBN が存在しません。");
        }

        bookTag.ISBN = itemAttributes[0].SelectSingleNode("ns:ISBN", xmlNsManager).InnerText;
        bookTag.EAN = itemAttributes[0].SelectSingleNode("ns:EAN", xmlNsManager).InnerText;
        bookTag.Title = itemAttributes[0].SelectSingleNode("ns:Title", xmlNsManager) == null ? null : itemAttributes[0].SelectSingleNode("ns:Title", xmlNsManager).InnerText;
        bookTag.Author = itemAttributes[0].SelectSingleNode("ns:Author", xmlNsManager) == null ? null : itemAttributes[0].SelectSingleNode("ns:Author", xmlNsManager).InnerText;
        bookTag.PublicationDateString = itemAttributes[0].SelectSingleNode("ns:PublicationDate", xmlNsManager) == null ? null : itemAttributes[0].SelectSingleNode("ns:PublicationDate", xmlNsManager).InnerText;
        bookTag.Publisher = itemAttributes[0].SelectSingleNode("ns:Publisher", xmlNsManager) == null ? null : itemAttributes[0].SelectSingleNode("ns:Publisher", xmlNsManager).InnerText;

        //Offers
        XmlNodeList offerSummary = response.SelectNodes("/ns:ItemLookupResponse/ns:Items/ns:Item/ns:OfferSummary", xmlNsManager);
        if (offerSummary.Count < 1)
        {
            throw new HttpParseException("XMLノード解析：OfferSummary が存在しません。");
        }
        bookTag.ListPrice = decimal.Parse(
            offerSummary[0].SelectSingleNode("ns:LowestNewPrice/ns:Amount", xmlNsManager) == null 
            ? "0"
            : offerSummary[0].SelectSingleNode("ns:LowestNewPrice/ns:Amount", xmlNsManager).InnerText);

        //Items
        XmlNodeList items = response.SelectNodes("ns:ItemLookupResponse/ns:Items/ns:Item", xmlNsManager);
        if (items.Count < 1)
        {
            throw new HttpParseException("XMLノード解析：Item が存在しません。");
        }
        bookTag.DetailPageURL = items[0].SelectSingleNode("ns:DetailPageURL", xmlNsManager).InnerText;
        bookTag.TinyImageURL = items[0].SelectSingleNode("ns:ImageSets/ns:ImageSet/ns:TinyImage/ns:URL", xmlNsManager) == null ? null : items[0].SelectSingleNode("ns:ImageSets/ns:ImageSet/ns:TinyImage/ns:URL", xmlNsManager).InnerText;
        bookTag.MediumImageURL = items[0].SelectSingleNode("ns:ImageSets/ns:ImageSet/ns:MediumImage/ns:URL", xmlNsManager) == null ? null : items[0].SelectSingleNode("ns:ImageSets/ns:ImageSet/ns:MediumImage/ns:URL", xmlNsManager).InnerText;
        bookTag.InsertDatetime = DateTime.Now;

        return bookTag;
    }

}
