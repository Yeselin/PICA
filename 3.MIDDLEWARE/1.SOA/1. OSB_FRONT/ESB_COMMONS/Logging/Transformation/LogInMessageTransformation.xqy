xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)


(:
: Declaraciones de los parametros.
:)
(:: pragma  parameter="$transactionId" type="xs:anyType" ::)
(:: pragma  parameter="$operation" type="xs:anyType" ::)
(:: pragma  parameter="$header" type="xs:anyType" ::)
(:: pragma  parameter="$body" type="xs:anyType" ::)
(:: pragma  parameter="$attachment" type="xs:anyType" ::)
(:: pragma  parameter="$inboud" type="xs:anyType" ::)
(:: pragma  parameter="$logSite" type="xs:anyType" ::)

(:
: Declaraciones de los namespace.
:)
declare namespace xf = "http://pps.org/ArquetcturaServices/Transformations/XQueries/ContructorLogError/";
declare namespace log = "http://pps.org/log";

(:
: Funcion.
:)
declare function xf:ContructorLogEntrada($transactionId as xs:string,
    $body as xs:string,
    $header as xs:string,
    $inbound as xs:string,
    $operation as xs:string,
    $attachment as xs:string,
    $logSite as xs:string)
    as element(*) {
   <log:logdata>
		<log:transactionId>{ $transactionId }</log:transactionId>
		<log:body>{ $body }</log:body>
		<log:header>{ $header }</log:header>
		<log:inbound>{ $inbound }</log:inbound>
		<log:operation>{ $operation }</log:operation>
		<log:attachment>{ $attachment }</log:attachment>
                <log:logSite>{ $logSite }</log:logSite>
	</log:logdata>
};

(:
: Declaraciones de los parametros de entrada de la funcion.
:)
declare variable $transactionId as xs:string external;
declare variable $body as xs:string external;
declare variable $header as xs:string external;
declare variable $inbound as xs:string external;
declare variable $operation as xs:string external;
declare variable $attachment as xs:string external;
declare variable $logSite as xs:string external;

(:
: Declaracion de la funcion.
:)
xf:ContructorLogEntrada($transactionId,
    $body,
    $header,
    $inbound,
    $operation,
    $attachment,
    $logSite)
