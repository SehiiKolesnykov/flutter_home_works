

class Coordinate {
  final double latitude;
  final double longitude;

  Coordinate(this.latitude, this.longitude);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Coordinate &&
    other.latitude == latitude &&
    other.longitude == longitude;
  }

  @override
  
  int get hashCode => Object.hash(latitude,longitude);

  @override
  String toString() {
    
    return 'Coordinate (lat: $latitude, lon: $longitude)';
  }
}