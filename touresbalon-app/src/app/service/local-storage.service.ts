import { Injectable, Inject } from '@angular/core';
import { environment } from '../../environments/environment';
import { StorageService, LOCAL_STORAGE } from 'angular-webstorage-service';

import { ProductService } from './product.service';
import { Product } from '../model/Product';

@Injectable({
  providedIn: 'root'
})
export class LocalStorageService {

  constructor(@Inject(ProductService) private productService: ProductService, @Inject(LOCAL_STORAGE) private storage: StorageService) { }
  
  private products : Product[];

  public getLocalSlide() : Product[]{
    this.products = this.storage.get(environment.STORAGE_KEY_SLIDER);
    if(this.products === null){
      this.productService.getSlider$().subscribe((response)=> {
        this.products = response;       
        this.storage.set(environment.STORAGE_KEY_SLIDER, this.products);  
       },
       (error) => {
         console.error(error);
       })
    }
    return this.products;
  }
}
