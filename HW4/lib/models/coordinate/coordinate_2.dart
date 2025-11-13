
import 'package:equatable/equatable.dart';

class Coordinate2 extends Equatable{

  final double latitude;
  final double longitude;

  const Coordinate2(this.latitude, this.longitude);

  @override
  List<Object?> get props => [latitude, longitude];

  @override
  String toString() {
    return 'Coordinate2 (lat: $latitude, lon: $longitude)';
  }
}