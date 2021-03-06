import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;


main(){

  getPlaces(39.683723, -75.749657, 'burgers');

}
class Place {
  final String name;
  final double rating;
  final String address;
  Place.fromJson(Map jsonMap):
        name = jsonMap['name'],
        rating = jsonMap['rating']?.toDouble() ?? -1.0,
        address = jsonMap['vicinity'];
  String toString() => 'Place: $name';
}
Future<Stream<Place>> getPlaces(double lat, double lng, String keyword) async {
  var url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json' +
      '?location=$lat,$lng'+
      '&radius=5000&type=restaurant'+
      '&keyword=$keyword'+
      '&key=AIzaSyAreZli1DQZU_gd0bRUKMYzXRBMFQVdKZo';

  /* http.get(url).then(
      (res) => print(res.body)
  );*/

  var client = new http.Client();
  var streamedRes = await client.send(
      new http.Request('get', Uri.parse(url))
  );

  return streamedRes.stream
      .transform(UTF8.decoder)
      .transform(JSON.decoder)
      .expand((jsonBody) => (jsonBody as Map) ['results'] )
      .map((jsonPlace) => new Place.fromJson(jsonPlace));
  /*.listen( (data) => print(data))
     .onDone( () => client.close());*/
}