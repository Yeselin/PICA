xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://touresBalon.com/schema/orders";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/OrderCanonicalModel.xsd" ::)

declare namespace pro = "http://touresBalon.com/schema/products";

declare variable $Input as element() external;

declare function local:func($Input as element()) as element() (:: schema-element(ns1:getOrderResponse) ::) {
    <ns1:getOrderResponse>
    {
    for $order in $Input/ORDER
    return 
        <ns1:order>
            <ns1:orderId>{fn:data($order/ID)}</ns1:orderId>
            <ns1:orderDate>{fn:data($order/ORDER_DATE)}</ns1:orderDate>
            <ns1:orderPrice>{fn:data($order/PRICE)}</ns1:orderPrice>
            <ns1:orderStatus>{fn:data($order/STATUS_NAME)}</ns1:orderStatus>
            <ns1:comments>{fn:data($order/COMMENTS)}</ns1:comments>
        </ns1:order>
    }
    </ns1:getOrderResponse>
};

local:func($Input)