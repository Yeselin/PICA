xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://touresBalon.com/schema/CustomerService";
(:: import schema at "../../../../ESB_COMMONS/Resources/Schemas/xsd/OperationCanonicalModel.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/dbGetCustomer";
(:: import schema at "../Resources/dbGetCustomer_sp.xsd" ::)

declare namespace cus = "http://touresBalon.com/schema/customer";

declare variable $Input as element() (:: schema-element(ns1:getCustomerRequest) ::) external;

declare function local:func($Input as element() (:: schema-element(ns1:getCustomerRequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:P_DOCUMENT_TYPE_NAME>{fn:data($Input/ns1:customer/cus:idType)}</ns2:P_DOCUMENT_TYPE_NAME>
        <ns2:P_DOCUMENT_ID>{fn:data($Input/ns1:customer/cus:id)}</ns2:P_DOCUMENT_ID>
    </ns2:InputParameters>
};

local:func($Input)
