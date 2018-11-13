import { Component, OnInit, Input, Inject } from '@angular/core';
import { Router } from '@angular/router';


@Component({
  selector: 'payment',
  templateUrl: './payment.component.html',
  styleUrls: ['./payment.component.css']
})
export class PaymentComponent implements OnInit { 

  public payment: any = {
    commerceId: "",
    paymentCode: "",
    amount: "",
    paymentDate: "",
    callbackURL: "",
  }

  public paymentResponse: any = {
    commerceId: "",
    paymentCode: "",
    paymentStatus: "",
    callbackURL: "",
  }

  encodedParam: string;
  decodeParam: string;

  constructor(   
    private router: Router) {
  }

  ngOnInit() {

    this.encodedParam = window.location.search.substring(1);
    const split = this.encodedParam.split("&");

    this.payment.commerceId = split[0].split("=")[1];
    this.payment.paymentCode = split[1].split("=")[1];
    this.payment.amount = split[2].split("=")[1];
    this.payment.paymentDate = split[3].split("=")[1];
    this.payment.callbackURL = split[4].split("=")[1];

    this.paymentResponse.commerceId = this.payment.commerceId;
    this.paymentResponse.paymentCode = this.payment.paymentCode;
    this.paymentResponse.callbackURL = this.payment.callbackURL;

    console.log(this.payment);

  }

  pay() {
    this.paymentResponse.paymentStatus = "SUCCESS";
    this.router.navigate(['/success'], { queryParams: this.paymentResponse });
  }

  leave() {
    this.paymentResponse.paymentStatus = "LEAVE";
    this.router.navigate(['/leave'], { queryParams: this.paymentResponse });
  }
}
