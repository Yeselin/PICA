xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://touresBalon.com/schema/orders";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/OrderCanonicalModel.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/dbCreateOrder";
(:: import schema at "../Resources/dbCreateOrder_sp.xsd" ::)

declare namespace cus = "http://touresBalon.com/schema/customer";

declare variable $Input as element() (:: schema-element(ns1:createOrderRequest) ::) external;

declare function local:func($Input as element() (:: schema-element(ns1:createOrderRequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:P_ORDER_STATUS_NAME>{fn:data($Input/ns1:createOrder/ns1:orderStatus)}</ns2:P_ORDER_STATUS_NAME>
        <ns2:P_COMMENTS>{fn:data($Input/ns1:createOrder/ns1:comments)}</ns2:P_COMMENTS>
        <ns2:P_CUSTOMER_DOCUMENT_TYPE_NAME>{fn:data($Input/ns1:createOrder/ns1:customer/cus:idType)}</ns2:P_CUSTOMER_DOCUMENT_TYPE_NAME>
        <ns2:P_CUSTOMER_DOCUMENT_ID>{fn:data(xs:string($Input/ns1:createOrder/ns1:customer/cus:id))}</ns2:P_CUSTOMER_DOCUMENT_ID>
        <ns2:P_PAYMENT_ID>{fn:data($Input/ns1:createOrder/ns1:paymentMethod/ns1:paymentCode)}</ns2:P_PAYMENT_ID>
        <ns2:P_PAYMENT_STATUS>{fn:data(xs:int($Input/ns1:createOrder/ns1:paymentMethod/ns1:status))}</ns2:P_PAYMENT_STATUS>
  </ns2:InputParameters>
};

local:func($Input)
