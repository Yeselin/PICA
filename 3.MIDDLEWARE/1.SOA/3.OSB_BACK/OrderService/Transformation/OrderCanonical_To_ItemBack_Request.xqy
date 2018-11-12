xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://touresBalon.com/schema/orders";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/OrderCanonicalModel.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/dbCreateItem";
(:: import schema at "../Resources/Item/dbCreateItem_sp.xsd" ::)

declare namespace pro = "http://touresBalon.com/schema/products";

declare variable $Input as element() (:: schema-element(ns1:createOrderRequest) ::) external;

declare function local:func($Input as element() (:: schema-element(ns1:createOrderRequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:P_PRODUCT_ID>{fn:data($Input/ns1:createOrder/ns1:order/ns1:product/pro:productId)}</ns2:P_PRODUCT_ID>
        <ns2:P_PRODUCT_NAME>{fn:data($Input/ns1:createOrder/ns1:order/ns1:product/pro:productName)}</ns2:P_PRODUCT_NAME>
        <ns2:P_PARTNUM>{fn:data($Input/ns1:createOrder/ns1:order/ns1:product/pro:code)}</ns2:P_PARTNUM>
        <ns2:P_PRICE_ITEM>{fn:data($Input/ns1:createOrder/ns1:order/ns1:product/pro:cost)}</ns2:P_PRICE_ITEM>
        <ns2:P_QUANTITY>{fn:data($Input/ns1:createOrder/ns1:order/ns1:quantity)}</ns2:P_QUANTITY>
        <ns2:P_SALES_ORDER_ID>{fn:data($Input/ns1:createOrder/ns1:orderId)}</ns2:P_SALES_ORDER_ID>
        <ns2:P_ITEM_STATUS_NAME>{fn:data($Input/ns1:createOrder/ns1:orderStatus)}</ns2:P_ITEM_STATUS_NAME>
    </ns2:InputParameters>
};

local:func($Input)
