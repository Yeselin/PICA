import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment';
import { HttpClient } from '@angular/common/http';

import { LoginRS, LoginRQ } from '../model/Login';
import { Observable } from 'rxjs';


@Injectable({
  providedIn: 'root'
})
export class CustomerService {

  constructor(private httpClient: HttpClient) { }

  /**
   * This method get campaings current campaigns
   */
  createCustomer$(customerInfo: string): Observable<any> {
    return this.httpClient.post<any>(environment.API_CUSTOMERS, customerInfo, {
      headers: {
        "Content-Type": "text/plain",
        "Authorization": environment.BASIC_AUTH
      }
    });
  }

  /**
   * 
   * @param customerInfo 
   * @param accessToken 
   */
  updateCustomer$(customerInfo: string, accessToken: string): Observable<any> {
    return this.httpClient.put<any>(environment.API_CUSTOMERS, customerInfo, {
      headers: {
        "Content-Type": "text/plain",
        "Authorization": environment.BASIC_AUTH,
        "x-api-key": accessToken
      }
    });
  }

  /**
   * 
   * @param loginRQ 
   */
  login$(loginRQ: LoginRQ): Observable<LoginRS> {
    return this.httpClient.post<LoginRS>(environment.API_CUSTOMERS + "/login",
      "grant_type=password&username=" + loginRQ.username + "&password=" + loginRQ.password,
      {
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Accept": "application/json",
          "Authorization": environment.BASIC_AUTH
        }
      });
  }

  /**
   * 
   * @param refreshToken 
   */
  refresh$(refreshToken: string): Observable<LoginRS> {
    return this.httpClient.put<LoginRS>(environment.API_CUSTOMERS + "/login", `grant_type=refresh_token&refresh_token=${refreshToken}`,
      {
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Accept": "application/json",
          "Authorization": environment.BASIC_AUTH
        }
      });
  }
}
