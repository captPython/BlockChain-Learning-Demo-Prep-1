pragma solidity ^0.4.22;


contract TokenConfig {
string  public constant TOKEN_SYMBOL      = "RES";
    string  public constant TOKEN_NAME        = "Real Estate Token";
    uint8   public constant TOKEN_DECIMALS    = 18;

    uint256 public constant DECIMALSFACTOR    = 10**uint256(TOKEN_DECIMALS);
    uint256 public constant TOKEN_TOTALSUPPLY = 1000000 * DECIMALSFACTOR;

    address public constant PUBLIC_RESERVED = 0xFbE0a75D9e10AEbe65AD7DBd35260BC587177875;
    uint256 public constant PUBLIC_RESERVED_PERSENTAGE = 9000;


    /**BOARD_RESERVED 1 : Executive , BOARD_RESERVED 2 : Executive, BOARD_RESERVED 3 : CRO, BOARD_RESERVED 4 : CTO 
       & BOARD_RESERVED 5 : CEO */
    address[] public BOARD_RESERVED = 
    [ 0x82bF51a540c471dF100246574A97650C464DDe0c,                 
      0xf5C9B2c724256A5597BC348a0D298841d09ac628,
      0x82a766cE8E5881fADB27fB7a86806BD9940C3e82,
      0x598a5a48d3fCcC46268A474ad9B29F5374c531A4,
      0x54948B847BEe22640A0734b17e5AEA52AbE4cB3e];

    uint256[] public BOARD_RESERVED_PERSENTAGE = [1000,1000,2000,3000,4000];
}
