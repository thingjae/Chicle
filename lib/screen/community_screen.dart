import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  final String boardType;

  CommunityScreen({required this.boardType});

  final List<Map<String, String>> posts = [
    {'number': '1', 'title': 'First Post', 'author': 'User1'},
    {'number': '2', 'title': 'Second Post', 'author': 'User2'},
    {'number': '3', 'title': 'Third Post', 'author': 'User3'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$boardType'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            child: ListTile(
              leading: FlutterLogo(size: 63),
              title: Text(post['title'] ?? '제목'),
              subtitle: Text('내용 미리보기'),
              trailing: Text(post['author'] ?? '글쓴이'),
              isThreeLine: true,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 글 작성 화면으로 이동
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewPostScreen()),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'New Post',
      ),
    );
  }
}

class NewPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Author',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Content',
              ),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // 글 작성 완료 로직
                Navigator.pop(context);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
