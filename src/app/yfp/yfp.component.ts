import { web3Service } from '../services/web3.service';
import { Component, AfterViewInit, enableProdMode, ChangeDetectorRef, NgZone } from '@angular/core';
import { stakingABI, stakingAddr } from '../ABI-TokenAddresses/staking-contract-abi-token';
import { ytheusABI, ytheusTokenAddr } from '../ABI-TokenAddresses/ytheus-contract-abi-token';
import { ytheusDecimals, poolPids } from '../constants';
import { StakingContractService } from '../services/staking-contract.service';
import { TokenContractService } from '../services/token-contract.service';
import { ActivatedRoute, Router } from '@angular/router';
import { theusABI, theusTokenAddr } from '../ABI-TokenAddresses/theus-contract-abi-token';
import { yTheusBptABI, yTheusBptAddr } from '../ABI-TokenAddresses/yTheusBPT-contract-abi-token';
import { theusULPABI, theusULPTokenAddr } from '../ABI-TokenAddresses/theusULP-contract-abi-token';
import { ytheusUlpABI, ytheusUlpTokenAddr } from '../ABI-TokenAddresses/yTheusULP-contract-abi-token';
@Component({
  selector: 'yfp',
  templateUrl: './yfp.component.html',
  styleUrls: ['./yfp.component.css'],
})
export class YfpComponent implements AfterViewInit {
  // title = 'YTheus Fund Pool';
  web3: any;
  windowObj: any = window;
  amountToStake: string;
  amountToUnstake: string;
  userAccountAddress: string;

  //services used
  web3Service: web3Service;


  //current active pane
  pane: string = 'stake';

  // overall details
  ytheusPoolDetais: YtheusPoolDetais;
  personalStatistics: PersonalStatistics;

  //is user connected
  isUserConnected: boolean;
  userAccountInterval;

  //change detection
  changeDetectorRef: ChangeDetectorRef;
  ngZone: NgZone;


  //contract services
  StakingContractService: StakingContractService;
  TokenContractService: TokenContractService;

  //activated route;
  activatedRoute: ActivatedRoute;

  //router
  router: Router;

  yTheusFundPool = {
    imageClassName: 'sidebar-icon-only body-4',
    stakeTokenName: "yTheus",
    stakePoolName: "yTheus Fund Pool",
    poolId: poolPids.yTheusFundPool,
    tokenABI: ytheusABI,
    tokenAddr: ytheusTokenAddr,
    userAddressColor: `1ECABD!important`
  }

  theusFundPool = {
    imageClassName: 'sidebar-icon-only body-3',
    stakeTokenName: "theus",
    stakePoolName: "Theus Fund Pool",
    poolId: poolPids.TheusFundPool,
    tokenABI: theusABI,
    tokenAddr: theusTokenAddr,
    userAddressColor: `CBA507!important`
  }

  yTheusBalancerPool = {
    imageClassName: 'sidebar-icon-only body-1',
    stakeTokenName: "YBPT",
    stakePoolName: "yTheus Balancer Pool",
    poolId: poolPids.yTheusBalancerPool,
    tokenABI: yTheusBptABI,
    tokenAddr: yTheusBptAddr
  }

  theusUniswapPool = {
    imageClassName: 'sidebar-icon-only body-7',
    stakeTokenName: "TULP",
    stakePoolName: "Theus Uniswap Pool",
    poolId: poolPids.TheusUniswapPool,
    tokenABI: theusULPABI,
    tokenAddr: theusULPTokenAddr,
    userAddressColor: `0625CC!important`
  }

  yTheusUniswapPool = {
    imageClassName: 'sidebar-icon-only body-6',
    stakeTokenName: "YULP",
    stakePoolName: "yTheus Uniswap Pool",
    poolId: poolPids.yTheusUniswapPool,
    tokenABI: ytheusUlpABI,
    tokenAddr: ytheusUlpTokenAddr,
    userAddressColor: `CA0006!important`
  }

  paneState = {
    stake: true,
    rewards: false,
    unstake: false
  }
  poolContext;

  isAmountToStakeValid: boolean;
  isAmountToUnstakeValid: boolean;

  //currentBalance;

  constructor(web3Service: web3Service, changeDetectorRef: ChangeDetectorRef,
    ngZone: NgZone, StakingContractService: StakingContractService,
    TokenContractService: TokenContractService, activatedRoute: ActivatedRoute,
    router: Router) {
    console.log(activatedRoute);
    this.activatedRoute = activatedRoute;
    this.web3Service = web3Service;
    this.changeDetectorRef = changeDetectorRef;
    this.ytheusPoolDetais = new YtheusPoolDetais();
    this.personalStatistics = new PersonalStatistics();
    this.isUserConnected = false;
    this.StakingContractService = StakingContractService;
    this.TokenContractService = TokenContractService;
    this.ngZone = ngZone;
    this.router = router;
    this.isAmountToStakeValid = true;
    this.isAmountToUnstakeValid = true;
    this.assignPoolContext();
  }

  assignPoolContext() {
    switch (this.activatedRoute.routeConfig.path) {
      case 'yup':
        this.poolContext = this.yTheusUniswapPool;
        break;
      case 'tup':
        this.poolContext = this.theusUniswapPool;
        break;
      case 'ybp':
        this.poolContext = this.yTheusBalancerPool;
        break;
      case 'tfp':
        this.poolContext = this.theusFundPool;
        break;
      case 'yfp':
        this.poolContext = this.yTheusFundPool;
        break;
      default:
        break;
    }
  }

  setPane(paneState: string) {
    switch (paneState) {
      case 'stake':
        this.paneState = {
          stake: true,
          rewards: false,
          unstake: false
        }
        break;
      case 'rewards':
        this.paneState = {
          stake: false,
          rewards: true,
          unstake: false
        }
        break;
      case 'unstake':
        this.paneState = {
          stake: false,
          rewards: false,
          unstake: true
        }
        break;
      default:
        this.paneState = {
          stake: true,
          rewards: false,
          unstake: false
        }
    }
    this.pane = paneState;
  }

  ngAfterViewInit() {
    this.web3Service.enableWeb3().then(data => {
      if (this.web3Service.isWeb3Enabled()) {
        this.web3 = this.web3Service.getWeb3();
        this.userAccountAddress = this.web3Service.getUserAccountAddr();
        this.registerEventForAccountChange();
        this.registerEventForChainChange();
        this.isUserConnected = this.checkIfMainNetwork();
        setTimeout(() => {
          this.updateUserData();
        }, 500)

      } else {
        console.log("web3 not loaded in after view init of ytsp component");
      }
    })
  }

  registerEventForAccountChange() {
    if (this.web3Service.windowObj.ethereum) {
      this.web3Service.windowObj.ethereum.on("accountsChanged", (accounts) => {
        console.log("user account changed");
        this.web3Service.setUserAccount().then(currentAccount => {
          console.log("current user account : " + currentAccount);
          this.isUserConnected = false;
          // if (this.checkIfMainNetwork()) {
          //   this.isUserConnected = true;
          //   this.updateUserData();
          // }
          window.location.reload();
        })
      })
    }
  }

  registerEventForChainChange() {
    if (this.web3Service.windowObj.ethereum) {
      this.web3Service.windowObj.ethereum.on("chainChanged", (chainId) => {
        console.log("chain account changed");
        console.log("current chain id: " + chainId);
        this.web3Service.setNetworkId();
        this.isUserConnected = false;
        // this.ngZone.run(() => {
        //   this.reloadComponent();
        // })
        window.location.reload();
      })
    }
  }

  checkIfMainNetwork() {
    // this.web3Service.getNetworkId() == '0x1'; main network currently in test network
    return this.web3Service.getNetworkId() == '0x1'
  }

  reloadComponent() {
    this.router.routeReuseStrategy.shouldReuseRoute = () => false;
    this.router.onSameUrlNavigation = 'reload';
    this.router.navigate(['/yfp']);
  }

  approve() {
    if (this.validateAmount(this.amountToStake)) {
      this.TokenContractService.approve(this.amountToStake, this.poolContext.tokenABI, this.poolContext.tokenAddr, stakingAddr).then(data => {
        console.log("successfully approved");
      }).catch(err => {
        console.log(err);
        console.log("error in approval");
      })
    }
  }

  checkBalance() {
    this.TokenContractService.getBalance(this.poolContext.tokenABI, this.poolContext.tokenAddr).then(balance => {
      console.log("balance of " + this.web3Service.getUserAccountAddr() + " is " + balance);
      this.ngZone.run(() => {
        // this.personalStatistics.currentBalance = (balance / ytheusDecimals).toFixed(2);
        this.personalStatistics.currentBalance = this.clipDecimals(this.web3Service.getWeb3().utils.fromWei(balance, 'ether'));
      });
    }).catch(err => {
      console.log("error in getting the latest balance for the user");
    })
  }

  stake() {
    if (this.validateAmount(this.amountToStake)) {
      this.StakingContractService.stakeTokens(this.poolContext.poolId, this.amountToStake, stakingABI, stakingAddr).then(data => {
        console.log("successful stake");
        this.amountToStake = "0";
        this.updateUserData();
      }).catch(err => {
        console.log(err);
        console.log("error in staking");
      })
    }
  }

  unstake() {
    if (this.validateAmount(this.amountToUnstake)) {
      this.StakingContractService.unstakeTokens(this.poolContext.poolId, this.amountToUnstake, stakingABI, stakingAddr).then(data => {
        this.amountToUnstake = "0";
        this.updateUserData();
        console.log("successfully unstaked");
      }).catch(err => {
        console.log("error in unstaking");
      })
    }
  }

  updateUserData() {
    this.checkBalance();
    this.updatePoolDetails();
    this.personalStatistics = new PersonalStatistics();
    this.StakingContractService.getUserData(this.poolContext.poolId, stakingABI, stakingAddr).then(data => {
      this.ngZone.run(() => {
        console.log(data);
        let personalStatisticsTemp = Object.create(this.personalStatistics);
        this.ytheusPoolDetais.totalStakedTokens = this.clipDecimals(this.web3Service.getWeb3().utils.fromWei(data.totalStakedTokens, 'ether'));
        this.personalStatistics.yourTotalStake = this.clipDecimals(this.web3Service.getWeb3().utils.fromWei(data.stakedTokens, 'ether'));
        if (parseFloat(this.ytheusPoolDetais.totalStakedTokens) > 0) {
          this.personalStatistics.quotaOfThePool = this.clipDecimals(((this.web3Service.getWeb3().utils.fromWei(data.stakedTokens, 'ether') / this.web3Service.getWeb3().utils.fromWei(data.totalStakedTokens, 'ether')) * 100));
          this.personalStatistics.expectedDailyToken = this.clipDecimals(this.web3Service.getWeb3().utils.fromWei(data.expectedDailyToken, 'ether'));
        }
        this.personalStatistics.currentDividend = this.clipDecimals(this.web3Service.getWeb3().utils.fromWei(data.rewards, 'ether'));
        this.personalStatistics.currentBalance = personalStatisticsTemp.currentBalance;
        this.updateDateOfStake(data.userStaketime);
        console.log(this.personalStatistics);
        // this.isUserConnected = true;
      })
    }).catch(err => {
      console.log(err);
      console.log("error in getting user data");
    })
  }

  updatePoolDetails() {
    this.ytheusPoolDetais = new YtheusPoolDetais();
    this.StakingContractService.getPoolDetails(this.poolContext.poolId, stakingABI, stakingAddr).then(data => {
      this.ngZone.run(() => {
        console.log(data);
        this.ytheusPoolDetais.totalStakedTokens = this.clipDecimals(this.web3Service.getWeb3().utils.fromWei(data.totalInvestment, 'ether'));
        this.ytheusPoolDetais.todaysEmission = this.clipDecimals(this.web3Service.getWeb3().utils.fromWei(data.todaysEmission, 'ether'));
        this.ytheusPoolDetais.indexPercentage = data.rewardPercent;
        this.ytheusPoolDetais.ytheusTokenPoolQuota = this.clipDecimals(this.web3Service.getWeb3().utils.fromWei(data.lastEmissionVal, 'ether'));
        this.updateNextEmission(data.lastemissiondate);
        console.log(this.ytheusPoolDetais);
        // this.isUserConnected = true;
      })
    }).catch(err => {
      console.log(err);
      console.log("error in getting pool details");
    })
  }

  clipDecimals(val) {
    val = val + "";
    let decimals = val.split(".");
    if (decimals[0] && decimals[1]) {
      let result = decimals[0] + "." + decimals[1].substring(0, 4);
      console.log(result);
      return result;
    } else {
      return val;
    }

  }

  claimRewards() {
    this.StakingContractService.claimRewards(this.poolContext.poolId, stakingABI, stakingAddr).then(data => {
      this.updateUserData();
      console.log("successfully claimed rewards");
    }).catch(err => {
      console.log("error in claiming rewards");
    })
  }

  withdrawAll() {
    this.StakingContractService.withdrawAll(this.poolContext.poolId, stakingABI, stakingAddr).then(data => {
      this.updateUserData();
      console.log("successfully withdrew all staked tokens and rewards");
    }).catch(err => {
      console.log("error in withdrawing all");
    })
  }

  updateDateOfStake(userStaketime) {
    if (userStaketime < 1) {
      this.personalStatistics.dateOfStake = '00:00:00';
    } else {
      var unix_timestamp = parseInt(userStaketime);
      var a = new Date(unix_timestamp * 1000);
      var year = a.getFullYear();
      var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      var month = months[a.getMonth()];
      var date = a.getDate();
      var hour = a.getHours();
      var min = a.getMinutes();
      var sec = a.getSeconds();
      this.personalStatistics.dateOfStake = date + ' ' + month + ' ' + year + ' ' + hour + ':' + min + ':' + sec;
    }
  }

  updateNextEmission(lastemissiondate) {
    let d = new Date(lastemissiondate * 1000);
    var secs = (new Date(d.getTime() + 60 * 60 * 24 * 1000).getTime() - new Date().getTime()) / 1000;
    if (secs > 0) {
      this.setEmissionTimer(secs);
    } else {
      this.ytheusPoolDetais.nextEmission = 0 + " Hours " + 0 + " Mins " + 0 + " Secs";
    }
  }

  validateAmount(value) {
    if (value) {
      if (value.trim().length == 0 || isNaN(value)) {
        console.log("Kindly insert a valid number");
        return false;
      } else {
        return true;
      }
    } else {
      console.log("Kindly insert a valid number");
      return false;
    }

  }

  validateAmountToStake() {
    if (this.amountToStake) {
      this.isAmountToStakeValid = this.validateAmount(this.amountToStake)
    } else {
      this.isAmountToStakeValid = true;
    }
  }

  validateAmountToUnstake() {
    if (this.amountToUnstake) {
      this.isAmountToUnstakeValid = this.validateAmount(this.amountToUnstake)
    } else {
      this.isAmountToUnstakeValid = true;
    }
  }

  intervalTimerToBeCleared;

  setEmissionTimer(timer) {
    if (this.intervalTimerToBeCleared) {
      clearInterval(this.intervalTimerToBeCleared);
    }
    this.intervalTimerToBeCleared = setInterval(() => {
      let hours: any = parseInt("" + (timer / 3600) % 24, 10);
      let minutes: any = parseInt("" + (timer / 60) % 60, 10);
      let seconds: any = parseInt("" + timer % 60, 10);
      hours = hours < 10 ? "0" + hours : hours;
      minutes = minutes < 10 ? "0" + minutes : minutes;
      seconds = seconds < 10 ? "0" + seconds : seconds;
      --timer;
      this.ytheusPoolDetais.nextEmission = hours + " Hours " + minutes + " Mins " + seconds + " Secs";
    }, 1000);
  }

}

class YtheusPoolDetais {
  todaysEmission;
  indexPercentage;
  ytheusTokenPoolQuota;
  totalStakedTokens;
  nextEmission;

  constructor() {
    this.todaysEmission = 0;
    this.indexPercentage = 0;
    this.ytheusTokenPoolQuota = 0;
    this.totalStakedTokens = 0;
    this.nextEmission = '00:00:00';
  }
}

class PersonalStatistics {
  yourTotalStake;
  quotaOfThePool;
  expectedDailyToken;
  currentDividend;
  dateOfStake;
  currentBalance;

  constructor() {
    this.yourTotalStake = 0;
    this.quotaOfThePool = 0;
    this.expectedDailyToken = 0;
    this.currentDividend = 0;
    this.dateOfStake = '00:00:00';
    this.currentBalance = 0;
  }
}