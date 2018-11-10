import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment';
import { HttpClient } from '@angular/common/http';

import { OrderRS, CancelOrderRS } from '../model/Order';

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
    return this.httpClient.post<OrderRS>(environment.API_ORDERS, orderRQ, {
      headers: {
        "Content-Type": "text/plain",
        "Accept": "application/json",
        "Authorization": environment.BASIC_AUTH,
        "x-api-key": accessToken
      }
    });
  }


  /**
   * 
   * @param cancelOrderRQ 
   * @param accessToken 
   */
  cancelOrder$(orderIdEncrypt: string, accessToken: string): Observable<CancelOrderRS> {
    return this.httpClient.put<CancelOrderRS>(environment.API_ORDERS, orderIdEncrypt, {
      headers: {
        "Content-Type": "text/plain",
        "Accept": "application/json",
        "Authorization": environment.BASIC_AUTH,
        "x-api-key": accessToken
      }
    });
  }


  /**
   * 
   * @param accessToken 
   */
  getOrders$(accessToken: string): Observable<string> {
    return this.httpClient.get<string>(environment.API_ORDERS, {
      headers: {
        "Accept": "application/json",
        "Authorization": environment.BASIC_AUTH,
        "x-api-key": accessToken
      }
    });
  }

}
