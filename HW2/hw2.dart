import 'dart:io';
import 'dart:math';


void main() {

mainMenu();

}

void mainMenu() {
  print('''

  Choose a task: 

  1. Grade converter
  2. Guess the number
  3. Factorial
  4. Temperature converter
  5. Calculator

  0. Exit

    ''');

    String prompt = "Enter option number 0-5   ";
    String errorMessage = 'Error: you entered %d, no such option \n';

    int choosedOption = validRangeOption(0, 5, prompt, errorMessage);
    
    switch (choosedOption) {
      case 0 : exitProgram();
      case 1 : gradeConverter();
      case 2 : guessNumber();
      case 3 : factorial();
      case 4 : temperatureConverter();
      case 5 : calculator();
    }

}

int enterNumber(String prompt) {

  int? number;

  while(true) {

    stdout.write(prompt);
  
    String? entered = stdin.readLineSync();

    if (entered == null || entered.isEmpty) {
      print('Error: nothing entered!\n');
      continue;
    }

    number = int.tryParse(entered);

    if (number == null) {
      print('Error: "$entered" is not a number!\n');
      continue;
    }

    break;
  }

  return number;
}

int validRangeOption (int min, int max, String prompt, String errorMessage) {

int number;

while(true) {

      number = enterNumber(prompt);

      if (number < min || number > max) {
        print(errorMessage.replaceAll('%d', number.toString()));
        continue;
      }

      break;
    }

    return number;
}

void exitProgram() {
  print('\n Goodbye!\n');
  exit(0);
}

void endTaskMenu (void currentTask()) {
  
  print('''

  1. Try again;
  2. Back to main menu;

  0. Exit the program; 

        ''');

  String prompt = "Enter option number 0-2   ";
  String errorMessage = 'Error: you entered %d, no such option \n';

  int choosedOption = validRangeOption(0, 2, prompt, errorMessage);

  switch (choosedOption) {
      case 0 : exitProgram();
      case 1 : currentTask();
      case 2 : mainMenu();
    }
}

void gradeConverter() {

  print('\nGrade Converter\n');

  String explanation = 'Enter grade from 0 to 100   ';
  String errorMessage = 'Error: you entered %d, must be between 0 - 100 \n';

  int points = validRangeOption(0, 100, explanation, errorMessage);

  String grade;

  if      ( points >= 90 ) grade = 'A';
  else if ( points >= 80 ) grade = 'B';
  else if ( points >= 70 ) grade = 'C';
  else if ( points >= 60 ) grade = 'D';
  else                     grade = 'F';


  print('\n Your points = $points , your grade = "$grade"\n' );
  
  endTaskMenu(gradeConverter);
}

void guessNumber() {

  print('\nGuess the number\n');

  int secretNumber = Random().nextInt(100) + 1;

  String prompt = 'Enter a number from 1 to 100   ';
  String errorMessage = 'Error: you entered %d, must be between 1 - 100 \n';
  
  int enteredNumber = validRangeOption(1, 100, prompt, errorMessage);
  List allNumbers = [];

  while(true){

    if (secretNumber != enteredNumber) {

      allNumbers.add(enteredNumber);
      String allNumbersToString = allNumbers.toString();

      if (secretNumber > enteredNumber) {
        print("\nYou didn't guess!\nThe entered number is less than secret. Try again!\nYou previously entered : $allNumbersToString .\n");
      } else {
        print("\nYou didn't guess!\nThe entered number is greater than secret. Try again!\nYou previously entered : $allNumbersToString .\n");
      }

      enteredNumber = validRangeOption(1, 100, prompt, errorMessage);

      continue;
    }

    break;
  }

  print('\nYou guessed!!! Secret number is $enteredNumber');

  endTaskMenu(guessNumber);

}

void factorial () {

  print('\nFactorial\n');

  String prompt = 'Enter a number from 1 to 20   ';
  String errorMessage = 'Error: you entered %d, must be between 1 - 20 \n';
  
  int enteredNumber = validRangeOption(1, 20, prompt, errorMessage);
  
  int result = _factorial(enteredNumber);

  print('\nThe factorial of $enteredNumber is $result.\n');

  endTaskMenu(factorial);
}

int _factorial(int number) {

  if (number < 0) {
    print('\nThe factorial of a negative number is undefined\n');
    return 0;
  } if (number <= 1 ) return 1;

  return number * _factorial(number - 1);
}

void temperatureConverter() {

  print('\nTemperature converter\n');

  String promptTemperature = 'Enter the temperature   ';

  double temperature = askDouble(promptTemperature);
  double result = 0;
  String unitsFrom = '°C';
  String unitsTo = '°C';

  print('''
            1. Celsius to Fahrenheit.
            2. Fahrenheit to Celsius.

            ''');

  String prompt = "Enter option number 1 or 2   ";
  String errorMessage = 'Error: you entered %d, no such option \n';

  int choosedOption = validRangeOption(1, 2, prompt, errorMessage);

  switch (choosedOption) {
      case 1 : {
        result = celsiusToFahrenheit(temperature);
        unitsFrom = '°C';
        unitsTo = '°F';
      };
      case 2 : {
        result = fahrenheitToCelsius(temperature);
        unitsFrom = '°F';
        unitsTo = '°C';
      };
    }

  print("\n $temperature $unitsFrom = $result $unitsTo");

  endTaskMenu(temperatureConverter);
}

double askDouble(String prompt) {

  while(true) {

    stdout.write(prompt);

    String? input = stdin.readLineSync();

    if(input == null || input.trim().isEmpty){
      print('\nError: nothing entered\n');
      continue;
    }

    double? value = double.tryParse(input.trim());

    if (value == 0) {
      print('\nError: "$input" is not a valid number!\n');
      continue;
    };

    return value!;
  }
}

double celsiusToFahrenheit(double celsius) {
  return celsius * 9/5 + 32;
}

double fahrenheitToCelsius(double fahrenheit) {
  return (fahrenheit - 32) * 5/9;
}

void calculator() {

  print('\nCalculator\n');

  String firstNumPrompt = '\n Enter your first number:   ';

  int firstNumber = enterNumber(firstNumPrompt);

  String secondNumPrompt = '\n Enter your second number:   ';

  int secondNumber = enterNumber(secondNumPrompt);

  String operationPrompt = 'Enter operation. Use + or - or * or /   ';

  String operation = askOperation(operationPrompt);

  dynamic result;

  switch (operation) {
    case ('+') : result = add(firstNumber, secondNumber);
    case ('-') : result = subtract(firstNumber, secondNumber);
    case ("*") : result = multiply(firstNumber, secondNumber);
    case ('/') : {
      if (secondNumber == 0) {
        result = 'not possible';
        print('\nError: division by 0 is not possible!');
      }

      result = divide(firstNumber, secondNumber);
    }
  }

  print('\nResult: $firstNumber $operation $secondNumber = $result\n');

  endTaskMenu(calculator);
}

String askOperation(prompt) {

  while(true) {
    stdout.write(prompt);

    String? input = stdin.readLineSync();

    if (input == null || input.trim().isEmpty ) {
      print('\nError: nothing entered\n');
      continue;
    }

    String operation = input.trim();

    if (operation == '+' || operation == '-' || operation == '*' || operation == '/') {
      return operation;
    }

    print('\nError: invalid operation! Use + or - or * or /');
  }
} 

int add (int firstNumber, int secondNumber) {
  return firstNumber + secondNumber;
}

int subtract (int firstNumber, int secondNumber) {
  return firstNumber - secondNumber;
}

int multiply (int firstNumber, int secondNumber) {
  return firstNumber * secondNumber;
}

double divide (int firstNumber, int secondNumber) {
  return firstNumber / secondNumber;
}