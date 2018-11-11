xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://americanAirlines.com/AAFlightsService";
(:: import schema at "../Schemas/AmericanAirlines.xsd" ::)
declare namespace ns2="http://touresbalon.com/schema/businessdomain/business";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/BusinessCanonicalModel.xsd" ::)

declare variable $Input as element() (:: schema-element(ns1:createBookingResponse) ::) external;

declare function local:func($Input as element() (:: schema-element(ns1:createBookingResponse) ::)) as element() (:: schema-element(ns2:BusinessResponse) ::) {
    <ns2:BusinessResponse>
        <ns2:BusinessResponse>
            <ns2:response>
                <ns2:status>{fn:data($Input/ns1:status/ns1:statusCode)}</ns2:status>
                <ns2:bookingTransactionID>{fn:data($Input/ns1:booking/ns1:bookingNumber)}</ns2:bookingTransactionID>
            </ns2:response>
        </ns2:BusinessResponse>
    </ns2:BusinessResponse>
};

local:func($Input)
