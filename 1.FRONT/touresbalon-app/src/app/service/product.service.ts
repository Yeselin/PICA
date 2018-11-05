import { Injectable, Inject } from '@angular/core';
import { environment } from '../../environments/environment';
import { HttpClient, HttpHeaders } from '@angular/common/http';

import { Product } from '../model/Product';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ProductService {

  constructor(private httpClient: HttpClient) { }

  /**
   * This method get campaings current campaigns
   */
  getCampaigns$(): Observable<Product[]> {
    const headers = new HttpHeaders();
    headers.set("Accept", "application/json");
    headers.set("Access-Control-Allow-Origin", "*");
    headers.set("Authorization", environment.BASIC_AUTH);
    return this.httpClient.get<Product[]>(environment.API_PRODUCTS + '/campaigns', { headers });
  }


  /**
   * 
   * @param productId This method search top five products
   */
  getTopFive$(productId: number): Observable<Product[]> {
    const headers = new HttpHeaders();
    headers.set("Accept", "application/json");
    headers.set("Authorization", environment.BASIC_AUTH);
    return this.httpClient.get<Product[]>(environment.API_PRODUCTS + '/topfive', { headers });
  }

  /**
   * This method search products with value and type
   * 
   * @param parameterType 
   * @param parameterValue 
   */
  getFindProduct$(parameterType: string, parameterValue: string): Observable<Product[]> {
    const headers = new HttpHeaders();
    headers.set("Accept", "application/json");
    headers.set("Authorization", environment.BASIC_AUTH);
    return this.httpClient.get<Product[]>(environment.API_PRODUCTS + '/find?parameterType=' + parameterType + '&parameterValue=' + parameterValue, { headers });
  }
}
