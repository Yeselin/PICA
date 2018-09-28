import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppComponent } from './app.component';
import { SearchComponent } from './component/search/search.component';
import { MaincontentComponent } from './component/maincontent/maincontent.component';
import { SliderComponent } from './component/slider/slider.component';
import { SlidetwoComponent } from './component/slidetwo/slidetwo.component';

import { ProductService } from './service/product.service';
import { CustomerService } from './service/customer.service';
import { OrderService } from './service/order.service';


@NgModule({
  declarations: [
    AppComponent,
    SearchComponent,
    MaincontentComponent,
    SliderComponent,
    SlidetwoComponent
  ],
  imports: [
    BrowserModule
  ],
  providers: [
    ProductService, 
    CustomerService, 
    OrderService
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
