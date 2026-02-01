class Home {
  int _id = 0;
  int get id => this._id;
   set id(int newId) {
    _id = newId;
  }

  String _location = "";
  String get location => this._location;
   set location(String newLocation) {
    _location = newLocation;
  }

  int _server = 0;
  int get server => this._server;
   set server(int newServer) {
    _server = newServer;
  }
}
