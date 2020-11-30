import { YfpComponent } from './yfp/yfp.component';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';
import {
  NgModule,
  CUSTOM_ELEMENTS_SCHEMA,
  NO_ERRORS_SCHEMA,
} from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { CommonModule, LocationStrategy, HashLocationStrategy } from '@angular/common';
import { DappHomeComponent } from './dapp-home/dapp-home.component';

@NgModule({
  declarations: [AppComponent, DappHomeComponent, YfpComponent],
  imports: [BrowserModule, AppRoutingModule, FormsModule, CommonModule],
  providers: [{ provide: LocationStrategy, useClass: HashLocationStrategy }],
  bootstrap: [AppComponent],
  schemas: [CUSTOM_ELEMENTS_SCHEMA, NO_ERRORS_SCHEMA],
})
export class AppModule { }
