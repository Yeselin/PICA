xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://touresBalon.com/schema/orders";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/OrderCanonicalModel.xsd" ::)
declare namespace ns2="http://touresBalon.com/schema/ordersFront";
(:: import schema at "../Resources/xsd/OrderFront.xsd" ::)

declare variable $Input as element() (:: schema-element(ns1:createOrderResponse) ::) external;

declare function local:func($Input as element() (:: schema-element(ns1:createOrderResponse) ::)) as element() (:: schema-element(ns2:createOrderResponse) ::) {
    <ns2:createOrderResponse>
        <ns2:orderId>{xs:int(fn:data($Input/ns1:createOrderResponse/ns1:orderId))}</ns2:orderId>
        <ns2:orderDate>{fn:data($Input/ns1:createOrderResponse/ns1:orderDate)}</ns2:orderDate>
        <ns2:status>{fn:data("EN VALIDACION")}</ns2:status>
        <ns2:comment>{fn:data($Input/ns1:createOrderResponse/ns1:status/ns1:comment)}</ns2:comment>
    </ns2:createOrderResponse>
};

local:func($Input)
