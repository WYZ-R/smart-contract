// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleToken {
    string public name ="MyToken";
    string public symbol ="MTK";
    uint8 public decimals = 18;
    uint256 public totalSupply = 0;

    // 用于记录各个地址的余额
    mapping(address => uint256) public balanceOf;
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

     constructor() {
        // Mint 1000 tokens to the contract deployer
        _mint(msg.sender, 1000 * 10**decimals);
    }

    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "Mint to the zero address");
        totalSupply += amount;
        balanceOf[account] += amount;
        emit Transfer(address(0), account, amount);
    }

    function transfer(address recipient, uint256 amount) public returns (bool) {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        require(recipient != address(0), "Transfer to the zero address");
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }
    // 这个是授权的映射写法 例子：A授权B x数量的代币
    // 用于记录某地址授权给某地址多少代币
    mapping(address => mapping(address => uint256)) public allowance;

    
    function approve(address spender, uint256 amount) public returns (bool) {
        require(spender != address(0), "Approve the zero address");
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }


    // 用户间转账
    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        // 三重检查
        require(allowance[sender][msg.sender] >= amount, "Allowance exceeded");
        require(balanceOf[sender] >= amount, "Insufficient balance");
        require(recipient != address(0), "Transfer to the zero address");
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    //增强合同：添加一个允许用户销毁自己代币的功能。我这个是能随意销毁别人的代币
    function burn(uint256 amount) external returns(bool) {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        balanceOf[msg.sender]-= amount;
        emit Transfer(msg.sender, address(0), amount);
        return true;
    }
}