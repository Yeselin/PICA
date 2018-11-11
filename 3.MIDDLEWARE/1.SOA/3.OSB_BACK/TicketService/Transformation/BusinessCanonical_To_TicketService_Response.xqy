xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://touresbalon.com/schema/businessdomain/business";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/BusinessCanonicalModel.xsd" ::)
declare namespace ns1="http://tuBoleta/schema/ticketService";
(:: import schema at "../Schemas/xsd/Ticket.xsd" ::)

declare variable $Input as element() (:: schema-element(ns1:createTicketResponse) ::) external;

declare function local:func($Input as element() (:: schema-element(ns1:createTicketResponse) ::)) as element() (:: schema-element(ns2:BusinessResponse) ::) {
    <ns2:BusinessResponse>
        <ns2:BusinessResponse>
            <ns2:response>
                <ns2:status>{fn:data($Input/*:status)}</ns2:status>
                <ns2:bookingTransactionID>{fn:data($Input/*:transactionID)}</ns2:bookingTransactionID>
            </ns2:response>
        </ns2:BusinessResponse>
    </ns2:BusinessResponse>
};

local:func($Input)
