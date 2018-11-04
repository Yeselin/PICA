
export interface Customer {
    documentType: string,
    document: string,
    firstName: string,
    lastName: string,
    phoneNumber: string,
    email: string,
    password: string,
    address: {
        country: string,
        city: string,
        state: string,
        street: string,
        zip: string,
        addressType: string
    }
}
