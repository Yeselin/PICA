xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://dannCarlton/schema/bookingSerive";
(:: import schema at "../Schemas/LodgingService.xsd" ::)
declare namespace ns2="http://touresbalon.com/schema/businessdomain/business";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/BusinessCanonicalModel.xsd" ::)

declare variable $Input as element() (:: schema-element(ns1:createBookingResponse) ::) external;

declare function local:func($Input as element() (:: schema-element(ns1:createBookingResponse) ::)) as element() (:: schema-element(ns2:BusinessResponse) ::) {
    <ns2:BusinessResponse>
        <ns2:BusinessResponse>
            <ns2:response>
                <ns2:status>{fn:data($Input/*:statusDescription)}</ns2:status>
                <ns2:lodgingTransactionID>{fn:data($Input/*:bookingCode)}</ns2:lodgingTransactionID>
            </ns2:response>
        </ns2:BusinessResponse>
    </ns2:BusinessResponse>
};

local:func($Input)
