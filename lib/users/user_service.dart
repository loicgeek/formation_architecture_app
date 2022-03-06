import 'dart:developer';

import 'package:app_architecture/app/config.dart';
import 'package:app_architecture/users/models/post_model.dart';
import 'package:app_architecture/users/models/user_model.dart';
import 'package:dio/dio.dart';

class UserService {
  late Dio _dio;
  UserService() {
    _dio = Dio(BaseOptions(baseUrl: Config.apiUrl));
  }
  Future<List<UserModel>> findAllUsers() async {
    Response resp = await _dio.get("/users");
    List<UserModel> data =
        List<UserModel>.from(resp.data.map((user) => UserModel.fromJson(user)));
    return data;
  }

  Future<List<PostModel>> findPostsByUser(int userId) async {
    Response resp = await _dio.get("/users/$userId/posts");
    return List<PostModel>.from(
        resp.data.map((json) => PostModel.fromJson(json)));
  }

  findTodosByUser() {}
  addTodo() {}
  updateTodo() {}
  deleteTodo() {}
}
