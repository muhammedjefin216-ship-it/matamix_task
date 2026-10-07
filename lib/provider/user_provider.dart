import 'package:_matamixtask/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';


enum Status { loading, success, error }

class UserProvider extends ChangeNotifier {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com',
    connectTimeout: 
     Duration(seconds: 10),
    receiveTimeout: 
     Duration(seconds: 10),
  ));

  Status _status = Status.loading;
  List<User> _users = [];
  String _error = '';

  Status get status => _status;
  List<User> get users => _users;
  String get error => _error;

  Future<void> fetchUsers() async {
    _status = Status.loading;
    notifyListeners();
    try {
      final res = await _dio.get('/users');
      _users = (res.data as List)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList();
      _status = Status.success;
    } on DioException catch (e) {
      _error = _messageFor(e);
      _status = Status.error;
    } catch (_) {
      _error = 'Received unexpected data from the server.';
      _status = Status.error;
    }
    notifyListeners();
  }

  String _messageFor(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'The request timed out. Please try again.';
      case DioExceptionType.connectionError:
        return 'No internet connection.';
      case DioExceptionType.badResponse:
        return 'Server error (${e.response?.statusCode}).';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}