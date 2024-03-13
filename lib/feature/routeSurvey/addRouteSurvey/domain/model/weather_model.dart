List<WeatherModel> weatherListResponse(var json) {
  return List<WeatherModel>.from(json.map((x) => WeatherModel.fromJson(x)));
}

class WeatherModel {
  dynamic id;
  String? name;
  WeatherModel({this.name, this.id});


  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      id: json['id'] ?? "",
      name: json['name'] ?? ""
    );
  }


  static getWeatherData() {
     List<WeatherModel> weatherList = [];
     weatherList.add(WeatherModel(
       id: "1",
       name: "Sunny"
       )
     );
     weatherList.add(WeatherModel(
         id: "2",
         name: "Cloudy"
     )
     );
     weatherList.add(WeatherModel(
         id: "3",
         name: "Rainy"
     )
     );
     return weatherList;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['value'] = "";
    return data;
  }
}