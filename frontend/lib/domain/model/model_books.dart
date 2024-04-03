import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:http/http.dart' as http;

class BookModel extends ChangeNotifier {
  final UserProvider userProvider;

  BookModel(this.userProvider);

  List<dynamic> books = [];
  List<dynamic> currentBooks = [];
  Book nowBook = Book(bookId: 1, isPay: false, path: "", price: 0, title: "");
  BookPage nowPage = BookPage(
    bookPageId: 0,
    bookImagePath: "",
    page: 0,
    content: "",
    bookPageSentences: [BookPageSentences(bookPageSentenceId: 0, sequence: 0, sentence: "", sentenceSoundPath: "")],
  );
  Map BookDetail = {};
  Education nowEducation = Education(educationId: 0, gubun: "", wordName: "", imagePath: "", bookSentenceId: 0);
  List<Education> educations = [];
  List<Progress> progresses = [Progress(bookId: 1, isDone: false)];
  List bookCovers = [];

  int currentBookId = 1;

  void setNowReview(double score, String content) {
    nowBook.myReview?["score"] = score;
    nowBook.myReview?["content"] = content;

    notifyListeners();
  }

  Future<void> setCurrentBookId(int currentBookId) async {
    this.currentBookId = currentBookId;
    await getCurrentBookPurchase(userProvider.getAccessToken(), currentBookId);

    notifyListeners();
  }

  /// 동화책 전체 조회
  Future<String> getAllBooks(String accessToken) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/books");
    final headers = {'Content-Type': 'application/json', "Authorization": "Bearer $accessToken"};
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      books = json.decode(utf8.decode(response.bodyBytes));
      notifyListeners();
      return "Success";
    } else if (response.statusCode == 401) {
      userProvider.refreshToken();
      return getAllBooks(userProvider.getAccessToken());
    } else {
      String msg = json.decode(utf8.decode(response.bodyBytes))['data_header']['result_message'];
      return msg;
    }
  }

  /// 진행 중인 책 조회 (마이페이지)
  Future<String> getCurrentBooks(String accessToken) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/books/my-books");
    final headers = {'Content-Type': 'application/json', "Authorization": "Bearer $accessToken"};
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      currentBooks = json.decode(utf8.decode(response.bodyBytes));
      return "Success";
    } else if (response.statusCode == 401) {
      userProvider.refreshToken();
      return getCurrentBooks(userProvider.getAccessToken());
    } else {
      String msg = json.decode(utf8.decode(response.bodyBytes))['data_header']['result_message'];
      return msg;
    }
  }

  /// 동화책 단일 조회 (동화책 결제)
  Future<String> getCurrentBookPurchase(String accessToken, int bookId) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/books/$bookId/purchase");
    final headers = {'Content-Type': 'application/json', "Authorization": "Bearer $accessToken"};
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      nowBook = Book.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      progresses.add(Progress(bookId: bookId, isDone: false));
      return "Success";
    } else if (response.statusCode == 401) {
      userProvider.refreshToken();
      return getCurrentBookPurchase(userProvider.getAccessToken(), bookId);
    } else {
      String msg = json.decode(utf8.decode(response.bodyBytes))['data_header']['result_message'];
      return msg;
    }
  }

  /// 동화책 단일 조회 (메인 페이지 동화책 클릭)
  Future<String> getBookDetail(String accessToken, int bookId) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/books/$bookId");
    final headers = {'Content-Type': 'application/json', "Authorization": "Bearer $accessToken"};
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      BookDetail = json.decode(utf8.decode(response.bodyBytes));
      return "Success";
    } else if (response.statusCode == 401) {
      userProvider.refreshToken();
      return getBookDetail(userProvider.getAccessToken(), bookId);
    } else {
      String msg = json.decode(utf8.decode(response.bodyBytes))['data_header']['result_message'];
      return msg;
    }
  }

  ///동화책 페이지 조회
  Future<String> getBookPage(String accessToken, int bookId, int pageId) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/books/$bookId/pages/$pageId");
    final headers = {'Content-Type': 'application/json', "Authorization": "Bearer $accessToken"};
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      nowPage = BookPage.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      nowEducation =
          nowPage.education ?? Education(educationId: 0, gubun: "", wordName: "", imagePath: "", bookSentenceId: 0);
      return "Success";
    } else if (response.statusCode == 401) {
      userProvider.refreshToken();
      return getBookPage(userProvider.getAccessToken(), bookId, pageId);
    } else {
      String msg = json.decode(utf8.decode(response.bodyBytes))['data_header']['result_message'];
      return msg;
    }
  }

  ///진행중인 책 페이지 저장
  Future<String> setBookPage(String accessToken, int bookId, int pageId) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/books/$bookId/pages/$pageId");
    final headers = {'Content-Type': 'application/json', "Authorization": "Bearer $accessToken"};
    var response = await http.post(url, headers: headers);

    if (response.statusCode == 200) {
      return "Success";
    } else if (response.statusCode == 401) {
      userProvider.refreshToken();
      return setBookPage(userProvider.getAccessToken(), bookId, pageId);
    } else {
      String msg = json.decode(utf8.decode(response.bodyBytes))['data_header']['result_message'];
      return msg;
    }
  }

  ///유저가 그린 그림(그림, 행동, 표정) 저장
  Future<String> saveEducationImage(String accessToken, int educationId, File actionImage) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/users/educations/$educationId");

    var request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = "Bearer $accessToken"
      ..files.add(await http.MultipartFile.fromPath('userActionImage', actionImage.path));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return "Success";
    } else if (response.statusCode == 401) {
      userProvider.refreshToken();
      return saveEducationImage(userProvider.getAccessToken(), educationId, actionImage);
    } else {
      String msg = json.decode(utf8.decode(response.bodyBytes))['data_header']['result_message'];
      return msg;
    }
  }

  ///isRead 여부 저장
  Future<String> setIsRead(String accessToken, int bookId) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/books/$bookId/is-read");
    final headers = {'Content-Type': 'application/json', "Authorization": "Bearer $accessToken"};
    var response = await http.post(url, headers: headers);

    if (response.statusCode == 200) {
      return "Success";
    } else if (response.statusCode == 401) {
      userProvider.refreshToken();
      return setIsRead(userProvider.getAccessToken(), bookId);
    } else {
      String msg = json.decode(utf8.decode(response.bodyBytes))['data_header']['result_message'];
      return msg;
    }
  }

  /// 앱 실행시 동화책 표지 이미지 불러오기
  Future<List> getBookCovers() async {
    var url = Uri.https("j10c101.p.ssafy.io", "/api/books/cover-images");
    final headers = {'Content-Type': 'application/json'};
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      String msg = json.decode(utf8.decode(response.bodyBytes))['data_header']['result_message'];
      debugPrint(msg);
      return [];
    }
  }
}

class Book {
  final int bookId;
  final String title;
  final String? summary;
  final String path;
  final int? price;
  final int? page;
  final int? totalPage;
  final bool? isPay;
  final bool? isRead;
  final double? averageScore;
  final List<dynamic>? reviews;
  final Map<String, dynamic>? myReview;

  Book({
    required this.bookId,
    required this.title,
    this.summary,
    required this.path,
    required this.price,
    this.page,
    this.totalPage,
    this.isRead,
    required this.isPay,
    this.averageScore,
    this.reviews,
    this.myReview,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      bookId: json['bookId'],
      title: json['title'],
      summary: json['summary'],
      path: json['coverPath'],
      page: json['processPage'],
      totalPage: json['totalPage'],
      price: json['price'],
      isPay: json['isPay'],
      isRead: json['isRead'],
      averageScore: json['averageScore'],
      myReview: json['myBookReview'],
      reviews: json["bookReviews"],
    );
  }
}

class BookPage {
  final int bookPageId;
  final String bookImagePath;
  final int page;
  final String content;
  final List<BookPageSentences> bookPageSentences;
  final Education? education;

  BookPage({
    required this.bookPageId,
    required this.bookImagePath,
    required this.page,
    required this.content,
    required this.bookPageSentences,
    this.education,
  });

  factory BookPage.fromJson(Map<String, dynamic> json) {
    var sentencesList = json['bookPageSentences'] as List<dynamic>;
    List<BookPageSentences> sentences = sentencesList.map((dynamic item) => BookPageSentences.fromJson(item)).toList();

    Education? education;
    if (json['education'] != null) {
      education = Education.fromJson(json['education']);
    }

    return BookPage(
      bookPageId: json['bookPageId'],
      bookImagePath: json['bookImagePath'],
      page: json['page'],
      content: json['content'],
      bookPageSentences: sentences,
      education: education,
    );
  }
}

class BookPageSentences {
  final int bookPageSentenceId;
  final int sequence;
  final String sentence;
  final String sentenceSoundPath;

  BookPageSentences({
    required this.bookPageSentenceId,
    required this.sequence,
    required this.sentence,
    required this.sentenceSoundPath,
  });

  factory BookPageSentences.fromJson(Map<String, dynamic> json) {
    return BookPageSentences(
        bookPageSentenceId: json['bookPageSentenceId'],
        sequence: json['sequence'],
        sentence: json['sentence'],
        sentenceSoundPath: json['sentenceSoundPath']);
  }
}

class Education {
  final int educationId;
  final String? gubun;
  final String? category;
  final String wordName;
  final String imagePath;
  final int? bookSentenceId;
  String? traceImagePath;

  Education({
    required this.educationId,
    this.gubun,
    this.category,
    required this.wordName,
    required this.imagePath,
    this.bookSentenceId,
    this.traceImagePath,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      educationId: json['educationId'],
      gubun: json['gubun'],
      category: json['category'],
      wordName: json['wordName'],
      imagePath: json['imagePath'],
      bookSentenceId: json['bookPageSentenceId'],
      traceImagePath: json['traceImagePath'],
    );
  }
}

class Progress {
  final int bookId;
  bool isDone;

  Progress({
    required this.bookId,
    required this.isDone,
  });
}
