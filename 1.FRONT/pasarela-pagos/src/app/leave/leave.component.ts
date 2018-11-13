import { Component, OnInit, Inject } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

import { DOCUMENT } from '@angular/common';

@Component({
  selector: 'app-leave',
  templateUrl: './leave.component.html',
  styleUrls: ['./leave.component.css']
})
export class LeaveComponent implements OnInit {

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
    this.callbackURL = decodeURIComponent(this.activatedRoute.snapshot.queryParams.callbackURL);
  }

  goBack() {
    const response = `?commerceId=${this.commerceId}&paymentCode=${this.paymentCode}&paymentStatus=${this.paymentStatus}`;
    this.document.location.href = this.callbackURL + response;
  }

}
