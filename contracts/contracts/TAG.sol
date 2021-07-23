/* SPDX-License-Identifier: MIT */
pragma solidity 0.8.6;

// import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract TAG is ERC20("HashTAG Token", "TAG") {
    address public owner; // should be the manager. // TODO do we need this?
    IERC20 public depositToken;



    uint256 public redeemable;

    event Deposit(address depositor, uint256 amount);
    event Redemption(address redeemer, uint256 redeemAmount, uint256 receiveAmount);

constructor(address _owner, address _depositToken, uint256 _initialSupply, uint256 _baseReward) {
    owner = _owner;
    depositToken = IERC20(_depositToken);
    _mint(_owner, _initialSupply);
}

function deposit(uint256 _amount) public {
    depositToken.transferFrom(msg.sender, address(this), _amount);
    redeemable += _amount;
    emit Deposit(msg.sender, _amount);
}

function redeem(uint256 _amount) public {
    uint256 balance = _balances[msg.sender];
    require(balance >= _amount, "insufficient balance");

    uint256 share = balance / totalSupply();
    
    uint256 receiveAmount = share * redeemable;

    _burn(_amount);
    redeemable -= receiveAmount;

    depositToken.transfer(msg.sender, receiveAmount);
    
    emit Redemption(msg.sender, _amount, receiveAmount);
}


}