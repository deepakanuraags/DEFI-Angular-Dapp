import { web3Service } from './services/web3.service';
import { Component, AfterViewInit } from '@angular/core';
@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
})
export class AppComponent implements AfterViewInit{
  title = 'Dapp';
  web3: any;
  windowObj: any = window;
  web3Service: web3Service = undefined;
  shouldShowLoading:boolean = false;


  constructor(web3Service: web3Service) {
    this.web3Service = web3Service;
    
  }

  ngAfterViewInit(){
    // setTimeout(()=>{
    //   this.shouldShowLoading = false;
    // },9500);
  }


}
