import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/models/post.dart';

void main() {
  test('Created Post should have appropriate proeprty values', () {
    final date = DateTime.now();
    const url = 'www.test.com';
    const quantity = 2;
    const latitude = 1.0;
    const longitude = 2.0;

    final food_waste_post = Post(
      dateTime: date,
      photoUrl: url,
      numLeftoverItems: quantity,
      latitude: latitude,
      longitude: longitude
    );

    expect(food_waste_post.dateTime, date);
    expect(food_waste_post.photoUrl, url);
    expect(food_waste_post.numLeftoverItems, quantity);
    expect(food_waste_post.latitude, latitude);
    expect(food_waste_post.longitude, longitude);
  });

  test('Post latitude and longitude are valid types', () {
    final date = DateTime.now();
    const url = 'www.test.com';
    const quantity = 2;
    const latitude = 1.0;
    const longitude = 2.0;

    final food_waste_post = Post(
      dateTime: date,
      photoUrl: url,
      numLeftoverItems: quantity,
      latitude: latitude,
      longitude: longitude
    );

    expect(food_waste_post.latitude.runtimeType, double);
    expect(food_waste_post.longitude.runtimeType, double);
  });

}
