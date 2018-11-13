import { Component, OnInit, Inject } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';

import { OrderService } from '../../service/order.service';

import { LocalStorageService } from '../../service/local-storage.service';
import { Item } from '../../model/Item';
import { environment } from '../../../environments/environment';
import { ToastrService } from 'ngx-toastr';

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

  jwt: any;

  constructor(
    private activatedRoute: ActivatedRoute,
    private toastrService: ToastrService,
    private router: Router,
    @Inject(OrderService) private orderService: OrderService,
    @Inject(LocalStorageService) private storage: LocalStorageService,
    @Inject(DOCUMENT) private document: any) { }

  ngOnInit() {
    this.jwt = null;
    this.jwt = this.storage.getToken();
    this.items = this.storage.getShoppingCart();
    const commerceId = this.activatedRoute.snapshot.queryParams.commerceId;
    const paymentCode = this.activatedRoute.snapshot.queryParams.paymentCode;
    const paymentStatus = this.activatedRoute.snapshot.queryParams.paymentStatus;   
    if (this.jwt && commerceId && commerceId) {
      this.saveOrder(paymentCode, paymentStatus);
    }
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
    //Si no ha hecho login
    if (!this.jwt) {
      this.router.navigate(['/login']);
    } else {
      const paymentCode = Math.floor(Math.random() * (1000000 - 1 + 1)) + 1;
      const date = new Date();
      const paymentDate = `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}T${date.getHours()}:${date.getMinutes()}`
      const params = `touresbalon-${this.commerceId}&paymentCode=${paymentCode}&amount=${this.total}&paymentDate=${paymentDate}&callback=${encodeURIComponent(environment.CALLBACK_PAYMENT)}`
      const URL_PAYMENT_GATEWAY = environment.PAYMENT_GATEWAT + "?params=" + params;
      this.document.location.href = URL_PAYMENT_GATEWAY;
    }
  }

  saveOrder(paymentCode: string, paymentStatus: string) {
   // console.log(this.jwt.access_token);
   // const decodeToken = atob(this.jwt.access_token);
   // const customerId = JSON.parse(decodeToken).customerId;
   // const document = customerId.split("-");

    let orderRQ = {
      paymentInfo: {
        paymentCode: paymentCode,
        status: paymentStatus === "SUCCESS" ? 1 : 0
      },
      customerInfo: {
        documentType: "CC",
        document: 23094857
      },
      products: []
    }

    this.items.forEach((item) => {
      orderRQ.products.push({
        "id": item.product.id.toString(),
        "quantity": item.quantity
      })
    });
    console.log("antes de llamar al servicio");
    this.orderService.createOrder$(JSON.stringify(orderRQ), this.jwt.access_token).subscribe((response) => {
      this.toastrService.info("Orden creada con éxito", "Hurra!");
    }, (error) => {
      console.log(JSON.stringify(error));
      this.toastrService.error('No se pudo crear la orden', 'Ups!');
    });
  }

}
