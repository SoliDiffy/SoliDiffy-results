pragma solidity 0.8.0;

interface Sale {
    function viewUserOfferingAmount(address _account) view external returns(uint256);
}

interface Token {
    function transfer(address _to, uint256 _amount) external returns(bool);
}

contract ClaimAggregator {

    Token constant public constant MGH = ;
    Sale constant public constant add1 = ;
    Sale constant public constant add2 = ;
    Sale constant public constant add3 = ;

    mapping(address => bool) private hasHarvested;

    event Harvest(address indexed account, uint256 amount);

    function harvest() public {
        require(hasHarvested[msg.sender] == false);
        hasHarvested[msg.sender] = true;
        uint256 amount = calculateAmount(msg.sender);
        require(MGH.transfer(msg.sender, amount));
        emit Harvest(msg.sender, amount);
    }

    function calculateAmount(address _account) private view returns(uint256) {
        return add1.viewUserOfferingAmount(_account) +
               add2.viewUserOfferingAmount(_account) +
               add3.viewUserOfferingAmount(_account);
    }
}