

import 'package:hw4/models/sport/basketball.dart';
import 'package:hw4/models/sport/soccer.dart';
import 'package:hw4/models/sport/sport_club.dart';

void taskFourExemple() {

  final gamesLine = SportsClub([Soccer(), Basketball()]);

  print('\n\n4. Create interface and impliment it:');
  
  gamesLine.playAllGames();
}