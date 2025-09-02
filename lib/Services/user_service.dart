import 'package:dio/dio.dart';
import 'package:rwad2/models/users.dart';

class UserService {
final dio = Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));

Future<List<Users>> getHttp() async {
  List<Users> users = [];
  try{
      final response = await dio.get('/users');
      print(response);
      List<dynamic> data = response.data;
      users = data.map((user)=>Users.fromJson(user)).toList();
  }
  catch(e){
    print(e);
  }
  return users;
}
}

