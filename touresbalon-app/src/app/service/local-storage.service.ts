import { Injectable, Inject } from '@angular/core';
import { environment } from '../../environments/environment';
import { StorageService, LOCAL_STORAGE } from 'angular-webstorage-service';

import { ProductService } from './product.service';
import { Product } from '../model/Product';
import { Item } from '../model/Item';

@Injectable({
  providedIn: 'root'
})
export class LocalStorageService {

  constructor(@Inject(ProductService) private productService: ProductService, @Inject(LOCAL_STORAGE) private storage: StorageService) { }

  private products: Product[];

  public getLocalSlide(): Product[] {
    this.products = this.storage.get(environment.STORAGE_KEY_SLIDER);
    if (this.products === null) {
      this.productService.getSlider$().subscribe((response) => {
        this.products = response;
        this.storage.set(environment.STORAGE_KEY_SLIDER, this.products);
      },
        (error) => {
          console.error(error);
        })
    }
    return this.products;
  }

  public getShoppingCart(): Item[] {
    let items = this.storage.get(environment.SHOPPING_CART);
    return items;
  }

  public putShoppingCart(item: Item): void {
    let items = this.storage.get(environment.SHOPPING_CART) || [];
    items.push(item);
    this.storage.set(environment.SHOPPING_CART, items);
  }

  public removeItemFromShoppingCart(item: Item): void {
    let items = this.storage.get(environment.SHOPPING_CART);
    delete items['item'];
  }
}
