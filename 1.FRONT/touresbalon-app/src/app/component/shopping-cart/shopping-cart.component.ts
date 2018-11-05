import { Component, OnInit, Inject } from '@angular/core';
import { LocalStorageService } from '../../service/local-storage.service';
import { Item } from '../../model/Item';
import { environment } from '../../../environments/environment';

@Component({
  selector: 'shopping-cart',
  templateUrl: './shopping-cart.component.html',
  styleUrls: ['./shopping-cart.component.css']
})
export class ShoppingCartComponent implements OnInit {

  public items: Item[];

  total : number = 0;

  constructor(@Inject(LocalStorageService) private storage: LocalStorageService) { }

  ngOnInit() {
    this.items = this.storage.getShoppingCart();
  }
  
  getImageRef(image_ref: string): string {
    return environment.BASE_IMAGE  + "400x200/" +image_ref;
  }

  getTotal(){
    this.total = 0;
    this.items.forEach( (item) => {
      this.total += item.quantity * item.product.cost_total
    });    
    return this.total;
  }
}
