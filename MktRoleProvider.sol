//*~~~> SPDX-License-Identifier: unlicensed
pragma solidity  >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/access/AccessControl.sol";

contract MarketRoleProvider is AccessControl {

  /*~~~>
    Roles allow for designated accessibility
  <~~~*/
  bytes32 public constant PROXY_ROLE = keccak256("PROXY_ROLE");
  bytes32 public constant CONTRACT_ROLE = keccak256("CONTRACT_ROLE");

  /*~~~>
    Error message for unauthorized access
  <~~~*/
  string Mess = "DOES NOT HAVE ADMIN ROLE";

  /*~~~>
    Sets deployment address as default admin role
  <~~~*/
  constructor(address _controller) {
      _setupRole(DEFAULT_ADMIN_ROLE, _controller);
      _setupRole(PROXY_ROLE, _controller);
  }

  modifier hasAdmin(){
    require(hasRole(PROXY_ROLE, msg.sender), Mess);
    _;
  }

  function hasTheRole(bytes32 role, address _address) public view returns(bool){
    bool isTrue = hasRole(role, _address);
    return isTrue;
  }
  address public controlAdd;
  function setControlAdd(address _contAdd) public hasAdmin returns(bool){
    controlAdd = _contAdd;
    return true;
  }

  ///@notice
  /*~~~> External ETH transfer forwarded to controller contract <~~~*/
  event FundsForwarded(uint value, address _from, address _to);
  receive() external payable {
    payable(controlAdd).transfer(msg.value);
      emit FundsForwarded(msg.value, msg.sender, controlAdd);
  }

  ///@notice
  //*~~~> Withdraw function for any stuck ETH sent
  function withdrawAmountFromContract(address _add) hasAdmin external {
      payable(_add).transfer(address(this).balance);
   }
}