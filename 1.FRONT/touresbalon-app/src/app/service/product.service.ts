import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment';
import { HttpClient } from '@angular/common/http';

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
    return this.httpClient.get<Product[]>(environment.API_PRODUCTS + '/campaigns',
      {
        headers: {
          "Accept": "application/json",
          "Authorization": environment.BASIC_AUTH
        }
      });
  }


  /**
   * 
   * @param productId This method search top five products
   */
  getTopFive$(productId: number): Observable<Product[]> {
    return this.httpClient.get<Product[]>(environment.API_PRODUCTS + '/topfive', {
      headers: {
        "Accept": "application/json",
        "Authorization": environment.BASIC_AUTH
      }
    });
  }

  /**
   * This method search products with value and type
   * 
   * @param parameterType 
   * @param parameterValue 
   */
  getFindProduct$(parameterType: string, parameterValue: string): Observable<Product[]> {
    return this.httpClient.get<Product[]>(environment.API_PRODUCTS + '/find?parameterType=' + parameterType + '&parameterValue=' + parameterValue, {
      headers: {
        "Accept": "application/json",
        "Authorization": environment.BASIC_AUTH
      }
    });
  }
}
