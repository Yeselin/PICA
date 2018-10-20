xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://touresBalon.com/schema/CustomerService";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/OperationCanonicalModel.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/dbDeleteCustomer";
(:: import schema at "../Resources/dbDeleteCustomer_sp.xsd" ::)

declare namespace cus = "http://touresBalon.com/schema/customer";

declare variable $Input as element() (:: schema-element(ns1:deleteCustomerRequest) ::) external;

declare function local:func($Input as element() (:: schema-element(ns1:deleteCustomerRequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:P_DOCUMENT_TYPE_NAME>{fn:data($Input/ns1:customer/cus:idType)}</ns2:P_DOCUMENT_TYPE_NAME>
        <ns2:P_DOCUMENT_ID>{fn:data($Input/ns1:customer/cus:id)}</ns2:P_DOCUMENT_ID>
        <ns2:P_CUSTOMER_STATUS_NAME>{fn:data($Input/ns1:customer/cus:statusName)}</ns2:P_CUSTOMER_STATUS_NAME>
    </ns2:InputParameters>
};

local:func($Input)
