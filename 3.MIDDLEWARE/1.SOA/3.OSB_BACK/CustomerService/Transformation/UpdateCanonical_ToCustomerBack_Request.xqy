xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://touresBalon.com/schema/CustomerService";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/OperationCanonicalModel.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/dbUpdateCustomer";
(:: import schema at "../Resources/dbUpdateCustomer_sp.xsd" ::)

declare namespace cus = "http://touresBalon.com/schema/customer";

declare namespace ord = "http://touresBalon.com/schema/orders";

declare variable $Insert as element() (:: schema-element(ns1:updateCustomerRequest) ::) external;

declare function local:func($Insert as element() (:: schema-element(ns1:updateCustomerRequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:P_DOCUMENT_TYPE_NAME>{fn:data($Insert/ns1:customer/cus:idType)}</ns2:P_DOCUMENT_TYPE_NAME>
        <ns2:P_DOCUMENT_ID>{fn:data($Insert/ns1:customer/cus:id)}</ns2:P_DOCUMENT_ID>
        <ns2:P_FIRST_NAME>{fn:data($Insert/ns1:customer/cus:name)}</ns2:P_FIRST_NAME>
        <ns2:P_LAST_NAME>{fn:data($Insert/ns1:customer/cus:lastname)}</ns2:P_LAST_NAME>
        <ns2:P_PHONE_NUMBER>{fn:data($Insert/ns1:customer/cus:contact/cus:phoneNumber)}</ns2:P_PHONE_NUMBER>
        <ns2:P_EMAIL>{fn:data($Insert/ns1:customer/cus:contact/cus:email)}</ns2:P_EMAIL>
        <ns2:P_PASSWORD>{fn:data($Insert/ns1:customer/cus:password)}</ns2:P_PASSWORD>
        <ns2:P_CUSTOMER_CATEGORY_NAME>{fn:data($Insert/ns1:customer/cus:category)}</ns2:P_CUSTOMER_CATEGORY_NAME>
        <ns2:P_CREDITCARD_NAME>{fn:data('VISA')}</ns2:P_CREDITCARD_NAME>
        <ns2:P_CREDITCARD_NUMBER>{fn:data($Insert/ns1:paymentMethod/ord:franchise)}</ns2:P_CREDITCARD_NUMBER>
        <ns2:P_CUSTOMER_STATUS_NAME>{fn:data($Insert/ns1:customer/cus:statusName)}</ns2:P_CUSTOMER_STATUS_NAME>
        <ns2:P_STREET>{fn:data($Insert/ns1:customer/cus:contact/cus:location/cus:street)}</ns2:P_STREET>
        <ns2:P_STATE>{fn:data($Insert/ns1:customer/cus:contact/cus:location/cus:state)}</ns2:P_STATE>
        <ns2:P_ZIP>{fn:data($Insert/ns1:customer/cus:contact/cus:location/cus:zip)}</ns2:P_ZIP>
        <ns2:P_COUNTRY>{fn:data($Insert/ns1:customer/cus:contact/cus:location/cus:country)}</ns2:P_COUNTRY>
        <ns2:P_CITY>{fn:data($Insert/ns1:customer/cus:contact/cus:phoneNumber)}</ns2:P_CITY>
    </ns2:InputParameters>
};

local:func($Insert)
