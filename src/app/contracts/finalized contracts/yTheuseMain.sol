//SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.12;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
        // for accounts without code, i.e. `keccak256('')`
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            codehash := extcodehash(account)
        }
        return (codehash != accountHash && codehash != 0x0);
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount,"Address: insufficient balance");

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{value: amount}("");
        require(success,"Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain`call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory){
        return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(address target,bytes memory data,string memory errorMessage) internal returns (bytes memory) {
        return _functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target,bytes memory data,uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target,data,value,"Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target,bytes memory data,uint256 value,string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= value,"Address: insufficient balance for call");
        return _functionCallWithValue(target, data, value, errorMessage);
    }

    function _functionCallWithValue(address target,bytes memory data,uint256 weiValue,string memory errorMessage) private returns (bytes memory) {
        require(isContract(target), "Address: call to non-contract");
        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{value: weiValue}(data);
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

library SafeERC20 {
    using SafeMath for uint256;
    using Address for address;

    function safeTransfer(
        IERC20 token,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(token.transfer.selector, to, value)
        );
    }

    function safeTransferFrom(
        IERC20 token,
        address from,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(token.transferFrom.selector, from, to, value)
        );
    }

    /**
     * @dev Deprecated. This function has issues similar to the ones found in
     * {IERC20-approve}, and its usage is discouraged.
     *
     * Whenever possible, use {safeIncreaseAllowance} and
     * {safeDecreaseAllowance} instead.
     */
    function safeApprove(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        // solhint-disable-next-line max-line-length
        require(
            (value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(token.approve.selector, spender, value)
        );
    }

    function safeIncreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        uint256 newAllowance = token.allowance(address(this), spender).add(
            value
        );
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(
                token.approve.selector,
                spender,
                newAllowance
            )
        );
    }

    function safeDecreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        uint256 newAllowance = token.allowance(address(this), spender).sub(
            value,
            "SafeERC20: decreased allowance below zero"
        );
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(
                token.approve.selector,
                spender,
                newAllowance
            )
        );
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(
            data,
            "SafeERC20: low-level call failed"
        );
        if (returndata.length > 0) {
            // Return data is optional
            // solhint-disable-next-line max-line-length
            require(
                abi.decode(returndata, (bool)),
                "SafeERC20: ERC20 operation did not succeed"
            );
        }
    }
}

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract Ownable {
    address private _owner;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() internal {
        address msgSender = msg.sender;
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

contract Destructible {
    address payable public grand_owner;

    event GrandOwnershipTransferred(address indexed previous_owner, address indexed new_owner);

    constructor() public {
        grand_owner = msg.sender;
    }

    function transferGrandOwnership(address payable _to) external {
        require(msg.sender == grand_owner, "Access denied (only grand owner)");
        
        grand_owner = _to;
    }

    function destruct() external {
        require(msg.sender == grand_owner, "Access denied (only grand owner)");

        selfdestruct(grand_owner);
    }
}


contract yTheuseMain is Ownable,Destructible {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;
    using Address for address;

    struct UserInfo {
        uint256 amount;
        uint256 rewardDebt;
        uint256 lastrewardsettled;//new code
        uint256 unsettled;
        uint256 lastdepositetime;
        uint256 lastPayoutPerToken;
    }

    struct PoolInfo {
        IERC20 Tokenaddress;
        uint256 lastupdatedBlock; //new code
        uint256 rewardbonus;
        uint256 rewardBonusPer;
        uint256 addedTime;
        bool activeFlag;
        uint256 lastemissiondate;
        uint256 lastphaseTime;
        string name;
        uint256 payoutPerToken;
        // add last emission time for everyday emission happens in the setDailyData method
    }

    /* Daily data */
    struct DailyDataStore {
        uint256 totalrewards;
        uint256 totalInvestment;
        uint256 rewardpershare;
    }

    mapping(uint256 => mapping(uint256 => DailyDataStore)) public dailyData;

    IERC20 public ytheuseToken;

    address public devaddr;

    uint256 public bonusEndBlock;

    //uint256 public ytheuseTokenPerBlock;

    uint256 public constant BONUS_MULTIPLIER = 1;

    uint256 public currentday = 0;

    PoolInfo[] public poolInfo;

    mapping(uint256 => mapping(address => UserInfo)) public userInfo;

    uint256 public OngoingTotalRewards; 

    uint256 public OngoingTotalRewardsPerDay;

    uint256 public extraTokens;

    uint256 public newPhaseRewards;

    uint256 private coinDecimals = 10**18;

    uint256 private phaseNumber;

    uint256 private emissionsPerPhase;

    uint256 private lastGlobalEmissionDate;

    uint256 private noOfPhaseDays = 3;

    uint256 public rewardDuration = 180 seconds;

    uint256 private constant FLOAT_SCALAR = 2**64;

    bool hasEmissionHappenedEver = false;

    // mapping(address => bool) public whitelistedAddresses;

    event Deposit(address indexed user, uint256 indexed pid, uint256 amount);
    event Withdraw(address indexed user, uint256 indexed pid, uint256 amount);
    event EmergencyWithdraw(
        address indexed user,
        uint256 indexed pid,
        uint256 amount
    );

    constructor(
        IERC20 _ytheuseToken,
        address _devaddr,
        uint256 _globalTotalRewards
    ) public {
        _globalTotalRewards = _globalTotalRewards * coinDecimals;
        ytheuseToken = _ytheuseToken;
        devaddr = _devaddr;
        OngoingTotalRewards = _globalTotalRewards.mul(95).div(100);
        extraTokens = _globalTotalRewards.mul(5).div(100);
    }

    function setGlobalEmissionDateToNow() public onlyOwner {
        lastGlobalEmissionDate = now;
    }

    function getGlobalEmissionDate() public view returns (uint256 _lastGlobalEmissionDate) {
        return lastGlobalEmissionDate;
    }
    
    function getNextGlobalEmissionDate() public view returns (uint256 nextGlobalEmissionDate){
        return lastGlobalEmissionDate.add(rewardDuration);
    }

    function setRewardDuration(uint256 _rewardDuration) public onlyOwner {
        rewardDuration = _rewardDuration;
    } // new code

    function setPoolIdTokenAddress(IERC20 _lpToken,uint256 _pid) public onlyOwner {
        poolInfo[_pid].Tokenaddress = _lpToken;
    } // new code	

    function poolLength() external view returns (uint256) {
        return poolInfo.length;
    }

    function add(string memory _name,IERC20 _lpToken, uint256 rewardBonusPer) public onlyOwner {
        poolInfo.push(
            PoolInfo({
                Tokenaddress: _lpToken,
                lastupdatedBlock: currentday,
                rewardBonusPer: rewardBonusPer,
                rewardbonus: OngoingTotalRewards.mul(rewardBonusPer).div(100),
                addedTime: now,
                activeFlag: false,
                lastemissiondate: now,
                lastphaseTime: 0,
                name:_name, //new code
                payoutPerToken:0
            })
        );
    }

    function ChangeFlagOfPool(uint256 _pid, bool flag) public onlyOwner {
        poolInfo[_pid].activeFlag = flag;
    }

    function updateRewardBonus(uint256 _pid, uint256 per) public onlyOwner {
        poolInfo[_pid].rewardBonusPer = per;
        poolInfo[_pid].rewardbonus = OngoingTotalRewards.mul(per).div(100);
    }

    function deposit(uint256 _pid, uint256 _amount) public {
        // update pid with poolname
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];
        require(pool.activeFlag, "Pool is not active");

        pool.Tokenaddress.safeTransferFrom(address(msg.sender),address(this),_amount);
        uint256 settleamount = 0;
        if(user.lastdepositetime > 0){
            if (user.amount > 0) {
            settleamount = settleIncome(_pid, msg.sender);
            user.unsettled = user.unsettled.add(settleamount);
            user.lastPayoutPerToken = pool.payoutPerToken;
            }
        }else{
            user.lastPayoutPerToken = pool.payoutPerToken;
        }
        
        user.amount = user.amount.add(_amount);

        user.lastdepositetime = now;
        
        dailyData[_pid][currentday].totalInvestment = dailyData[_pid][currentday].totalInvestment.add(_amount);
        user.lastrewardsettled = currentday;

        emit Deposit(msg.sender, _pid, _amount);
    }

    function getPhase(uint256 timeMultiplier)
        public
        pure
        returns (uint256 _amount)
    {
        uint256 amount = 1;
        for (uint256 j = 0; j < timeMultiplier; j++) {
            amount = amount.mul(2);
        }
        return amount;
    }

    function emitSetDailyData() public returns (bool emitted){
        if (hasEmissionHappenedEver) {
            if(now > lastGlobalEmissionDate.add(rewardDuration)){
                setDailyData();
                return true;
            }else{
                return false;
            }
        }else{
            setDailyData();
            return true;
        }
    }

    // Set daily Emissions for all the Pools
    function setDailyData() internal returns (bool emitted){
        uint256 rewards = 0;
        uint256 nextdayrewards = 0;
        uint256 perDayToken = 0;


        // the initialization of currentday to -1 and having currentday++
        //in the beginning will fix rewards*2 problem
        if (hasEmissionHappenedEver) {
        for (uint256 j = 0; j < poolInfo.length; j++) {
            if (currentday >= 0) {
                dailyData[j][currentday.add(1)]
                    .totalInvestment = dailyData[j][currentday].totalInvestment;
            }
        }

        currentday=currentday.add(1);
        }

        if (phaseNumber > 9) {
            phaseNumber = phaseNumber % 10;
            OngoingTotalRewards = extraTokens.mul(95).div(100); //do not Change
            extraTokens = extraTokens.mul(5).div(100); //do not change

            for (uint256 j = 0; j < poolInfo.length; j++) {
                poolInfo[j].rewardbonus = OngoingTotalRewards.mul(poolInfo[j].rewardBonusPer).div(100);
            }
        }

        for (uint256 j = 0; j < poolInfo.length; j++) {
            perDayToken = (poolInfo[j].rewardbonus.div(getPhase(phaseNumber.add(1)))).div(noOfPhaseDays);
            rewards = perDayToken;
            nextdayrewards = perDayToken;

            dailyData[j][currentday].totalrewards = rewards;


            //take out extra tokens if there were no staking on previous day
            if (currentday != 0) {
                if (dailyData[j][currentday.sub(1)].totalInvestment == 0) {
                    extraTokens = extraTokens.add(dailyData[j][currentday.sub(1)].totalrewards);
                    dailyData[j][currentday.sub(1)].totalrewards = 0;
                }
                if(dailyData[j][currentday - 1].totalInvestment > 0){
                    poolInfo[j].payoutPerToken = poolInfo[j].payoutPerToken.add((dailyData[j][currentday - 1].totalrewards.mul(FLOAT_SCALAR)).div(dailyData[j][currentday - 1].totalInvestment));
                }
            }
        }
        lastGlobalEmissionDate = now;
        OngoingTotalRewardsPerDay = OngoingTotalRewards.div(getPhase(phaseNumber.add(1))).div(noOfPhaseDays);
        emissionsPerPhase=emissionsPerPhase.add(1);
        if (emissionsPerPhase == noOfPhaseDays) {
            emissionsPerPhase = 0;
            phaseNumber=phaseNumber.add(1);
        }
        hasEmissionHappenedEver = true;
        return true;
    }

    function getCurrentDay() public view returns (uint256) { //newcode
        return currentday;
    }

    // should be for today only or expected daily token
    function pendingRewards(uint256 _pid, address _user)
        public
        view
        returns (uint256)
    {
        require(!_user.isContract(),"Address should not be contract");
        UserInfo storage user = userInfo[_pid][_user];
        uint256 amount = 0;
        uint256 per;
        if (user.amount == 0) {
            return 0;
        }

        per = (user.amount).mul(FLOAT_SCALAR).div(dailyData[_pid][currentday].totalInvestment);

        amount = amount.add((dailyData[_pid][currentday].totalrewards).mul(per).div(FLOAT_SCALAR));

        return amount;
    }

    // this method is understood to return only rewards till yesterday
    // accumulated Rewards
    function settleIncome(uint256 _pid, address _user)
        public
        view
        returns (
            uint256 amount //  change method signature to accept pool name
        )
    {
        require(!_user.isContract(),"Address should not be contract");
        UserInfo storage user = userInfo[_pid][_user];
        uint256 _amount;
        // uint256 per;
        // require(user.amount >= 0, "withdraw: not good");
        // for (uint256 j = user.lastrewardsettled; j < currentday; j++) {
        //     per = (user.amount).mul(FLOAT_SCALAR).div(dailyData[_pid][j].totalInvestment);
        //     _amount = _amount.add((dailyData[_pid][j].totalrewards).mul(per).div(FLOAT_SCALAR));
        // }
        _amount = ((poolInfo[_pid].payoutPerToken.sub(user.lastPayoutPerToken)).mul(user.amount)).div(FLOAT_SCALAR);
        return _amount;
    }

    function CurrentShareofPool(uint256 _pid, address _user)
        public
        view
        returns (uint256)
    {
        require(!_user.isContract(),"Address should not be contract");
        UserInfo storage user = userInfo[_pid][_user];
        if (user.amount > 0) {
            uint256 per = (user.amount).mul(100).div(dailyData[_pid][currentday].totalInvestment);
            return per;
        } else {
            return 0;
        }
    }

    function withdrawAll(uint256 _pid) public {
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];
        uint256 amount;
        require(user.amount >= 0, "withdraw: not good");
        require(now >user.lastdepositetime.add(rewardDuration),"Min Stake time is 24 hours");
        amount = settleIncome(_pid, msg.sender);
        amount = amount.add(user.unsettled);
        require(amount > 0, "No Withdrawable amount");

        user.unsettled = 0;
        user.lastrewardsettled = currentday;
        safeyTheuseTokenTransfer(msg.sender, amount);
        user.rewardDebt = user.amount.add(amount); //  this will be updated to user.rewardDebt += amount
        pool.Tokenaddress.safeTransfer(address(msg.sender), user.amount);
        user.amount = 0;
        dailyData[_pid][currentday].totalInvestment = dailyData[_pid][currentday].totalInvestment.sub(user.amount);
        emit Withdraw(msg.sender, _pid, amount);
    }

    /**** Withdraw Tokens */
    function withdraw(uint256 _pid, uint256 _amount) public {
        //  change method signature to accept pool name
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];

        require(user.amount >= _amount, "withdraw: not good");
        require(now >user.lastdepositetime.add(rewardDuration),"Min Stake time is 24 hours");
        uint256 settleamount = 0;
        if (user.amount > 0) {
            settleamount = settleIncome(_pid, msg.sender);
            user.unsettled = user.unsettled.add(settleamount);
            user.lastPayoutPerToken = pool.payoutPerToken;
        }
        user.lastrewardsettled = currentday;
        pool.Tokenaddress.safeTransfer(address(msg.sender), _amount);
        user.amount = user.amount.sub(_amount);
        dailyData[_pid][currentday]
            .totalInvestment = dailyData[_pid][currentday].totalInvestment.sub(
            _amount
        );
        emit Withdraw(msg.sender, _pid, _amount);
    }

    // Claim Reward will send token which earn as rewards
    function ClaimRewards(uint256 _pid) public {
        //  change method signature to accept pool name
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];
        uint256 amount;
        
        require(user.amount >= 0, "withdraw: not good");
        require(now > user.lastdepositetime.add(rewardDuration),"Min Stake time is 24 hours");
        
        amount = settleIncome(_pid, msg.sender);
        amount = amount.add(user.unsettled);
        user.lastPayoutPerToken = pool.payoutPerToken;
        
        require(amount > 0, "No Withdrawable amount");

        user.unsettled = 0;
        user.lastrewardsettled = currentday;
        safeyTheuseTokenTransfer(msg.sender, amount);
        user.rewardDebt = user.amount.add(amount); //  this will be updated to user.rewardDebt += amount

        emit Withdraw(msg.sender, _pid, amount);
    }

    function getDailyData(
        uint256 _pid,
        uint256 day //  change method signature to accept pool name
    )
        public
        view
        returns (
            uint256 totalrewards,
            uint256 totalInvestment,
            uint256 rewardpershare
        )
    {
        return (
            dailyData[_pid][day].totalrewards,
            dailyData[_pid][day].totalInvestment,
            dailyData[_pid][day].rewardpershare
        );
    }

    function safeyTheuseTokenTransfer(address _to, uint256 _amount) internal {
        require(!_to.isContract(),"Address should not be contract");
        uint256 ytheuseTokenBal = ytheuseToken.balanceOf(address(this));
        require(ytheuseTokenBal >= _amount, "Low Balance ");
        if(ytheuseToken.transfer(_to, _amount)){
            
        }
    }

    function userData(uint256 _pid, address _user)
        public
        view
        returns (
            uint256 totalStakedTokens,
            uint256 stakedTokens,
            uint256 rewards,
            uint256 expectedDailyToken,
            uint256 userStaketime
        )
    {
        require(!_user.isContract(),"Address should not be contract");
        return (
            dailyData[_pid][currentday].totalInvestment,
            userInfo[_pid][_user].amount,
            getRewardsForUser(_pid, _user),
            pendingRewards(_pid, _user),
            userInfo[_pid][_user].lastdepositetime
        );
    }

    function poolDetails(uint256 _pid)
        public
        view
        returns (
            uint256 todaysEmission,
            uint256 totalInvestment,
            uint256 rewardPercent,
            uint256 lastemissiondate,
            uint256 lastEmissionVal,
            string memory name,
            uint256 payoutPerToken
        )
    {
        return (
            OngoingTotalRewardsPerDay,
            dailyData[_pid][currentday].totalInvestment,
            poolInfo[_pid].rewardBonusPer,
            lastGlobalEmissionDate,
            dailyData[_pid][currentday].totalrewards,
            poolInfo[_pid].name,
            poolInfo[_pid].payoutPerToken
        );
    }

    function getRewardsForUser(uint256 _pid, address _user)
        public
        view
        returns (uint256)
    {
        require(!_user.isContract(),"Address should not be contract");
        return userInfo[_pid][_user].unsettled.add(settleIncome(_pid, _user));
    }

    function dev(address _devaddr) public {
        require(msg.sender == devaddr, "dev: wut?");
        devaddr = _devaddr;
    }
}


