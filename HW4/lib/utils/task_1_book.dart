
import 'package:hw4/models/Book.dart';

void taskOneExemple() {

  Book harryPotter_1 = Book('Harry Potter and the Philosopher\'s Stone', 'J. K. Rowling', 1997);
  Book theLordOfTheRings = Book('The Lord of the Rings', 'J. R. R. Tolkien', 1968);
  Book theShining = Book("The Shining", 'Stephen King', 1977);

  print('\n1. Create class Book : ');
  harryPotter_1.displayInfo();
  theLordOfTheRings.displayInfo();
  theShining.displayInfo();
}