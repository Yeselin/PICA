xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://touresbalon.com/schema/businessdomain/business";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/BusinessCanonicalModel.xsd" ::)
declare namespace ns2="http://tuBoleta/schema/ticketService";
(:: import schema at "../Schemas/xsd/Ticket.xsd" ::)

declare variable $Input as element() (:: schema-element(ns1:BusinessRequest) ::) external;

declare function local:func($Input as element() (:: schema-element(ns1:BusinessRequest) ::)) as element() (:: schema-element(ns2:createTicketRequest) ::) {
    <ns2:createTicketRequest>
        <ns2:clientID>{fn:data($Input/ns1:BusinessRequest/ns1:ticketBooking/ns1:clientID)}</ns2:clientID>
        <ns2:eventId>{fn:data($Input/ns1:BusinessRequest/ns1:ticketBooking/ns1:eventId)}</ns2:eventId>
        <ns2:totalTickets>{xs:int(fn:data($Input/ns1:BusinessRequest/ns1:ticketBooking/ns1:totalTickets))}</ns2:totalTickets>
        <ns2:category>{fn:data($Input/ns1:BusinessRequest/ns1:ticketBooking/ns1:category)}</ns2:category>
    </ns2:createTicketRequest>
};

local:func($Input)
