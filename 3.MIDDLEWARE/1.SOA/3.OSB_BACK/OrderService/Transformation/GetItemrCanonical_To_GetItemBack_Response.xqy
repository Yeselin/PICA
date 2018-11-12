xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://touresBalon.com/schema/orders";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/OrderCanonicalModel.xsd" ::)

declare namespace pro = "http://touresBalon.com/schema/products";

declare variable $Input as element() external;

declare function local:func($Input as element()) as element() (:: schema-element(ns1:getOrderResponse) ::) {
    <ns1:getOrderResponse>
        <ns1:order>
            <ns1:orderId>{fn:data($Input/ORDER/ID)}</ns1:orderId>
            <ns1:orderDate>{fn:data($Input/ORDER/ORDER_DATE)}</ns1:orderDate>
            <ns1:orderPrice>{fn:data($Input/ORDER/PRICE)}</ns1:orderPrice>
            <ns1:orderStatus>{fn:data($Input/ORDER/STATUS_NAME)}</ns1:orderStatus>
            <ns1:comments>{fn:data($Input/ORDER/COMMENTS)}</ns1:comments>    
    {
    for $order in $Input/ORDER/ITEM
    return 
            <ns1:product>
                <ns1:product>
                    <pro:productId>{fn:data($order/PRODUCT_ID)}</pro:productId>
                    <pro:productName>{fn:data($order/PRODUCT_NAME)}</pro:productName>
                    <pro:cost>{fn:data($order/PRICE_ITEM)}</pro:cost>
                </ns1:product>
                <ns1:quantity>{fn:data($order/QUANTITY)}</ns1:quantity>
            </ns1:product>
    }
      </ns1:order>
    </ns1:getOrderResponse>
};

local:func($Input)