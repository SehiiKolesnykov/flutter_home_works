

import 'package:hw4/models/animal/animal.dart';

void taskTwoExemple() {

  Animal cat = Animal('Cat', 5);
  Animal kitty = Animal.newBorn("Cat");
  Animal dog = Animal("Dog", 1);
  Animal bird = Animal("Bird", 2);

  print('\n\n2. Create class Animal and method isAdult: ');
  print(cat.toString());
  print(kitty.toString());
  print(dog.toString());
  print(bird.toString());
}