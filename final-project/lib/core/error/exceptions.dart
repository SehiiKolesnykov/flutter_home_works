
/// Винятки, які можуть виникнути під час роботи з даними.
/// Використовуються для чіткої ідентифікації помилок у репозиторіях та use cases.

/// Виняток для помилок сервера (API повернув 4xx/5xx або іншу помилку)
class ServerException implements Exception {}

/// Виняток для проблем з кешем (наприклад, немає даних у Hive)
class CacheException implements Exception {}

/// Виняток для відсутності інтернету
class NetworkException implements Exception {}