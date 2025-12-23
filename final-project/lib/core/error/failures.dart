/// Абстрактний клас Failure — базовий для всіх помилок у додатку.
/// Використовується з dartz (Either<Failure, Success>) для функціональної обробки помилок.

abstract class Failure {
  final String message;
  Failure(this.message);
}

/// Помилка сервера (наприклад, API не відповідає або 500)
class ServerFailure extends Failure {
  ServerFailure() : super('Помилка сервера');
}

/// Помилка кешу — немає локальних даних
class CacheFailure extends Failure {
  CacheFailure() : super('Немає кешованих даних');
}

/// Помилка мережі — немає інтернету
class NetworkFailure extends Failure {
  NetworkFailure() : super('Немає підключення до інтернету');
}

/// Пояснення: використання Failure + dartz дозволяє:
/// - повертати помилку як значення (а не кидати виняток)
/// - обробляти помилки в UI (показувати повідомлення)