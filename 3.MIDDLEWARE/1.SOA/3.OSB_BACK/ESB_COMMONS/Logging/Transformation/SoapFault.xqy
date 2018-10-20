xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

(:
: Declaraciones de los parametros.
:)
(:: pragma  parameter="$Body" type="xs:anyType" ::)
(:: pragma  parameter="$Fault" type="xs:anyType" ::)
(:: pragma  type="xs:anyType" ::)

(:
: Declaraciones de los namespace.
:)
declare namespace xf = "http://www.pacifico.com.pe/ServiciosArquitetura/Trasformations/XQueries/SoapFault/";
declare namespace con = "http://www.bea.com/wli/sb/context";
declare namespace soapenv = "http://www.w3.org/2003/05/soap-envelope";
declare namespace excp = "http://www.pacifico.com.pe/ExceptionData";

(:
: Funcion.
:)
declare function xf:Fault($Body as element(*),
    $Fault as element(*))
    as element(*) {
	<soapenv:Fault>
	<soapenv:Code>
	{	
		if (empty($Body/soapenv:Fault/soapenv:Code/soapenv:Value)) then 
			<soapenv:Value>{$Fault/con:errorCode/text()}</soapenv:Value>
		else
			<soapenv:Value>{$Body/soapenv:Fault/soapenv:Code/soapenv:Value/text()}</soapenv:Value>	
	}
	</soapenv:Code>
	<soapenv:Reason>
	{
		if (empty($Body/soapenv:Fault/soapenv:Reason/soapenv:Text)) then 
			<soapenv:Text>Error de Aplicación</soapenv:Text>
		else
			<soapenv:Text>Error de Aplicación</soapenv:Text>
	}
	</soapenv:Reason>
	
		<soapenv:Detail>
			<osbfault>Error de Aplicación</osbfault>
		</soapenv:Detail>
	</soapenv:Fault>
};

(:
: Declaraciones de los parametros de entrada de la funcion.
:)
declare variable $Body as element(*) external;
declare variable $Fault as element(*) external;

(:
: Declaracion de la funcion.
:)
xf:Fault($Body,$Fault)