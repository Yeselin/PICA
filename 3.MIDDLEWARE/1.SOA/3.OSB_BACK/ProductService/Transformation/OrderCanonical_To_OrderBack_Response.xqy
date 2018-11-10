xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://touresBalon.com/schema/products";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/ProductsCanonicalModel.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/dbGetProduct";
(:: import schema at "../Resources/dbGetProduct_sp.xsd" ::)

declare variable $Input as element() (:: schema-element(ns1:OutputParameters) ::) external;

declare function local:func($Input as element() (:: schema-element(ns1:OutputParameters) ::)) as element() (:: schema-element(ns2:getProductResponse) ::) {
    <ns2:getProductResponse>
        <ns2:product>
                <ns2:productId>{fn:data($Input/ns1:productId)}</ns2:productId>
                <ns2:productName>{fn:data($Input/ns1:PNAME)}</ns2:productName>
                <ns2:spectacleId>{fn:data($Input/ns1:SPECTACLE_TYPE)}</ns2:spectacleId>
                <ns2:transportId>{fn:data($Input/ns1:TRANSPORT_TYPE)}</ns2:transportId>
                <ns2:lodgingId>{fn:data($Input/ns1:LODGING_TYPE)}</ns2:lodgingId>
                <ns2:arrivalDate>{fn:data($Input/ns1:ARRIVAL_DATE)}</ns2:arrivalDate>
                <ns2:departureDate>{fn:data($Input/ns1:DEPARTURE_DATE)}</ns2:departureDate>
                <ns2:code>{fn:data($Input/ns1:PCODE)}</ns2:code>
                <ns2:description>{fn:data($Input/ns1:PDESCRIPT)}</ns2:description>
                <ns2:image>{fn:data($Input/ns1:PIMAGE)}</ns2:image>
                <ns2:sourceCityId>{fn:data($Input/ns1:SOURCE_CITY)}</ns2:sourceCityId>
                <ns2:targetCityId>{fn:data($Input/ns1:TARGET_CITY)}</ns2:targetCityId>
                <ns2:cost>{(fn:data($Input/ns1:COST))}</ns2:cost>
        </ns2:product>
    </ns2:getProductResponse>
};

local:func($Input)
