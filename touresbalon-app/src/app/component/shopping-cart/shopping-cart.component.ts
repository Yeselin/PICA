import { Component, OnInit, Inject } from '@angular/core';
import { LocalStorageService } from '../../service/local-storage.service';
import { Item } from '../../model/Item';

@Component({
  selector: 'shopping-cart',
  templateUrl: './shopping-cart.component.html',
  styleUrls: ['./shopping-cart.component.css']
})
export class ShoppingCartComponent implements OnInit {

  public items: Item[];

  constructor(@Inject(LocalStorageService) private storage: LocalStorageService) { }

  ngOnInit() {
    this.items = this.storage.getShoppingCart();
  }

}
