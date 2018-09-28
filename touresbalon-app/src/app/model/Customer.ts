import { Address } from "./Address";

export interface Customer{
    "firstName": string,
    "lastName": string,
    "phoneNumer": string,
    "email": string,
    "password": string,
    "creditCardType": string,
    "creditCardNumer": string,
    "status": string,
    "address": Address
}