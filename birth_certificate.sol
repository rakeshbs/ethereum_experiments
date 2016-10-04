contract BirthCertificate {
  string name;
  string father;
  string mother;
  string timeofBirth;
  string dateofBirth;
  string sex;
  string placeofBirth;
  string currentAddress;

  function BirthCertificate(string _name,
                            string _sex,
                            string _father,
                            string _mother,
                            string _timeofBirth,
                            string _dateofBirth,
                            string _placeofBirth,
                            string _currentAddress
                           ) {
    name = _name;
    father = _father;
    mother = _mother;
    timeofBirth = _timeofBirth;
    dateofBirth = _dateofBirth;
    sex = _sex;
    placeofBirth = _placeofBirth;
    currentAddress = _currentAddress;
  }
}
