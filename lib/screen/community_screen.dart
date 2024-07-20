import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chicle/providers/in_memory_database.dart';

class CommunityScreen extends StatelessWidget {
  final String boardType;

  CommunityScreen({required this.boardType});

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<InMemoryDatabase>(context);
    final posts = boardType == 'Free Board'
        ? db.freeBoardPosts
        : db.questionBoardPosts;

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
              subtitle: Text(post['content'] ?? '내용 미리보기'),
              trailing: Text(post['author'] ?? '글쓴이'),
              isThreeLine: true,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewPostScreen(boardType: boardType)),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'New Post',
      ),
    );
  }
}

class NewPostScreen extends StatelessWidget {
  final String boardType;

  NewPostScreen({required this.boardType});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<InMemoryDatabase>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: authorController,
              decoration: InputDecoration(
                labelText: 'Author',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: contentController,
              decoration: InputDecoration(
                labelText: 'Content',
              ),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final post = {
                  'title': titleController.text,
                  'author': authorController.text,
                  'content': contentController.text,
                  'imageUrl': 'https://via.placeholder.com/150',
                };
                db.addPost(boardType, post);
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
