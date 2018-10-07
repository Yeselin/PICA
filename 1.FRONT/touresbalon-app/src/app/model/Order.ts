import { OrderItem } from "./OrderItem";

export interface Order{
    "comments": string,
    "custDocNumber": string,
    "custDocType": string,
    "items":  OrderItem[]
}