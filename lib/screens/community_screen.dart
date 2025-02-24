import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  List<Map<String, dynamic>> _posts = [];
  String _sortCriterion = 'latest'; // 정렬 기준: 'latest', 'popular', 'likes'

  @override
  void initState() {
    super.initState();
    _loadPosts();
    _addInitialPosts(); // 초기 게시물 추가
  }

  void _addInitialPosts() {
    // 초기 게시물 목록
    _addNewPost('나는 AI의 신이다', '내가 누군지는 모르겠지만 너네는 날 이길 수 없다', '양지민');
    _addNewPost('gang', '추승주');
    _addNewPost('최애의 아이를 추천합니다', '아이짱 이뻐요', '김채환');
  }

  Future<void> _loadPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPosts = prefs.getString('posts');
    if (savedPosts != null) {
      setState(() {
        _posts = List<Map<String, dynamic>>.from(json.decode(savedPosts));
      });
    }
  }

  Future<void> _savePosts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('posts', json.encode(_posts));
  }

  void _addNewPost(String title, String content, String author) {
    setState(() {
      _posts.add({
        'title': title,
        'content': content,
        'author': author,
        'likes': 0,
        'timestamp': DateTime.now().millisecondsSinceEpoch
      });
    });
    _savePosts();
  }

  void _editPost(int index, String title, String content) {
    setState(() {
      _posts[index]['title'] = title;
      _posts[index]['content'] = content;
    });
    _savePosts();
  }

  void _likePost(int index) {
    setState(() {
      _posts[index]['likes']++;
    });
    _savePosts();
  }

  void _setSortCriterion(String criterion) {
    setState(() {
      _sortCriterion = criterion;
      _sortPosts();
    });
  }

  void _sortPosts() {
    switch (_sortCriterion) {
      case 'latest':
        _posts.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));
        break;
      case 'popular':
        _posts.sort((a, b) => b['likes'].compareTo(a['likes']));
        break;
      case 'likes':
        _posts.sort((a, b) => b['likes'].compareTo(a['likes']));
        break;
    }
  }

  void _navigateToPostCreation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostCreationScreen(onPostCreated: _addNewPost),
      ),
    );
  }

  void _navigateToPostEdit(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostEditScreen(
          post: _posts[index],
          onPostEdited: (title, content) => _editPost(index, title, content),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          '커뮤니티',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: _setSortCriterion,
            itemBuilder: (context) => [
              PopupMenuItem(value: 'latest', child: Text('최신순')),
              PopupMenuItem(value: 'popular', child: Text('인기순')),
              PopupMenuItem(value: 'likes', child: Text('좋아요순')),
            ],
          )
        ],
      ),
      body: _posts.isEmpty
          ? Center(
              child: Text(
                '게시글이 없습니다.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                final post = _posts[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  color: Colors.white,
                  // 배경색을 흰색으로 변경
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Icon(
                        Icons.person,
                        color: Colors.blue.shade600,
                      ),
                    ),
                    title: Text(
                      post['title'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('작성자: ${post['author']}'),
                        Text(
                          post['content'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.thumb_up),
                      onPressed: () => _likePost(index),
                      color: Colors.blue,
                    ),
                    onTap: () => _navigateToPostEdit(index),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToPostCreation,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class PostCreationScreen extends StatefulWidget {
  final Function(String, String, String) onPostCreated;

  const PostCreationScreen({super.key, required this.onPostCreated});

  @override
  State<PostCreationScreen> createState() => _PostCreationScreenState();
}

class _PostCreationScreenState extends State<PostCreationScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  void _submitPost() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();
    final author = _authorController.text.trim();

    if (title.isNotEmpty && content.isNotEmpty && author.isNotEmpty) {
      widget.onPostCreated(title, content, author);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          '새 게시글 작성',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: '제목',
                labelStyle: TextStyle(color: Colors.grey.shade600),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(
                labelText: '작성자',
                labelStyle: TextStyle(color: Colors.grey.shade600),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: '내용',
                labelStyle: TextStyle(color: Colors.grey.shade600),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitPost,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                '게시글 추가',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostEditScreen extends StatefulWidget {
  final Map<String, dynamic> post;
  final Function(String, String) onPostEdited;

  const PostEditScreen({
    super.key,
    required this.post,
    required this.onPostEdited,
  });

  @override
  State<PostEditScreen> createState() => _PostEditScreenState();
}

class _PostEditScreenState extends State<PostEditScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post['title']);
    _contentController = TextEditingController(text: widget.post['content']);
  }

  void _submitEdit() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isNotEmpty && content.isNotEmpty) {
      widget.onPostEdited(title, content);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          '게시글 수정',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: '제목',
                labelStyle: TextStyle(color: Colors.grey.shade600),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: '내용',
                labelStyle: TextStyle(color: Colors.grey.shade600),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitEdit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                '수정 완료',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
