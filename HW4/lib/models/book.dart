

class Book {

  final String name;
  final String author;
  final int year;

  Book(this.name, this.author, this.year);

  void displayInfo() {
    print('\nBook: \'$name\', Author: \'$author\', Year: \'$year\'');
  }
}