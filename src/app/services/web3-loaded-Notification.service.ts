import { Subject } from "rxjs";
import { Injectable } from '@angular/core';
@Injectable({
    providedIn: 'root',
})
export class web3LoadedCheckService {
    public web3Loaded: boolean;

    constructor() {
        this.web3Loaded = false;
    }
    public setWeb3Loaded(val: boolean) {

        // set after ngAfterViewInit of AppComponent
        this.web3Loaded = val;
    }
}