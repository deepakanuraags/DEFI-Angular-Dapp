import { YfpComponent } from './yfp/yfp.component';
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { DappHomeComponent } from './dapp-home/dapp-home.component';

const routes: Routes = [
  { path: 'home', component: DappHomeComponent },
  { path: 'yup', pathMatch: 'full', component: YfpComponent },
  { path: 'tup', pathMatch: 'full', component: YfpComponent },
  { path: 'ybp', pathMatch: 'full', component: YfpComponent },
  { path: 'tfp', pathMatch: 'full', component: YfpComponent },
  { path: 'yfp', pathMatch: 'full', component: YfpComponent },
  { path: '', redirectTo: '/home', pathMatch: 'full' },
  { path: '**', redirectTo: '/home', pathMatch: 'full' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes, { onSameUrlNavigation: 'reload' })],
  exports: [RouterModule],
})
export class AppRoutingModule { }
