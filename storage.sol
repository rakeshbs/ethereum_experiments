pragma solidity >=0.3.0;
contract sstorage {
  int data;

  function set(int _data) {
    data = _data;
  }

  function get() returns (int retVal) {
    return data;
  }
}
