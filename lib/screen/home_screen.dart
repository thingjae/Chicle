import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chicle/providers/in_memory_database.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<InMemoryDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          _buildSectionTitle(context, 'Free Board'),
          _buildPostList(db.freeBoardPosts),
          _buildSectionTitle(context, 'Question Board'),
          _buildPostList(db.questionBoardPosts),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPostList(List<Map<String, String>> posts) {
    return Column(
      children: posts.map((post) => _buildPostCard(post)).toList(),
    );
  }

  Widget _buildPostCard(Map<String, String> post) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            post['imageUrl']!,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post['title']!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  post['content']!,
                  style: TextStyle(fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.0),
                Text(
                  'by ${post['author']}',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
