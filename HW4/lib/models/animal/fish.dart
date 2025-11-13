

import 'package:hw4/mixins/swimming.dart';
import 'package:hw4/models/animal/animal.dart';

class Fish extends Animal with Swimming {

  Fish(super.species, super.age);

  Fish.newBorn(super.species) : super.newBorn();


}