xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://touresBalon.com/schema/orders";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/OrderCanonicalModel.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/db_CreateOrder";
(:: import schema at "../Resources/db_CreateOrder_sp.xsd" ::)

declare namespace pro = "http://touresBalon.com/schema/products";

declare variable $Input as element() (:: schema-element(ns1:OutputParameters) ::) external;

declare function local:func($Input as element() (:: schema-element(ns1:OutputParameters) ::)) as element() (:: schema-element(ns2:createOrderResponse) ::) {
    <ns2:createOrderResponse>
        <ns2:status>
            <ns2:code>{fn:data($Input/ns1:P_RESPONSE_ID)}</ns2:code>
            <ns2:description>{fn:data($Input/ns1:P_RESPONSE_DESC)}</ns2:description>
        </ns2:status>
        <ns2:orderId>{fn:data($Input/ns1:P_OUT_SALES_ORDER_ID)}</ns2:orderId>
    </ns2:createOrderResponse>
};

local:func($Input)
