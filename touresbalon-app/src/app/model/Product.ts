import { City } from "./City";
import { Spectacle } from "./Spectacle";
import { Lodging } from "./Lodging";
import { Transport } from "./Transport";


export interface Product{
    "id": number,
    "spectacleDate": Date,
    "arrivalDate": Date,
    "departureDate": Date,
    "transport": Transport,
    "spectacle": Spectacle,
    "lodging":Lodging,
    "description": string,
    "image": string,
    "sourceCity": City,
    "targetCity": City
}