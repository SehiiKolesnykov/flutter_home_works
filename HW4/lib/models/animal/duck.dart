

import 'package:hw4/mixins/swimming.dart';
import 'package:hw4/models/animal/animal.dart';

class Duck extends Animal with Swimming {

  Duck(super.species, super.age);

  Duck.newBorn(super.species) : super.newBorn();


}