

import 'package:hw4/models/animal/duck.dart';
import 'package:hw4/models/animal/fish.dart';

void taskThreeExemple() {

  Fish salmon = Fish('Salmon', 5);
  Duck donald = Duck('Duck', 3);

  print('\n\n3. Create mixin swim :');

  salmon.swim();
  donald.swim();
}