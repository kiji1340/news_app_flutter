abstract class DatabaseRepository<T> {
  Future<List<T>> getSavedArticles();
  Future<void> saveData(T data);
  Future<void>? removeData(T data);
}