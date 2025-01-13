import 'package:bookjuckboojuck/screens/main_screen.dart';
import 'package:flutter/material.dart';
import '../services/book_api_service.dart';
import '../models/book.dart';

class SearchBook extends StatefulWidget {
  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<SearchBook> {
  final BookApiService _apiService = BookApiService();
  List<Book> books = [];

  void fetchBooks(String query) async {
    try {
      final fetchedBooks = await _apiService.fetchBookData(query);
      setState(() {
        books = fetchedBooks;
      });
    } catch (e) {
      print('Error fetching books: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '검색하기',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(),
                      ));
                },
                icon: Icon(Icons.arrow_back),
              ),
            ],
          )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: fetchBooks,
              decoration: InputDecoration(
                labelText: 'Search for books',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return ListTile(
                  leading: book.imageUrl.isNotEmpty
                      ? Image.network(book.imageUrl,
                          width: 50, fit: BoxFit.cover)
                      : Icon(Icons.book, size: 50),
                  title: Text(book.title),
                  subtitle: Text(book.authors.isNotEmpty
                      ? book.authors.join(', ')
                      : 'Unknown author'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
