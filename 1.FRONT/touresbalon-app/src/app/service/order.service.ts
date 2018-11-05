import { Injectable, Inject } from '@angular/core';
import { environment } from '../../environments/environment';
import { HttpClient, HttpHeaders } from '@angular/common/http';

import { OrderRQ, OrderRS, Order, CancelOrderRQ, CancelOrderRS } from '../model/Order';

import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class OrderService {

  constructor(private httpClient: HttpClient) { }


  /**
   * 
   * @param orderRQ 
   * @param accessToken 
   */
  createOrder$(orderRQ: string, accessToken: string): Observable<OrderRS> {
    const headers = new HttpHeaders();
    headers.set("Content-Type", "text/plain");
    headers.set("Authorization", environment.BASIC_AUTH);
    headers.set("x-api-key", accessToken);
    return this.httpClient.post<OrderRS>(environment.API_ORDERS, orderRQ, { headers });
  }


  /**
   * 
   * @param cancelOrderRQ 
   * @param accessToken 
   */
  cancelOrder$(orderIdEncrypt: string, accessToken: string): Observable<CancelOrderRS> {
    const headers = new HttpHeaders();
    headers.set("Content-Type", "text/plain");
    headers.set("Authorization", environment.BASIC_AUTH);
    headers.set("x-api-key", accessToken);
    return this.httpClient.put<CancelOrderRS>(environment.API_ORDERS, orderIdEncrypt, { headers });
  }


  /**
   * 
   * @param accessToken 
   */
  getOrders$(accessToken: string): Observable<string> {
    const headers = new HttpHeaders();
    headers.set("Accept", "application/json;  text/plain");
    headers.set("Authorization", environment.BASIC_AUTH);
    headers.set("x-api-key", accessToken);
    return this.httpClient.get<string>(environment.API_ORDERS);
  }

}
