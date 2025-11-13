

import 'package:hw4/interfaces/playable.dart';

class SportsClub {

  final List<Playable> sports;

  SportsClub(this.sports);

  void playAllGames() {
    print('\nOpen club...');
    print('Find teams...');
    print('Start games...');

    for (var spotrt in sports) {
      spotrt.play();
    }
  }
}