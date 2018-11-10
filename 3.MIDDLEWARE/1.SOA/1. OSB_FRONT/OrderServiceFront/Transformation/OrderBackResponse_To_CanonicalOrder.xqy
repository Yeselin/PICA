xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://touresBalon.com/schema/orders";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/OrderCanonicalModel.xsd" ::)

declare variable $Input as element() (:: schema-element(ns1:createOrderResponse) ::) external;

declare function local:func($Input as element() (:: schema-element(ns1:createOrderResponse) ::)) as element() (:: schema-element(ns1:createOrderRequest) ::) {
    <ns1:createOrderRequest>
        <ns1:orderId>{fn:data(xs:int($Input/ns1:orderId))}</ns1:orderId>
        <ns1:orderStatus>{fn:data($Input/ns1:status/ns1:status)}</ns1:orderStatus>
        <ns1:comments>{fn:data($Input/ns1:status/ns1:comment)}</ns1:comments>
    </ns1:createOrderRequest>
};

local:func($Input)
