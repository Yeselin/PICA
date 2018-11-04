import { Injectable, Inject } from '@angular/core';
import { environment } from '../../environments/environment';
import { HttpClient, HttpHeaders } from '@angular/common/http';

import { LoginRS } from '../model/LoginRS';
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
    const headers = new HttpHeaders().set("Content-Type", "text/plain");
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
    headers.set("Authorization", accessToken);
    return this.httpClient.put<any>(environment.API_CUSTOMERS, customerInfo, { headers });
  }

  /**
   * 
   * @param loginRQ 
   */
  login$(loginRQ: string): Observable<LoginRS> {
    const headers = new HttpHeaders();
    headers.set("Content-Type", "application/x-www-form-urlencoded");
    headers.set("Accept", "application/json");
    return this.httpClient.put<LoginRS>(environment.API_CUSTOMERS + "/login", `grant_type=password&info=${loginRQ}`, { headers });
  }

  /**
   * 
   * @param refreshToken 
   */
  refresh$(refreshToken: string): Observable<LoginRS> {
    const headers = new HttpHeaders();
    headers.set("Content-Type", "application/x-www-form-urlencoded");
    headers.set("Accept", "application/json");
    return this.httpClient.put<LoginRS>(environment.API_CUSTOMERS + "/login", `grant_type=refresh_token&refresh_token=${refreshToken}`, { headers });
  }
}
