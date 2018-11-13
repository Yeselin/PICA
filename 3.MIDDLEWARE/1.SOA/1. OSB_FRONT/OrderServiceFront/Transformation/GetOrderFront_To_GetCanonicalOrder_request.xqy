xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://touresBalon.com/schema/orders";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/OrderCanonicalModel.xsd" ::)
declare namespace ns1="http://touresBalon.com/schema/ordersFront";
(:: import schema at "../Resources/xsd/OrderFront.xsd" ::)

declare namespace cus = "http://touresBalon.com/schema/customer";

declare variable $Input as element() (:: schema-element(ns1:getOrderRequest) ::) external;

declare function local:func($Input as element() (:: schema-element(ns1:getOrderRequest) ::)) as element() (:: schema-element(ns2:getOrderRequest) ::) {
    <ns2:getOrderRequest>
        <ns2:customer>
            <cus:id>{fn:data($Input/ns1:customerInfo/ns1:document)}</cus:id>
            <cus:idType>{fn:data($Input/ns1:customerInfo/ns1:documentType)}</cus:idType>
        </ns2:customer>
    </ns2:getOrderRequest>
};

local:func($Input)
