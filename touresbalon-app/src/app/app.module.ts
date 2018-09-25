import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppComponent } from './app.component';
import { SearchComponent } from './search/search.component';
import { CartComponent } from './cart/cart.component';
import { ProductComponent } from './product/product.component';
import { UserComponent } from './user/user.component';
import { ResultListComponent } from './result-list/result-list.component';

@NgModule({
  declarations: [
    AppComponent,
    SearchComponent,
    CartComponent,
    ProductComponent,
    UserComponent,
    ResultListComponent
  ],
  imports: [
    BrowserModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
