

import 'package:hw4/models/coordinate/coordinate.dart';
import 'package:hw4/models/coordinate/coordinate_2.dart';

void taskFiveExemple() {

  print('\n\n5. Create Coordinate and Coordinate2 with equatable: ');

  _coordinateExemple();
  _coordinate2Exemple();

}

void _coordinateExemple() {

  Coordinate coor = Coordinate(10.0, 20.5);
  Coordinate coor2 = Coordinate(10.0, 20.5);
  Coordinate coor3 = Coordinate(10.0, 30.99);
  Coordinate coor4 = Coordinate(21.21, 20.5);
  Coordinate coor5 = Coordinate(99.99, 25.25);

  print('\n Coordinate test: \n');
  print('''
      Coor 1 = ${coor.toString()}
      Coor 2 = ${coor2.toString()}
      Coor 3 = ${coor3.toString()}
      Coor 4 = ${coor4.toString()}
      Coor 5 = ${coor5.toString()}
        ''');

  print('''
      Hash 1: ${coor.hashCode}
      Hash 2: ${coor.hashCode}
      Hash 3: ${coor.hashCode}
      Hash 4: ${coor.hashCode}
      Hash 5: ${coor.hashCode}
           ''');

  print('''
      Equals: 
      Coor 1 equals Coor 2 = ${coor == coor2}
      Coor 1 equals Coor 3 = ${coor == coor3}
      Coor 1 equals Coor 4 = ${coor == coor4}
      Coor 1 equals Coor 5 = ${coor == coor5}
          ''');
}

void _coordinate2Exemple() {

  Coordinate2 coor = Coordinate2(10.0, 20.5);
  Coordinate2 coor2 = Coordinate2(10.0, 20.5);
  Coordinate2 coor3 = Coordinate2(10.0, 30.99);
  Coordinate2 coor4 = Coordinate2(21.21, 20.5);
  Coordinate2 coor5 = Coordinate2(99.99, 25.25);

  print('\n Coordinate2 test: \n');
  print('''
      Coor 1 = ${coor.toString()}
      Coor 2 = ${coor2.toString()}
      Coor 3 = ${coor3.toString()}
      Coor 4 = ${coor4.toString()}
      Coor 5 = ${coor5.toString()}
        ''');

  print('''
      Hash 1: ${coor.hashCode}
      Hash 2: ${coor.hashCode}
      Hash 3: ${coor.hashCode}
      Hash 4: ${coor.hashCode}
      Hash 5: ${coor.hashCode}
           ''');

  print('''
      Equals: 
      Coor 1 equals Coor 2 = ${coor == coor2}
      Coor 1 equals Coor 3 = ${coor == coor3}
      Coor 1 equals Coor 4 = ${coor == coor4}
      Coor 1 equals Coor 5 = ${coor == coor5}
          ''');
}