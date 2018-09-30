import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule} from '@angular/common/http'
import { NgModule } from '@angular/core';
import { StorageServiceModule } from 'angular-webstorage-service';

import { AppComponent } from './app.component';
import { SearchComponent } from './component/search/search.component';
import { MaincontentComponent } from './component/maincontent/maincontent.component';
import { SliderComponent } from './component/slider/slider.component';

import { ProductService } from './service/product.service';
import { CustomerService } from './service/customer.service';
import { OrderService } from './service/order.service';
import { CardProductComponent } from './component/card-product/card-product.component';


@NgModule({
  declarations: [
    AppComponent,
    SearchComponent,
    MaincontentComponent,
    SliderComponent,
    CardProductComponent
  ],
  imports: [
    BrowserModule,
    HttpClientModule,
    StorageServiceModule
  ],
  providers: [
    ProductService, 
    CustomerService, 
    OrderService
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
