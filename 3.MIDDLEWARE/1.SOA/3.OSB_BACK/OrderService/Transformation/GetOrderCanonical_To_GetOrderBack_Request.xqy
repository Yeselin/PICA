xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://touresBalon.com/schema/orders";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/OrderCanonicalModel.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/dbGetOrder";
(:: import schema at "../Resources/dbGetOrder_sp.xsd" ::)

declare namespace cus = "http://touresBalon.com/schema/customer";

declare variable $Input as element() (:: schema-element(ns2:getOrderRequest) ::) external;

declare function local:func($Input as element() (:: schema-element(ns2:getOrderRequest) ::)) as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:P_CUSTOMER_DOCUMENT_TYPE_NAME>{fn:data($Input/ns2:customer/cus:idType)}</ns1:P_CUSTOMER_DOCUMENT_TYPE_NAME>
        <ns1:P_CUSTOMER_DOCUMENT_ID>{xs:string(fn:data($Input/ns2:customer/cus:id))}</ns1:P_CUSTOMER_DOCUMENT_ID>
    </ns1:InputParameters>
};

local:func($Input)
