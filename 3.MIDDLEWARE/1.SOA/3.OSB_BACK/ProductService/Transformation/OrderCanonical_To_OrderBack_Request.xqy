xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://touresBalon.com/schema/products";
(:: import schema at "../../ESB_COMMONS/Resources/Schemas/xsd/ProductsCanonicalModel.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/dbGetProduct";
(:: import schema at "../Resources/dbGetProduct_sp.xsd" ::)

declare variable $Input as element() (:: schema-element(ns1:getProductRequest) ::) external;

declare function local:func($Input as element() (:: schema-element(ns1:getProductRequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
      <ns2:ID>{fn:data($Input/ns1:product/ns1:productId)}</ns2:ID>
    </ns2:InputParameters>
};

local:func($Input)
