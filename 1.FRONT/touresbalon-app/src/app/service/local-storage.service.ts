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

  public getCampaigns(): Product[] {
    this.products = this.storage.get(environment.STORAGE_KEY_CAMPAINGS);
    if (this.products === null) {
      this.productService.getCampaigns$().subscribe((response) => {
        this.products = response;
        this.storage.set(environment.STORAGE_KEY_CAMPAINGS, this.products);
      },
        (err) => {
          console.log(err);
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
    let itemSelected = items.find(i => i.product.id === item.product.id);

    if (itemSelected) {
      itemSelected.quantity += item.quantity;
    } else {
      items.push(item);
    }
    this.storage.set(environment.SHOPPING_CART, items);
  }

  public removeItemFromShoppingCart(item: Item): void {
    let items = this.storage.get(environment.SHOPPING_CART);
    delete items['item'];
  }

  public getToken(): any{
    return this.storage.get(environment.TOKEN);
  }

  public putToken(token: any): void{
    this.storage.set(environment.TOKEN, token);
  }
}
