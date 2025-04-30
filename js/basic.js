const contractAddress = "0x4d6d3f4edcda4f71a6b76e8a5111e6bcc9fbb119";

let userBalance = 0;

//尝试重新分配 contractAddress 变量。会发生什么？为什么？
//无法分配，因为const指定的变量为常量，一开始就要定义好，且后续无法改变

// number
const x = 5;
// string
const y = "wzy cool";
// boolean
const t = true;
// undefined
const o = undefined;
// 空值
const k = null;
// Symbol,還不知道其作用
const tkj = Symbol("123");
// bigint
const gg = BigInt(124125215125125);

console.log(typeof x);
console.log(typeof y);
console.log(typeof t);
console.log(typeof k);
console.log(typeof tkj);
console.log(typeof gg);

const user = {
  name: "wzy",
  accountAddress: "0x...",
  isVerified: true,
  balance: 100,
};

const coins = ["btc", "eth", "sol"];

const cost = 5 * 0.1;

const l = user.balance > cost;

const vk = user.isVerified && user.balance > cost;

const welcome = "welcome to my DApp" + user.name + user.accountAddress;
