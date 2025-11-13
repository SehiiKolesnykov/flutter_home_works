

void demoList() {

  print('\n1. Work with List.\n');

  List<String> names = ['serhii', 'ivan', 'switlana', 'vasyl', 'oksana', 'fedir', 'alex', 'maria', 'diana'];
  print('Create list with names:');
  print(names);

  names.add('stepan');
  print("\nAdd stepan:");
  print(names);

  names.remove('fedir');
  print("\nRemove fedir:");
  print(names);

  names.sort();
  print("\nSorted List:");
  print(names);

  List<String> namesUpperFirstChar = names.map((name) => name.replaceFirstMapped(name[0], (m) => name[0].toUpperCase())).toList();
  print("\nCreat new List where each first character is upper case:");
  print(namesUpperFirstChar);
}
