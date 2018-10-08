import { hostname } from "os";

// This file can be replaced during build by using the `fileReplacements` array.
// `ng build --prod` replaces `environment.ts` with `environment.prod.ts`.
// The list of file replacements can be found in `angular.json`.

export const environment = {
  production: false,
  API_PRODUCTS: 'http://127.0.0.1:8080/api/products',
  API_ORDERS: 'http://127.0.0.1:8080/api/orders',
  API_CUSTOMERS: 'http://127.0.0.1:8080/api/customers',

  STORAGE_KEY_CAMPAINGS:'campaings',
  SHOPPING_CART:'shopping_cart'
};

/*
 * For easier debugging in development mode, you can import the following file
 * to ignore zone related error stack frames such as `zone.run`, `zoneDelegate.invokeTask`.
 *
 * This import should be commented out in production mode because it will have a negative impact
 * on performance if an error is thrown.
 */
// import 'zone.js/dist/zone-error';  // Included with Angular CLI.
