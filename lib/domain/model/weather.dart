class Weather {
  Weather(
      {required double newTemp,
      required double newFeelsLike,
      required String newDescrp}) {
    temp = newTemp;
    feelsLike = newFeelsLike;
    descrp = newDescrp;
  }

  double _temp = 0;
  double get temp => this._temp;
   set temp(double newTemp) {
    _temp = newTemp;
  }

  double _feelsLike = 0;
  double get feelsLike => this._feelsLike;
   set feelsLike(double newFeelsLike) {
    _feelsLike = newFeelsLike;
  }

  String _descrp = "";
  String get descrp => this._descrp;
   set descrp(String newDescrp) {
    _descrp = newDescrp;
  }
}
