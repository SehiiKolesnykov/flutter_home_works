

void demoSet() {

  print('\n\n2. Work with Set.\n');

  Set<int> num = {1, 3, 5, 7};
  Set<int> num2 =  {3, 5, 8, 10};

  print('Create two sets with numbers:');
  print('num = $num, num2 = $num2');

  Set<int> unionSet = num.union(num2);
  print('\nUnion two sets:');
  print(unionSet);

  Set<int> differenceSet = num.difference(num2);
  print('\nFind difference:');
  print(differenceSet);

  Set<int> intersectionSet = num.intersection(num2);
  print('\nFind intercection:');
  print(intersectionSet);
}