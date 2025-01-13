import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class BookApiService {
  // Google Books API 키를 추가
  final String _apiKey = 'AIzaSyCQUGlolcKxr9r-Nc_c4STOwjJoqJ1u5Sw'; // 여기에 생성한 API 키를 넣으세요

  // 검색어에 따라 책 데이터를 받아오는 메서드
  Future<List<Book>> fetchBookData(String query, {int startIndex = 0}) async {
    final url =
        'https://www.googleapis.com/books/v1/volumes?q=$query&langRestrict=ko&startIndex=$startIndex&maxResults=10&orderBy=relevance&key=$_apiKey'; // API 키 추가
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final items = data['items'] as List<dynamic>?;

      if (items == null) {
        return [];
      }

      return items.map((item) => Book.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}
