import { hostname } from "os";

// This file can be replaced during build by using the `fileReplacements` array.
// `ng build --prod` replaces `environment.ts` with `environment.prod.ts`.
// The list of file replacements can be found in `angular.json`.

export const environment = {
  production: false,
  API_PRODUCTS: 'http://127.0.0.1:8081/api/products',
  API_ORDERS: 'http://127.0.0.1:8082/api/orders',
  API_CUSTOMERS: 'http://127.0.0.1:8083/api/customers',

  STORAGE_KEY_CAMPAINGS:'campaings',
  SHOPPING_CART:'shopping_cart',

  BASIC_AUTH : 'Basic dG91cmVzYmFsb246dG91cmVzYmFsb24xMjM=',
  PUBLIC_KEY: 'ETfl8BigpmxVie8wgB4fAo8zHCcHR3M2AJNux+6N8Rk=',

  BASE_IMAGE: 'http://127.0.0.1:8888/'
};

/*
 * For easier debugging in development mode, you can import the following file
 * to ignore zone related error stack frames such as `zone.run`, `zoneDelegate.invokeTask`.
 *
 * This import should be commented out in production mode because it will have a negative impact
 * on performance if an error is thrown.
 */
// import 'zone.js/dist/zone-error';  // Included with Angular CLI.
