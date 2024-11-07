// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

    import {ethToUsd} from "./conversionToUsd.sol";

    error NotOwner();

contract fundMe {
    
        mapping (address => uint256) amountFundedByAdress;
        address[] funders;

        using ethToUsd for uint256;

        uint256 public constant MINIMUM_USD = 10e18;

        function fund() public payable {
            require(msg.value.getConversion() >= MINIMUM_USD, "You need to send more ETH");
            funders.push(msg.sender);

            amountFundedByAdress[msg.sender] += msg.value;            
        }

            
            address private immutable i_owner;
            constructor(){
                i_owner = msg.sender;
            }
            
            modifier onlyOwner() {
                if(i_owner != msg.sender) revert NotOwner();
                _;
            }

        function withdraw() public onlyOwner {
            require(address(this).balance > 0, "Not enough money to withdraw");

            for (uint256 x=0; x < funders.length; x++) {
                 amountFundedByAdress[funders[x]] = 0;                 
            }

            funders = new address[] (0);

            (bool success,) = payable(msg.sender).call{value: address(this).balance} ("");
            require(success, "Error on sending");
        }

}