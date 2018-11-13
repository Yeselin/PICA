import { Component, OnInit, Inject } from '@angular/core';
import { DOCUMENT } from '@angular/common';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-success',
  templateUrl: './success.component.html',
  styleUrls: ['./success.component.css']
})
export class SuccessComponent implements OnInit {

  commerceId : string;
  paymentCode: string;
  paymentStatus: string;
  callbackURL: string;

  constructor(
    @Inject(DOCUMENT) private document: any,
    private activatedRoute: ActivatedRoute) { }

  ngOnInit() {
    this.commerceId = this.activatedRoute.snapshot.queryParams.commerceId;
    this.paymentCode = this.activatedRoute.snapshot.queryParams.paymentCode;
    this.paymentStatus = this.activatedRoute.snapshot.queryParams.paymentStatus;
    this.callbackURL = this.activatedRoute.snapshot.queryParams.callbackURL;
  }

  goBack() {
    const response = `?commerceId=${this.commerceId}&paymentCode=${this.paymentCode}&paymentStatus=${this.paymentStatus}`;
    this.document.location.href = this.callbackURL + response;
  }
}
