xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://dannCarlton/schema/bookingSerive";
(:: import schema at "../Schemas/LodgingService.xsd" ::)
declare namespace ns1="http://touresbalon.com/schema/businessdomain/business";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/BusinessCanonicalModel.xsd" ::)

declare variable $Input as element() (:: schema-element(ns1:BusinessRequest) ::) external;

declare function local:func($Input as element() (:: schema-element(ns1:BusinessRequest) ::)) as element() (:: schema-element(ns2:createBookingRequest) ::) {
    <ns2:createBookingRequest>
        <ns2:bookingDate>{fn:data($Input/ns1:BusinessRequest/ns1:hotelBooking/ns1:bookingDate)}</ns2:bookingDate>
        <ns2:numberOfRooms>{xs:int(fn:data($Input/ns1:BusinessRequest/ns1:hotelBooking/ns1:numberOfRooms))}</ns2:numberOfRooms>
        <ns2:numberOfPeople>{fn:data($Input/ns1:BusinessRequest/ns1:hotelBooking/ns1:numberOfPeople)}</ns2:numberOfPeople>
    </ns2:createBookingRequest>
};

local:func($Input)
