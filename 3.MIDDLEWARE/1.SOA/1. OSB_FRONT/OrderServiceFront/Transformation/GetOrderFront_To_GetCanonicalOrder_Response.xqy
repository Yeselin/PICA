xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://touresBalon.com/schema/orders";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/OrderCanonicalModel.xsd" ::)
declare namespace ns2="http://touresBalon.com/schema/ordersFront";
(:: import schema at "../Resources/xsd/OrderFront.xsd" ::)

declare namespace pro = "http://touresBalon.com/schema/products";

declare variable $Input as element() (:: schema-element(ns1:getOrderResponse) ::) external;

declare function local:func($Input as element() (:: schema-element(ns1:getOrderResponse) ::)) as element() (:: schema-element(ns2:getOrderResponse) ::) {
    <ns2:getOrderResponse>
        {
            for $order in $Input/ns1:order
            return 
            <ns2:orders>
                <ns2:orderId>{xs:string(fn:data($order/ns1:orderId))}</ns2:orderId>
                <ns2:orderDate></ns2:orderDate>
                <ns2:totalPrice>{fn:data($order/ns1:orderPrice)}</ns2:totalPrice>
                <ns2:status>{fn:data($order/ns1:orderStatus)}</ns2:status>
                <ns2:comment>{fn:data($order/ns1:comments)}</ns2:comment>
                {
                    for $product in $order/ns1:product
                    return 
                    <ns2:products>
                        
                        <ns2:product>
                            <ns2:productId>{fn:data($product/ns1:product/pro:productId)}</ns2:productId>
                            <ns2:productName>{fn:data($product/ns1:product/pro:productName)}</ns2:productName>
                            <ns2:price>{fn:data($product/ns1:product/pro:cost)}</ns2:price>
                            <ns2:quantity>{fn:data($product/ns1:quantity)}</ns2:quantity>
                            <ns2:image_ref>{fn:data('')}</ns2:image_ref>
                        </ns2:product>
</ns2:products>                        
                }</ns2:orders>
        }
    </ns2:getOrderResponse>
};

local:func($Input)
