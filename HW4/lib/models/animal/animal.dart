

class Animal {

  final String species;
  int age;

  Animal(this.species, this.age);

  Animal.newBorn(this.species) : age = 0;

  void setAge(int age) {
    this.age = age;
  }

  bool isAdult() {
    return age >= 2;
  }

  @override
  String toString() {
    
    return '\n$species, Age: $age years, (${isAdult() ? "adult" : "young"})';
  }
}