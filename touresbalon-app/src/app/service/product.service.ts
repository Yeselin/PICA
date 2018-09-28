import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment';
import {HttpClient} from '@angular/common/http';
import { Product } from '../model/Product';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ProductService {

  constructor(private httpClient: HttpClient) { }

  getSlider$() : Observable<Product[]> {
    return this.httpClient.get<Product[]>(environment.API_PRODUCTS + '/slider');
  }

  getSlideTwo$() : Observable<Product[]> {
    return this.httpClient.get<Product[]>(environment.API_PRODUCTS + '/sliderTwo');
  }

  /**
   * 
   * @param productId This method search top five products
   */
  getTopFive$(productId: number): Observable<Product[]> {
    return this.httpClient.get<Product[]>(environment.API_PRODUCTS + '/topfive');
  }

  /**
   * This method search products with value and type
   * @param findBy 
   * @param value 
   */
  getFindProduct$(findBy: string, value: string): Observable<Product[]> {
    return this.httpClient.get<Product[]>(environment.API_PRODUCTS + '/find?by=' + findBy + '&value=' + value);
  }
}
