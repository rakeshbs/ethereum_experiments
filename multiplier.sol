pragma solidity >=0.3.0;
contract multiplier {
  event Multiplied(int result);

  function multiply(int x, int y, int z) returns (int result) {
    result = x * y * z;
    Multiplied(result);
  }
}
