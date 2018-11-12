import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { HomeComponent } from './component/home/home.component';
import { ShoppingCartComponent } from './component/shopping-cart/shopping-cart.component';
import { CampaingComponent } from './component/campaing/campaing.component';
import { ListProductsComponent } from './component/list-products/list-products.component';
import { ProductDetailComponent } from './component/product-detail/product-detail.component';
import { LoginComponent } from './component/login/login.component';
import { ManagementUsersComponent } from './component/management-users/management-users.component';
import { OrdersComponent } from './component/orders/orders.component';
import { CardProductComponent } from './component/card-product/card-product.component';
import { SearchBarComponent } from './component/search-bar/search-bar.component';
import { RegisterComponent } from './component/register/register.component';
import { SuccessComponent } from './component/success/success.component';

const routes: Routes = [
  {
    path: '',
    component: HomeComponent
  },
  {
    path: 'home',
    component: HomeComponent
  },
  {
    path: 'compaings',
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
    path: 'register',
    component: RegisterComponent
  },
  {
    path: 'management-users',
    component: ManagementUsersComponent
  },
  {
    path: 'orders',
    component: OrdersComponent
  },
  {
    path: 'success',
    component: SuccessComponent
  }
];
@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }

export const routingComponent = [
  ShoppingCartComponent,
  CampaingComponent,
  ListProductsComponent,
  ProductDetailComponent,
  LoginComponent,
  ManagementUsersComponent,
  OrdersComponent,
  CardProductComponent,
  SearchBarComponent,
  HomeComponent,
  RegisterComponent,
  SuccessComponent
];