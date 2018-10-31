xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://touresBalon.com/schema/orders";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/OrderCanonicalModel.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/db_DeleteItem";
(:: import schema at "../Resources/Item/db_DeleteItem_sp.xsd" ::)

declare variable $Input as element() (:: schema-element(ns1:deleteOrderRequest) ::) external;

declare function local:func($Input as element() (:: schema-element(ns1:deleteOrderRequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:P_SALES_ORDER_ITEM_ID>{fn:data($Input/ns1:orderId)}</ns2:P_SALES_ORDER_ITEM_ID>
        <ns2:P_ITEM_STATUS_NAME>NO LONGER AVAILABLE</ns2:P_ITEM_STATUS_NAME>
    </ns2:InputParameters>
};

local:func($Input)
