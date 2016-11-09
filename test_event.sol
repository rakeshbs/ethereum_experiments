pragma solidity >=0.3.0;
contract testevent {
  int data;
  event setData(int data);
  event getData();

  function set(int _data) {
    data = _data;
    setData(data);
  }

  function get() returns (int retVal) {
    getData();
    return data;
  }
}
