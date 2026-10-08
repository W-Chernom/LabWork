import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Вспомогательный класс для хранения данных о книге
class Book {
  final String title;
  final String author;
  final String imageUrl;

  Book({
    required this.title,
    required this.author,
    required this.imageUrl,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Онлайн Библиотека',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Давыдов Максим Денисович ПИбд-32'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Создаем список наших книг (Тема: Онлайн-библиотека)
  final List<Book> _books = [
    Book(
      title: 'Грокаем алгоритмы',
      author: 'Адитья Бхаргава',
      imageUrl: 'https://ir.ozone.ru/s3/multimedia-2/6408065942.jpg',
    ),
    Book(
      title: 'Властелин Колец',
      author: 'Дж. Р. Р. Толкин',
      imageUrl: 'https://i.playground.ru/e/lE5y1NhFhXC4SbSHDCWssg.png',
    ),
    Book(
      title: 'Убийство в Восточном экспрессе',
      author: 'Агата Кристи',
      imageUrl: 'https://imo10.labirint.ru/books/612211/cover.jpg/484-0',
    ),
    Book(
      title: 'Краткая история времени',
      author: 'Стивен Хокинг',
      imageUrl: 'https://imo10.labirint.ru/books/597534/cover.jpg/484-0',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // ListView.builder - виджет для создания прокручиваемых списков.
      // Он ленивый: строит только те карточки, которые видны на экране.
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0), // Отступы по краям списка
        itemCount: _books.length, // Количество элементов в списке
        itemBuilder: (BuildContext context, int index) {
          final book = _books[index]; // Берем конкретную книгу
          // Card - виджет карточки (с тенями и скругленными углами)
          return Card(
            elevation: 4.0, // Тень под карточкой
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            // Row выстраивает элементы в строку: слева картинка, справа текст
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Картинка
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: Image.network(
                    book.imageUrl,
                    width: 100,
                    height: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const SizedBox(
                      width: 100,
                      height: 150,
                      child: Placeholder(),
                    ),
                  ),
                ),

                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    // Column выстраивает текст в колонку
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Текст: Название книги
                        Text(
                          book.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0), // Отступ между строками
                        // Текст: Автор
                        Text(
                          book.author,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700], // Делаем цвет автора чуть тусклее
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
