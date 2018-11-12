import { Component, OnInit, Inject } from '@angular/core';
import { LocalStorageService } from '../../service/local-storage.service';
import { Item } from '../../model/Item';
import { environment } from '../../../environments/environment';


import { DOCUMENT } from '@angular/common';

@Component({
  selector: 'shopping-cart',
  templateUrl: './shopping-cart.component.html',
  styleUrls: ['./shopping-cart.component.css']
})
export class ShoppingCartComponent implements OnInit {

  public items: Item[];

  total: number = 0;

  private commerceId = "9f6c4aca-8d98-40d0-976e-a50cd94de064";

  constructor(
    @Inject(LocalStorageService) private storage: LocalStorageService,
    @Inject(DOCUMENT) private document: any) { }

  ngOnInit() {
    this.items = this.storage.getShoppingCart();
  }

  getImageRef(image_ref: string): string {
    return environment.BASE_IMAGE + "400x200/" + image_ref;
  }

  getTotal() {
    this.total = 0;
    this.items.forEach((item) => {
      this.total += item.quantity * item.product.cost_total
    });
    return this.total;
  }

  goToPay() {
    const paymentCode = Math.floor(Math.random() * (1000000 - 1 + 1)) + 1;
    const date = new Date();
    const paymentDate = `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()} ${date.getHours()}:${date.getMinutes()}`
    const params = `commerId=${this.commerceId}&paymentCode=${paymentCode}&amount=${this.total}&paymentDate=${paymentDate}`
    const URL_PAYMENT_GATEWAY = environment.PAYMENT_GATEWAT + "?params=" + btoa(params);
    this.document.location.href = URL_PAYMENT_GATEWAY;
  }
  
}
