import { Injectable } from '@angular/core';
import { web3Service } from './web3.service';
import { ytheusDecimals } from '../constants';
@Injectable({
    providedIn: 'root',
})
export class TokenContractService {

    private web3Service: web3Service;
    constructor(web3Service: web3Service) {
        this.web3Service = web3Service;
    }


    public getBalance(tokenABI, tokenAddress): Promise<any> {
        return new Promise((resolve, reject) => {
            this.web3Service.enableWeb3().then(() => {
                let web3 = this.web3Service.getWeb3();
                let ytheusToken = new web3.eth.Contract(tokenABI, tokenAddress);
                ytheusToken.methods.balanceOf(this.web3Service.getUserAccountAddr()).call().then(balance => {
                    console.log("balance of " + this.web3Service.getUserAccountAddr() + " is " + balance);
                    resolve(balance);
                }).catch(err => {
                    reject(err);
                })
            })
        })

    }

    public approve(amountToStake, tokenABI, tokenAddress, stakingAddr): Promise<any> {
        return new Promise((resolve, reject) => {
            this.web3Service.enableWeb3().then((data => {
                let web3 = this.web3Service.getWeb3();
                let ytheusToken = new web3.eth.Contract(tokenABI, tokenAddress);
                web3.eth.estimateGas({ from: this.web3Service.getUserAccountAddr() }).then((result) => {
                    var _gas = result + 300000;
                    var _gasPrice = 90000000000;
                    console.log(web3.utils.toWei(amountToStake.toString(), 'ether'));
                    // let amntToStk = BigInt(web3.utils.toWei(amountToStake.toString(), 'ether'));
                    // console.log(amntToStk);
                    ytheusToken.methods.approve(stakingAddr, web3.utils.toWei(amountToStake.toString(), 'ether'))
                        .send({ from: this.web3Service.getUserAccountAddr(), gas: _gas, gasPrice: _gasPrice })
                        .then((success) => {
                            if (!success) {
                                console.log("ytheusToken stake approval request rejected");
                                resolve();
                            } else {
                                reject();
                                console.log("ytheusToken stake approval request approved");
                            }
                        }).catch(err => {
                            reject(err);
                            console.log("error in approving");
                            console.log(err);
                        })
                });

            }))
        })
    }
}