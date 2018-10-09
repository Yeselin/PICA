xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)


(:
: Declaraciones de los parametros.
:)
(:: pragma  parameter="$transactionId" type="xs:anyType" ::)
(:: pragma  parameter="$operation" type="xs:anyType" ::)
(:: pragma  parameter="$header" type="xs:anyType" ::)
(:: pragma  parameter="$body" type="xs:anyType" ::)
(:: pragma  parameter="$fault" type="xs:anyType" ::)

(:
: Declaraciones de los namespace.
:)
declare namespace xf = "http://pps.org/ArquetcturaServices/Transformations/XQueries/ContructorLogError/";
declare namespace log = "http://pps.org/log";

(:
: Funcion.
:)
declare function xf:ContructorLogEntrada($transactionId as xs:string,
    $body as element(*),
    $header as element(*),
    $fault as element(*),
    $operation as xs:string)
    as element(*) {
   <log:logdata>
		<log:transactionId>{ $transactionId }</log:transactionId>
		<log:body>{ $body }</log:body>
		<log:header>{ $header }</log:header>
		<log:fault>{ $fault }</log:fault>
		<log:operation>{ $operation }</log:operation>
	</log:logdata>
};

(:
: Declaraciones de los parametros de entrada de la funcion.
:)
declare variable $transactionId as xs:string external;
declare variable $body as element(*) external;
declare variable $header as element(*) external;
declare variable $fault as element(*) external;
declare variable $operation as xs:string external;


(:
: Declaracion de la funcion.
:)
xf:ContructorLogEntrada($transactionId,
    $body,
    $header,
    $fault,
    $operation
    )
