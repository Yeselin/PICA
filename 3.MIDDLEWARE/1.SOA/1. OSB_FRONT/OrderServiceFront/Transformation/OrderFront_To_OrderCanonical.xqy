xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://touresBalon.com/schema/orders";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/OrderCanonicalModel.xsd" ::)
declare namespace ns1="http://touresBalon.com/schema/ordersFront";
(:: import schema at "../Resources/xsd/OrderFront.xsd" ::)

declare namespace cus = "http://touresBalon.com/schema/customer";

declare namespace pro = "http://touresBalon.com/schema/products";

declare variable $Input as element() (:: schema-element(ns1:createOrderRequest) ::) external;

declare function local:func($Input as element() (:: schema-element(ns1:createOrderRequest) ::)) as element() (:: schema-element(ns2:createOrderRequest) ::) {
    <ns2:createOrderRequest>
        <ns2:RequestMetadata>
            <ns2:txId></ns2:txId>
        </ns2:RequestMetadata>
        <ns2:createOrder>
<ns2:customer>
            <cus:id>{fn:data($Input/ns1:customerInfo/ns1:document)}</cus:id>
            <cus:idType>{fn:data($Input/ns1:customerInfo/ns1:documentType)}</cus:idType>
        </ns2:customer>
        <ns2:paymentMethod>
            <ns2:paymentCode>{fn:data($Input/ns1:paymentInfo/ns1:paymentCode)}</ns2:paymentCode>
            <ns2:status>{fn:data($Input/ns1:paymentInfo/ns1:status)}</ns2:status>
        </ns2:paymentMethod>
        {
            for $products in $Input/ns1:products
            return 
            <ns2:order>
                <ns2:product>
                    <pro:productId>{fn:data($products/ns1:product)}</pro:productId>
                </ns2:product>
                <ns2:quantity>{fn:data($products/ns1:quantity)}</ns2:quantity></ns2:order>
        }
        <ns2:orderStatus>{fn:data("EN VALIDACION")}</ns2:orderStatus>
        <ns2:comments>{fn:data("ORDEN EN PROCESO DE APROVISIONAMIENTO")}</ns2:comments>
        </ns2:createOrder>
    </ns2:createOrderRequest>
};

local:func($Input)
