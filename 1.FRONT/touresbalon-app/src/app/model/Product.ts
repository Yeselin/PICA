import { City } from "./City";
import { Spectacle } from "./Spectacle";
import { Lodging } from "./Lodging";
import { Transport } from "./Transport";


export interface Product{
    "id": number,
    "spectacle_date": Date,
    "arrival_date": Date,
    "departure_date": Date,
    "transport_name": string,
    "transport_cost": string,
    "spectacle_name": string,
    "spectacle_cost": string,
    "lodging_name": string,
    "lodging_cost": string,
    "name": string,
    "description": string,
    "image_ref": string,
    "source_city_name": string,
    "source_country_name": string,
    "source_city_cost": string,
    "target_city_name": string,
    "target_country_name": string,
    "target_city_cost": string
}