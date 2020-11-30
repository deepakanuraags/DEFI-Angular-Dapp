import { Injectable } from '@angular/core';
import { web3Service } from './web3.service';
@Injectable({
    providedIn: 'root',
})
export class StakingContractService {
    web3Service: web3Service;
    constructor(web3Service: web3Service) {
        this.web3Service = web3Service;
    }

    public getUserData(pid: number, stakingABI: Array<any>, stakingContractAddress: string): Promise<any> {
        return new Promise((resolve, reject) => {
            this.web3Service.enableWeb3().then(data => {
                let web3 = this.web3Service.getWeb3();
                let ytspContract = new web3.eth.Contract(stakingABI, stakingContractAddress)
                ytspContract.methods
                    .userData(pid, this.web3Service.getUserAccountAddr()).call().then(data => {
                        console.log("successfully got user data");
                        resolve(data);
                    })
            }).catch(err => {
                console.log("error in getting user data");
                console.log(err);
                reject(err);
            })
        });
    }

    public getPoolDetails(pid: number, stakingABI: Array<any>, stakingContractAddress: string): Promise<any> {
        return new Promise((resolve, reject) => {
            this.web3Service.enableWeb3().then(data => {
                let web3 = this.web3Service.getWeb3();
                let ytspContract = new web3.eth.Contract(stakingABI, stakingContractAddress)
                ytspContract.methods
                    .poolDetails(pid).call().then(data => {
                        console.log("successfully got pool details");
                        resolve(data);
                    })
            }).catch(err => {
                console.log("error in getting pool details");
                console.log(err);
                reject(err);
            })
        });
    }

    public getTodaysEmission(stakingABI: Array<any>, stakingContractAddress: string): Promise<any> {
        return new Promise((resolve, reject) => {
            this.web3Service.enableWeb3().then(data => {
                let web3 = this.web3Service.getWeb3();
                let ytspContract = new web3.eth.Contract(stakingABI, stakingContractAddress)
                ytspContract.methods
                    .getOnGoingTotalRewardsPerDay().call().then(data => {
                        console.log("successfully got user data");
                        resolve(data);
                    })
            }).catch(err => {
                console.log("error in getting user data");
                console.log(err);
                reject(err);
            })
        });
    }
    public stakeTokens(pid, amountToStake, stakingABI: Array<any>, stakingContractAddress: string): Promise<any> {
        return new Promise((resolve, reject) => {
            this.web3Service.enableWeb3().then((data => {
                let web3 = this.web3Service.getWeb3();
                web3.eth.estimateGas({ from: this.web3Service.getUserAccountAddr() }).then((result) => {
                    var _gas = result + 300000;
                    var _gasPrice = 90000000000;
                    let ytspContract = new web3.eth.Contract(stakingABI, stakingContractAddress)
                    console.log(amountToStake.toString());
                    console.log(web3.utils.toWei(amountToStake.toString(), 'ether'));
                    ytspContract.methods
                        .deposit(pid, web3.utils.toWei(amountToStake.toString(), 'ether'))
                        .send({ from: this.web3Service.getUserAccountAddr(), gas: _gas, gasPrice: _gasPrice }).then(data => {
                            console.log(data);
                            console.log("successfully staked");
                            resolve();
                        }).catch(error => {
                            reject(error);
                            console.log("error in staking");
                            console.log(error);
                        });
                });
            }))
        })

    }

    public unstakeTokens(pid, amountToUnstake, stakingABI: Array<any>, stakingContractAddress: string) {
        return new Promise((resolve, reject) => {
            this.web3Service.enableWeb3().then((data => {
                let web3 = this.web3Service.getWeb3();
                web3.eth.estimateGas({ from: this.web3Service.getUserAccountAddr() }).then((result) => {
                    var _gas = result + 300000;
                    var _gasPrice = 90000000000;
                    let ytspContract = new web3.eth.Contract(stakingABI, stakingContractAddress)

                    console.log(amountToUnstake);
                    console.log(web3.utils.toWei(amountToUnstake.toString(), 'ether'));
                    ytspContract.methods
                        .withdraw(pid, web3.utils.toWei(amountToUnstake.toString(), 'ether'))
                        .send({ from: this.web3Service.getUserAccountAddr(), gas: _gas, gasPrice: _gasPrice }).then(data => {
                            console.log(data);
                            console.log("successfully unstaked");
                            resolve();
                        }).catch(error => {
                            reject(error);
                            console.log("error in unstaking");
                            console.log(error);
                        });
                });

            }))
        });
    }

    public claimRewards(pid, stakingABI: Array<any>, stakingContractAddress: string) {
        return new Promise((resolve, reject) => {
            this.web3Service.enableWeb3().then(data => {
                let web3 = this.web3Service.getWeb3();
                web3.eth.estimateGas({ from: this.web3Service.getUserAccountAddr() }).then((result) => {
                    var _gas = result + 300000;
                    var _gasPrice = 90000000000;
                    let ytspContract = new web3.eth.Contract(stakingABI, stakingContractAddress)
                    ytspContract.methods
                        .ClaimRewards(pid)
                        .send({ from: this.web3Service.getUserAccountAddr(), gas: _gas, gasPrice: _gasPrice }).then(data => {
                            console.log(data);
                            console.log("rewards successfully claimed");
                            resolve();
                        }).catch(error => {
                            reject(error);
                            console.log("error in unstaking");
                            console.log(error);
                        });
                });
            }).catch(err => {
                console.log(err);
                console.log("error in getting user data");
            })
        })

    }

    public withdrawAll(pid, stakingABI: Array<any>, stakingContractAddress: string) {
        return new Promise((resolve, reject) => {
            this.web3Service.enableWeb3().then(data => {
                let web3 = this.web3Service.getWeb3();
                web3.eth.estimateGas({ from: this.web3Service.getUserAccountAddr() }).then((result) => {
                    var _gas = result + 300000;
                    var _gasPrice = 90000000000;
                    let ytspContract = web3.eth.Contract(stakingABI, stakingContractAddress)
                    ytspContract.methods
                        .withdrawAll(pid)
                        .send({ from: this.web3Service.getUserAccountAddr(), gas: _gas, gasPrice: _gasPrice }).then(data => {
                            console.log(data);
                            console.log("rewards successfully claimed");
                            resolve();
                        }).catch(error => {
                            reject(error);
                            console.log("error in unstaking");
                            console.log(error);
                        });
                });
            }).catch(err => {
                console.log(err);
                console.log("error in getting user data");
            })
        })
    }
}