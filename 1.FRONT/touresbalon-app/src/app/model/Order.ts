
export interface OrderRQ {
    paymentInfo: PaymentInfo,
    customerInfo: CustomerInfo,
    products: Item[]
}

export interface OrderRS {
    orderId: string,
    orderDate: string,
    status: string,
    comments: string
}

export interface Order {
    orderId: string,
    orderDate: string,
    totalPrice: number,
    status: string,
    comments: string,
    products: Product[]
}

export interface CancelOrderRQ{
    orderId: string
}

export interface CancelOrderRS{
    orderId: string,
    status: string
}

interface Product {
    productId: number,
    productName: string,
    price: number,
    quantity: number,
    image_ref: string
}
interface PaymentInfo {
    paymentCode: string,
    status: string
}

interface CustomerInfo {
    documentType: string,
    document: string
}

interface Item {
    id: string,
    quantity: number;
}