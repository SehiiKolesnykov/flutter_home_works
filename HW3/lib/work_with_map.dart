

void demoMap() {

  print('\n\n3. Work with Map.\n');

  Map<String, int> studentsPerformance =  {
   'Оля': 85,
   'Максим': 90
   };
  print('Create map with key = names, value = points:');
  studentsPerformance.forEach((key, value){
    print('"$key: $value"');
  });


  studentsPerformance['Сергій'] = 95;
  print("\nAdd new pair 'Сергій' : 95 to studentsPerformance: ");
  studentsPerformance.forEach((key, value){
    print('"$key: $value"');
  });

  studentsPerformance['Оля'] = 100;
  print("\nChange Olga's points to 100");
  studentsPerformance.forEach((key, value){
    print('"$key: $value"');
  });

  studentsPerformance.remove('Максим');
  print("\nRemove Max");
  studentsPerformance.forEach((key, value){
    print('"$key: $value"');
  });
}