xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://touresBalon.com/schema/CustomerService";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/OperationCanonicalModel.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/dbGetCustomer";
(:: import schema at "../Resources/dbGetCustomer_sp.xsd" ::)

declare namespace cus = "http://touresBalon.com/schema/customer";

declare namespace ord = "http://touresBalon.com/schema/orders";

declare variable $Input as element() (:: schema-element(ns1:OutputParameters) ::) external;

declare function local:func($Input as element() (:: schema-element(ns1:OutputParameters) ::)) as element() (:: schema-element(ns2:getCustomerResponse) ::) {
    <ns2:getCustomerResponse>
        <ns2:customer>
            <cus:name>{fn:data($Input/ns1:P_FIRST_NAME)}</cus:name>
            <cus:middle_name></cus:middle_name>
            <cus:lastname>{fn:data($Input/ns1:P_LAST_NAME)}</cus:lastname>
            <cus:id>{fn:data($Input/ns1:P_OUT_DOCUMENT_ID)}</cus:id>
            <cus:idType>{fn:data($Input/ns1:P_OUT_DOCUMENT_TYPE_ID)}</cus:idType>
            <cus:contact>
                <cus:phoneNumber>{fn:data($Input/ns1:P_PHONE_NUMBER)}</cus:phoneNumber>
                <cus:email>{fn:data($Input/ns1:P_EMAIL)}</cus:email>
                <cus:location>
                    <cus:street>{fn:data($Input/ns1:P_STREET)}</cus:street>
                    <cus:state>{fn:data($Input/ns1:P_STATE)}</cus:state>
                    <cus:zip>{fn:data($Input/ns1:P_ZIP)}</cus:zip>
                    <cus:city>{fn:data($Input/ns1:P_CITY)}</cus:city>
                    <cus:country>{fn:data($Input/ns1:P_COUNTRY)}</cus:country>
                </cus:location>
            </cus:contact>
            <cus:password>{fn:data($Input/ns1:P_PASSWORD)}</cus:password>
            <cus:category>{fn:data($Input/ns1:P_CUSTOMER_CATEGORY_NAME)}</cus:category>
            <cus:statusName></cus:statusName>
        </ns2:customer>
        <ns2:paymentMethod>
            <ord:cardNumber>{fn:data($Input/ns1:P_CREDITCARD_NUMBER)}</ord:cardNumber>
            <ord:franchise>{fn:data($Input/ns1:P_CREDITCARD_NAME)}</ord:franchise>
        </ns2:paymentMethod>
        <ns2:status>
            <cus:code>{fn:data($Input/ns1:P_RESPONSE_ID)}</cus:code>
            <cus:description>{fn:data($Input/ns1:P_RESPONSE_DESC)}</cus:description>
        </ns2:status>
    </ns2:getCustomerResponse>
};

local:func($Input)
