xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://touresBalon.com/schema/orders";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/OrderCanonicalModel.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/dbDeleteCustomer";
(:: import schema at "../../TECH_ADAPTERS/DB_ADAPTERS/Oracle/Resources/dbDeleteCustomer_sp.xsd" ::)

declare variable $Input as element() (:: schema-element(ns1:OutputParameters) ::) external;

declare function local:func($Input as element() (:: schema-element(ns1:OutputParameters) ::)) as element() (:: schema-element(ns2:deleteOrderResponse) ::) {
    <ns2:deleteOrderResponse>
        <ns2:status>
            <ns2:code>{fn:data($Input/ns1:P_RESPONSE_ID)}</ns2:code>
            <ns2:description>{fn:data($Input/ns1:P_RESPONSE_DESC)}</ns2:description>
        </ns2:status>
    </ns2:deleteOrderResponse>
};

local:func($Input)
