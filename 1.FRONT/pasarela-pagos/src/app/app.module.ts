import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { AppComponent } from './app.component';
import { SuccessComponent } from './success/success.component';
import { LeaveComponent } from './leave/leave.component';
import { PaymentComponent } from './payment/payment.component';

@NgModule({
  declarations: [
    AppComponent,
    SuccessComponent,
    LeaveComponent,
    PaymentComponent
  ],
  imports: [
    BrowserModule,
    RouterModule.forRoot([
      {
        path: '',
        component: PaymentComponent
      },
      {
        path: 'payment',
        component: PaymentComponent
      },
      {
        path: 'success',
        component: SuccessComponent
      },
      {
        path: 'leave',
        component: LeaveComponent
      },
    ])
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
