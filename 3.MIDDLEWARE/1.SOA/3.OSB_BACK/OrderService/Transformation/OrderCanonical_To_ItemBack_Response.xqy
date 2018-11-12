xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://touresBalon.com/schema/orders";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/OrderCanonicalModel.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/dbCreateItem";
(:: import schema at "../Resources/Item/dbCreateItem_sp.xsd" ::)

declare variable $Input as element() (:: schema-element(ns1:OutputParameters) ::) external;

declare function local:func($Input as element() (:: schema-element(ns1:OutputParameters) ::)) as element() (:: schema-element(ns2:createOrderResponse) ::) {
    <ns2:createOrderResponse>
        <ns2:createOrderResponse>
            <ns2:orderId>{xs:string(fn:data($Input/ns1:P_OUT_ORDER_ITEM_ID))}</ns2:orderId>
            <ns2:status>
                <ns2:status>{fn:data($Input/ns1:P_RESPONSE_ID)}</ns2:status>
                <ns2:comment>{fn:data($Input/ns1:P_RESPONSE_DESC)}</ns2:comment>
            </ns2:status>
        </ns2:createOrderResponse>
    </ns2:createOrderResponse>
};

local:func($Input)
