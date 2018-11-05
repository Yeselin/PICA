import { Injectable, Inject } from '@angular/core';
import { environment } from '../../environments/environment';
import { HttpClient, HttpHeaders } from '@angular/common/http';

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
    const headers = new HttpHeaders();
    headers.set("Content-Type", "text/plain");
    headers.set("Authorization", environment.BASIC_AUTH);
    return this.httpClient.post<any>(environment.API_CUSTOMERS, customerInfo, { headers });
  }

  /**
   * 
   * @param customerInfo 
   * @param accessToken 
   */
  updateCustomer$(customerInfo: string, accessToken: string): Observable<any> {
    const headers = new HttpHeaders();
    headers.set("Content-Type", "text/plain");
    headers.set("Authorization", environment.BASIC_AUTH);
    headers.set("x-api-key", accessToken);
    return this.httpClient.put<any>(environment.API_CUSTOMERS, customerInfo, { headers });
  }

  /**
   * 
   * @param loginRQ 
   */
  login$(loginRQ: LoginRQ): Observable<LoginRS> {
    const headers = new HttpHeaders();
    headers.set("Content-Type", "application/x-www-form-urlencoded");
    headers.set("Accept", "application/json");
    headers.set("Authorization", environment.BASIC_AUTH);
    return this.httpClient.put<LoginRS>(environment.API_CUSTOMERS + "/login", `grant_type=password&username=${loginRQ.username}&password=${loginRQ.password}`, { headers });
  }

  /**
   * 
   * @param refreshToken 
   */
  refresh$(refreshToken: string): Observable<LoginRS> {
    const headers = new HttpHeaders();
    headers.set("Content-Type", "application/x-www-form-urlencoded");
    headers.set("Accept", "application/json");
    headers.set("Authorization", environment.BASIC_AUTH);
    return this.httpClient.put<LoginRS>(environment.API_CUSTOMERS + "/login", `grant_type=refresh_token&refresh_token=${refreshToken}`, { headers });
  }
}
