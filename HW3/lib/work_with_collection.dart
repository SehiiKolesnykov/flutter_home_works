import 'package:collection/collection.dart';

void demoCollection() {

  print('\n\n4. Work with Collection.\n');

  Map<String, int> studentsPerformance =  {
   'Оля'      : 85,
   'Максим'   : 90,
   'Сергій'   : 95,
   'Світлана' : 100,
   'Василь'   : 85,
   'Олександр': 85,
   'Марія'    : 90,
   'Анжела'   : 90,
   'Софія'    : 95,
   'Марк'     : 100
   };

  print('Create map with key = names, value = points:');
  studentsPerformance.forEach((key, value){
    print('"$key: $value"');
  });

  var groupedByPoints = groupBy(studentsPerformance.entries, (entry) => entry.value);
  print("\nGrouped collection by points:");
  groupedByPoints.forEach((points, students) {
    print('$points : ${students.map((e) => e.key).toList()}');
  });
}