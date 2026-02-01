class Device {
  int _id = 0;
  int get id => this._id;
  set id(int newId) {
    _id = newId;
  }

  String _type = "";
  String get type => this._type;
  set type(String newType) {
    _type = newType;
  }

  double _value = 0;
  double get value => this._value;
  set value(double newValue) {
    _value = newValue;
  }

  double _voltage = 0;
  double get voltage => this._voltage;
  set voltage(double newVoltage) {
    _voltage = newVoltage;
  }

  bool _state = false;
  bool get state => this._state;
  set state(bool newState) {
    _state = newState;
  }

  String _room = "";
  String get room => this._room;
  set room(String newRoom) {
    _room = newRoom;
  }

  String _MAC = "";
  String get MAC => this._MAC;
  set MAC(String newMAC) {
    _MAC = newMAC;
  }
}
