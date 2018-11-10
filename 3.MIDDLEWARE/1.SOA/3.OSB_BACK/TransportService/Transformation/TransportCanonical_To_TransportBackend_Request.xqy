xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://avianca.com/ServicioWebAvianca";
(:: import schema at "../Schemas/AviancaOperations.xsd" ::)
declare namespace ns1="http://touresbalon.com/schema/businessdomain/business";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/BusinessCanonicalModel.xsd" ::)

declare variable $Input as element() (:: schema-element(ns1:BusinessRequest) ::) external;

declare function local:func($Input as element() (:: schema-element(ns1:BusinessRequest) ::)) as element() (:: schema-element(ns2:createBookingRequest) ::) {
    <ns2:createBookingRequest>
        <ns2:customer>
            <ns2:name></ns2:name>
            <ns2:lastName></ns2:lastName>
            <ns2:id></ns2:id>
            <ns2:idType></ns2:idType>
        </ns2:customer>
        <ns2:booking>
            <ns2:fromCity>{fn:data($Input/ns1:transport/ns1:fromCity)}</ns2:fromCity>
            <ns2:toCity>{fn:data($Input/ns1:transport/ns1:toCity)}</ns2:toCity>
            <ns2:flightDate>{fn:data($Input/ns1:transport/ns1:travelDate)}</ns2:flightDate>
            <ns2:numberOfTicekts>{fn:data($Input/ns1:transport/ns1:numberOfTickets)}</ns2:numberOfTicekts>
            <ns2:cabinClass>{fn:data($Input/ns1:transport/ns1:category)}</ns2:cabinClass>
        </ns2:booking>
    </ns2:createBookingRequest>
};

local:func($Input)
