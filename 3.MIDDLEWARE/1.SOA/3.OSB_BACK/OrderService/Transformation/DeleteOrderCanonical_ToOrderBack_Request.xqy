xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://touresBalon.com/schema/orders";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/OrderCanonicalModel.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/db_DeleteOrder";
(:: import schema at "../Resources/db_DeleteOrder_sp.xsd" ::)

declare namespace cus = "http://touresBalon.com/schema/customer";

declare variable $Input as element() (:: schema-element(ns1:deleteOrderRequest) ::) external;

declare function local:func($Input as element() (:: schema-element(ns1:deleteOrderRequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:P_SALES_ORDER_ID>{fn:data($Input/ns1:orderId)}</ns2:P_SALES_ORDER_ID>
        <ns2:P_ORDER_STATUS_NAME>{fn:data($Input/ns1:customer/cus:statusName)}</ns2:P_ORDER_STATUS_NAME>
        <ns2:P_COMMENTS>{fn:data($Input/ns1:comments)}</ns2:P_COMMENTS>
    </ns2:InputParameters>
};

local:func($Input)
