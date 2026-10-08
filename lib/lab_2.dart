import 'dart:async';
enum BookGenre { fantasy, science, detective, education }

// 7. Extension (Расширения)
// Расширяем стандартный класс String.
// Добавим метод, который будет автоматически оборачивать строку в них.
extension StringTypography on String {
  String inQuotes() {
    return '«$this»';
  }
}

// 1. Классы с полями и методами
// Класс, описывающий конкретную книгу в библиотеке
class Book {
  String title;
  String author;
  BookGenre genre;
  bool isAvailable;

  // Конструктор
  Book(this.title, this.author, this.genre, {this.isAvailable = true});

  // Методы класса
  void borrowBook() {
    if (isAvailable) {
      isAvailable = false;
      print("Вы успешно взяли книгу ${title.inQuotes()}.");
    } else {
      print("Книга ${title.inQuotes()} сейчас читается кем-то другим.");
    }
  }

  void returnBook() {
    isAvailable = true;
    print("Книга ${title.inQuotes()} возвращена в библиотеку.");
  }

  @override
  String toString() {
    String status = isAvailable ? "В наличии" : "Выдана";
    return "${title.inQuotes()} — $author (Жанр: ${genre.name}) [$status]";
  }
}

// Класс для управления онлайн-библиотекой
class OnlineLibrary {

  // 4. Generics (Дженерики)
  List<Book> catalog = [];

  // 6. Future (Асинхронность)
  // Имитируем загрузку каталога книг с сервера базы данных библиотеки
  Future<void> loadCatalog() async {
    print("Подключение к серверу библиотеки...");

    // Имитация сетевой задержки (скачивание данных) в 1 секунду
    await Future.delayed(Duration(seconds: 1));

    catalog.add(Book("Властелин Колец", "Дж. Р. Р. Толкин", BookGenre.fantasy));
    catalog.add(Book("Краткая история времени", "Стивен Хокинг", BookGenre.science));
    catalog.add(Book("Убийство в Восточном экспрессе", "Агата Кристи", BookGenre.detective));
    catalog.add(Book("Грокаем алгоритмы", "Адитья Бхаргава", BookGenre.education));

    print("Каталог книг успешно загружен!\n");
  }

  void printCatalog() {
    print("=== ПОЛНЫЙ КАТАЛОГ КНИГ ===");
    // 3. Loops (Циклы)
    for (int i = 0; i < catalog.length; i++) {
      print("${i + 1}. ${catalog[i].toString()}");
    }
    print("===========================\n");
  }

  void printAvailableBooks() {
    print("=== ДОСТУПНЫЕ ДЛЯ ЧТЕНИЯ КНИГИ ===");
    // 5. Anonymous functions (Анонимные функции)
    // Функция (book) => book.isAvailable передается в метод where
    // без имени, прямо по месту использования, для фильтрации списка.
    var availableBooks = catalog.where((book) => book.isAvailable).toList();

    for (var book in availableBooks) {
      print(book.toString());
    }
    print("==================================\n");
  }
}

// Точка входа в программу. Делаем её async из-за использования await
void main() async {
  OnlineLibrary myLibrary = OnlineLibrary();

  await myLibrary.loadCatalog();

  myLibrary.printCatalog();

  print("-> Действия пользователя:");
  myLibrary.catalog[0].borrowBook();
  myLibrary.catalog[3].borrowBook();
  print("");

  myLibrary.printAvailableBooks();

  // Еще один пример анонимной функции через forEach
  print("Быстрая проверка статуса образовательной литературы:");
  myLibrary.catalog
      .where((b) => b.genre == BookGenre.education)
      .forEach((b) {
    print("- ${b.title.inQuotes()}: ${b.isAvailable ? 'Можно читать' : 'На руках у пользователя'}");
  });
}