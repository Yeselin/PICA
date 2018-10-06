import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule } from '@angular/common/http'
import { RouterModule, Router, Routes } from '@angular/router'
import { NgModule } from '@angular/core';
import { StorageServiceModule } from 'angular-webstorage-service';

import { AppComponent } from './app.component';

import { ProductService } from './service/product.service';
import { CustomerService } from './service/customer.service';
import { OrderService } from './service/order.service';

import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { ToastrModule } from 'ngx-toastr';

import { CardProductComponent } from './component/card-product/card-product.component';
import { ShoppingCartComponent } from './component/shopping-cart/shopping-cart.component';
import { CampaingComponent } from './component/campaing/campaing.component';
import { ListProductsComponent } from './component/list-products/list-products.component';
import { ProductDetailComponent } from './component/product-detail/product-detail.component';
import { LoginComponent } from './component/login/login.component';
import { ManagementUsersComponent } from './component/management-users/management-users.component';
import { OrdersComponent } from './component/orders/orders.component';
import { SearchBarComponent } from './component/search-bar/search-bar.component';

const appRoutes: Routes = [
  {
    path: '',
    component: CampaingComponent
  },
  {
    path: 'shopping-cart',
    component: ShoppingCartComponent
  },
  {
    path: 'list-products',
    component: ListProductsComponent
  },
  {
    path: 'product-detail',
    component: ProductDetailComponent
  },
  {
    path: 'login',
    component: LoginComponent
  },
  {
    path: 'management-users',
    component: ManagementUsersComponent
  },
  {
    path: 'orders',
    component: OrdersComponent
  }
];
@NgModule({
  declarations: [
    AppComponent,
    CardProductComponent,
    ShoppingCartComponent,
    CampaingComponent,
    ListProductsComponent,
    ProductDetailComponent,
    LoginComponent,
    ManagementUsersComponent,
    OrdersComponent,
    SearchBarComponent
  ],
  imports: [
    BrowserModule,
    HttpClientModule,
    StorageServiceModule,
    BrowserAnimationsModule,
    ToastrModule.forRoot(),
    RouterModule.forRoot(appRoutes)
  ],
  providers: [
    ProductService,
    CustomerService,
    OrderService
  ],
  bootstrap: [AppComponent, SearchBarComponent]
})
export class AppModule {
  constructor(router: Router) {
  }
}
