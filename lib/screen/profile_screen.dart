import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:chicle/providers/in_memory_database.dart';

class ProfileScreen extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<InMemoryDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Screen'),
      ),
      body: db.isLoggedIn ? _buildProfileScreen(context, db) : _buildLoginScreen(context),
    );
  }

  Widget _buildLoginScreen(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          try {
            await _googleSignIn.signIn();
            // 로그인 성공 시 상태 업데이트
            Provider.of<InMemoryDatabase>(context, listen: false).logIn();
          } catch (error) {
            print(error);
          }
        },
        child: Text('Login with Google'),
      ),
    );
  }

  Widget _buildProfileScreen(BuildContext context, InMemoryDatabase db) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(db.userProfileImageUrl ?? 'https://via.placeholder.com/150'),
        ),
        SizedBox(height: 16),
        Text('User Name', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Email: user@example.com', style: TextStyle(fontSize: 16)),
        SizedBox(height: 16),
        _buildSectionTitle('Authentication Level'),
        Text(db.authenticationLevel ?? 'N/A', style: TextStyle(fontSize: 16)),
        SizedBox(height: 16),
        _buildSectionTitle('My Posts'),
        _buildMyPostsList(db.myPosts),
        SizedBox(height: 16),
        _buildSectionTitle('My Comments'),
        _buildMyCommentsList(db.myComments),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            _googleSignIn.signOut();
            db.logOut();
          },
          child: Text('Logout'),
        ),
        SizedBox(height: 16),
        _buildSectionTitle('Settings'),
        ListTile(
          title: Text('Language'),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            // 언어 설정 화면으로 이동
          },
        ),
        ListTile(
          title: Text('Region'),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            // 지역 설정 화면으로 이동
          },
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildMyPostsList(List<Map<String, String>> posts) {
    return Column(
      children: posts.map((post) {
        return ListTile(
          title: Text(post['title'] ?? 'Untitled'),
          subtitle: Text(post['content'] ?? 'No content'),
        );
      }).toList(),
    );
  }

  Widget _buildMyCommentsList(List<Map<String, String>> comments) {
    return Column(
      children: comments.map((comment) {
        return ListTile(
          title: Text(comment['comment'] ?? 'No comment'),
        );
      }).toList(),
    );
  }
}
