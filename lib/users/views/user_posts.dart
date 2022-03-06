import 'package:app_architecture/users/models/post_model.dart';
import 'package:app_architecture/users/models/user_model.dart';
import 'package:app_architecture/users/user_service.dart';
import 'package:flutter/material.dart';

class UserPosts extends StatefulWidget {
  final UserModel user;
  const UserPosts({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<UserPosts> createState() => _UserPostsState();

  static route(UserModel user) =>
      MaterialPageRoute(builder: (context) => UserPosts(user: user));
}

class _UserPostsState extends State<UserPosts> {
  late Future<List<PostModel>> _postsFuture;
  late UserService _userService;
  late UserModel user;

  @override
  void initState() {
    _userService = UserService();
    user = widget.user;
    _postsFuture = _userService.findPostsByUser(user.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts by ${user.name}"),
      ),
      body: FutureBuilder<List<PostModel>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              var error = snapshot.error;
              return Center(
                child: SingleChildScrollView(
                  child: Text(
                    error.toString(),
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            } else {
              var posts = snapshot.data!;
              return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    var post = posts[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(post.title),
                              ],
                            ),
                            Divider(),
                            Container(
                              child: Text(post.body),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
          }

          return Container();
        },
      ),
    );
  }
}
