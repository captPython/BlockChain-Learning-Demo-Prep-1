pragma solidity ^0.4.22;

import "./FlexiTokenSale.sol";
import "./TokenSaleConfig.sol";

contract RESTokenSaleContract is FlexiTokenSale, TokenSaleConfig {

    constructor() public
    FlexibleTokenSale(TOKEN_ADDRESS,WALLET_ADDRESS,ETHER_PRICE,UPDATE_PRICE_ADDRESS)
    {

    }
}
