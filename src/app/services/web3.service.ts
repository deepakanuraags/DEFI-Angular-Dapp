import Web3 from 'web3';
import { Injectable } from '@angular/core';
@Injectable({
  providedIn: 'root',
})
export class web3Service {
  public web3: any;
  public windowObj: any = window;
  public userAccountAddr: string = '';
  public networkId: string = '';
  public web3Enabled: boolean = false;
  enableWeb3() {
    return new Promise((resolve, reject) => {
      if (this.windowObj.ethereum) {
        this.web3 = new Web3(this.windowObj.ethereum);
        this.windowObj.ethereum.enable().then((data) => {
          console.log('user accepted metamask usage');
          this.web3Enabled = true;
          this.setUserAccount().then(data => {
            this.setNetworkId();
            resolve(this.web3);
          })
        });
      } else if (this.windowObj.web3) {
        this.web3 = new Web3(this.windowObj.web3.currentProvider);
        console.log('old version of metamask installed');
        this.web3Enabled = true;
        this.setUserAccount();
        resolve(this.web3);
      } else {
        this.web3Enabled = false;
        console.log('metamask not installed');
      }
    })

  }

  setUserAccount() {
    return new Promise((resolve, reject) => {
      this.web3.eth.getAccounts().then((accounts) => {
        console.log(accounts);
        this.userAccountAddr = accounts[0];
        resolve(accounts[0]);
      });
    })

  }

  setNetworkId() {
    let windowObj: any = window;
    if (windowObj.ethereum) {
      this.networkId = windowObj.ethereum.chainId;
    } else {
      this.networkId = undefined;
    }
  }

  getWeb3() {
    return this.web3;
  }

  getNetworkId() {
    return this.networkId;
  }

  getUserAccountAddr() {
    return this.userAccountAddr;
  }

  isWeb3Enabled() {
    return this.isWeb3Enabled;
  }
}
