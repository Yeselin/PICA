import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppComponent } from './app.component';
import { SearchComponent } from './component/search/search.component';
import { MaincontentComponent } from './component/maincontent/maincontent.component';

@NgModule({
  declarations: [
    AppComponent,
    SearchComponent,
    MaincontentComponent
  ],
  imports: [
    BrowserModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
