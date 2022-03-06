import 'dart:developer';

import 'package:app_architecture/app/config.dart';
import 'package:app_architecture/users/models/user_model.dart';
import 'package:app_architecture/users/user_service.dart';
import 'package:app_architecture/users/views/user_posts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();

  static route() => MaterialPageRoute(builder: (context) => const UsersList());
}

class _UsersListState extends State<UsersList> {
  late UserService _userService;
  // List<UserModel>? usersList;

  late Future<List<UserModel>> _usersFuture;
  // String? error;
  @override
  void initState() {
    _userService = UserService();
    _usersFuture = _userService.findAllUsers();
    // _usersFuture.then((value) {
    //   usersList = value;
    //   setState(() {});
    // }).catchError((e) {
    //   if (e is DioError) {
    //     error = e.message;
    //   } else {
    //     error = e.toString();
    //   }

    //   setState(() {});
    //   log(e.toString());
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          log(snapshot.connectionState.toString());
          if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            log(snapshot.data.toString());
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
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var user = snapshot.data![index];
                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Row(
                            children: [
                              Expanded(child: Text(user.name)),
                              Text('${user.address.city}')
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user.phone),
                              Text("Company: ${user.company.name}"),
                            ],
                          ),
                          isThreeLine: true,
                        ),
                        const Divider(
                          height: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(UserPosts.route(user));
                                },
                                child: Container(
                                  color: Colors.grey.withOpacity(.3),
                                  padding: const EdgeInsets.all(8),
                                  child: const Text(
                                    "Posts",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 10,
                              width: 3,
                              color: Colors.white,
                            ),
                            Expanded(
                              child: InkWell(
                                child: Container(
                                  color: Colors.grey.withOpacity(.3),
                                  padding: const EdgeInsets.all(8),
                                  child: const Text(
                                    "Todos",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          }
          return Container();
        },
      ),
      // body: error != null
      //     ? Center(
      //         child: SingleChildScrollView(
      //           child: Text(
      //             error!,
      //             style: TextStyle(
      //               color: Colors.red,
      //               fontSize: 16,
      //             ),
      //           ),
      //         ),
      //       )
      //     : usersList == null
      //         ? const Center(
      //             child: CircularProgressIndicator(),
      //           )
      //         : ListView.builder(
      //   itemCount: usersList!.length,
      //   itemBuilder: (context, index) {
      //     var user = usersList![index];
      //     return ListTile(
      //       title: Text(user.name),
      //       subtitle: Text(user.phone),
      //     );
      //   },
      // ),
    );
  }
}
