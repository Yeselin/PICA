xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://touresBalon.com/schema/CustomerService";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/OperationCanonicalModel.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/dbUpdateCustomer";
(:: import schema at "../Resources/dbUpdateCustomer_sp.xsd" ::)

declare namespace cus = "http://touresBalon.com/schema/customer";

declare variable $Input as element() (:: schema-element(ns1:OutputParameters) ::) external;

declare function local:func($Input as element() (:: schema-element(ns1:OutputParameters) ::)) as element() (:: schema-element(ns2:updateCustomerResponse) ::) {
    <ns2:updateCustomerResponse>
        <ns2:status>
            <cus:code>{fn:data($Input/ns1:P_RESPONSE_ID)}</cus:code>
            <cus:description>{fn:data($Input/ns1:P_RESPONSE_DESC)}</cus:description>
        </ns2:status>
    </ns2:updateCustomerResponse>
};

local:func($Input)
