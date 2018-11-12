xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://touresBalon.com/schema/orders";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/OrderCanonicalModel.xsd" ::)

declare namespace cus = "http://touresBalon.com/schema/customer";

declare namespace pro = "http://touresBalon.com/schema/products";

declare variable $InputBody as element() (:: schema-element(ns1:createOrderRequest) ::) external;
declare variable $InputResponse as element() (:: schema-element(ns1:createOrderResponse) ::) external;

declare function local:func($InputBody as element() (:: schema-element(ns1:createOrderRequest) ::), 
                            $InputResponse as element() (:: schema-element(ns1:createOrderResponse) ::)) 
                            as element() (:: schema-element(ns1:createOrderRequest) ::) {
    <ns1:createOrderRequest>
                <ns1:RequestMetadata>
                        <ns1:txId>{fn:data($InputBody/ns1:RequestMetadata/ns1:txId)}</ns1:txId>
                </ns1:RequestMetadata>
                <ns1:createOrder>
                    <ns1:customer>
                        <cus:id>{fn:data($InputBody/ns1:createOrder/ns1:customer/cus:id)}</cus:id>
                        <cus:idType>{fn:data($InputBody/ns1:createOrder/ns1:customer/cus:idType)}</cus:idType>
                    </ns1:customer>
                    <ns1:paymentMethod>
                        <ns1:paymentCode>{fn:data($InputBody/ns1:createOrder/ns1:paymentMethod/ns1:paymentCode)}</ns1:paymentCode>
                        <ns1:status>{fn:data($InputBody/ns1:createOrder/ns1:paymentMethod/ns1:status)}</ns1:status>
                    </ns1:paymentMethod>
                    <ns1:orderId>{xs:int(fn:data($InputResponse/ns1:createOrderResponse/ns1:orderId))}</ns1:orderId>
                    {
                        for $order in $InputBody/ns1:createOrder/ns1:order
                        return 
                        <ns1:order>
                            <ns1:product>
                                <pro:productId>{fn:data($order/ns1:product/pro:productId)}</pro:productId>
                            </ns1:product>
                            <ns1:quantity>{fn:data($order/ns1:quantity)}</ns1:quantity>
                        </ns1:order>
                    }
                    <ns1:orderPrice></ns1:orderPrice>
                    <ns1:orderStatus>{fn:data($InputResponse/ns1:createOrderResponse/ns1:status/ns1:status)}</ns1:orderStatus>
                    <ns1:comments>{fn:data($InputResponse/ns1:createOrderResponse/ns1:status/ns1:comment)}</ns1:comments>
                </ns1:createOrder>

    </ns1:createOrderRequest>
};

local:func($InputBody, $InputResponse)
