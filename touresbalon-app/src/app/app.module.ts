import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule } from '@angular/common/http'
import { RouterModule } from '@angular/router'
import { NgModule } from '@angular/core';
import { StorageServiceModule } from 'angular-webstorage-service';

import { AppComponent } from './app.component';
import { SliderComponent } from './component/slider/slider.component';

import { ProductService } from './service/product.service';
import { CustomerService } from './service/customer.service';
import { OrderService } from './service/order.service';
import { CardProductComponent } from './component/card-product/card-product.component';
import { ResultListComponent } from './component/result-list/result-list.component';


@NgModule({
  declarations: [
    AppComponent,
    SliderComponent,
    CardProductComponent,
    ResultListComponent
  ],
  imports: [
    BrowserModule,
    HttpClientModule,
    StorageServiceModule,
    RouterModule.forRoot([
      {
        path: '',
        component: SliderComponent
      }
    ])
  ],
  providers: [
    ProductService,
    CustomerService,
    OrderService
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
