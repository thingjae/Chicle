import 'package:flutter/material.dart';

class InMemoryDatabase extends ChangeNotifier {
  List<Map<String, String>> freeBoardPosts = [
    {
      'title': 'First Free Post',
      'content': 'This is a preview of the first free post content.',
      'author': 'User1',
      'imageUrl': 'https://via.placeholder.com/150'
    },
    {
      'title': 'Second Free Post',
      'content': 'This is a preview of the second free post content.',
      'author': 'User2',
      'imageUrl': 'https://via.placeholder.com/150'
    },
    {
      'title': 'Third Free Post',
      'content': 'This is a preview of the third free post content.',
      'author': 'User3',
      'imageUrl': 'https://via.placeholder.com/150'
    },
  ];

  List<Map<String, String>> questionBoardPosts = [
    {
      'title': 'First Question Post',
      'content': 'This is a preview of the first question post content.',
      'author': 'User4',
      'imageUrl': 'https://via.placeholder.com/150'
    },
    {
      'title': 'Second Question Post',
      'content': 'This is a preview of the second question post content.',
      'author': 'User5',
      'imageUrl': 'https://via.placeholder.com/150'
    },
    {
      'title': 'Third Question Post',
      'content': 'This is a preview of the third question post content.',
      'author': 'User6',
      'imageUrl': 'https://via.placeholder.com/150'
    },
  ];

  void addPost(String boardType, Map<String, String> post) {
    if (boardType == 'Free Board') {
      freeBoardPosts.add(post);
    } else if (boardType == 'Question Board') {
      questionBoardPosts.add(post);
    }
    notifyListeners();
  }
}
