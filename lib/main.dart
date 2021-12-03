import 'package:bloc_pattern/view_user_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bloc_pattern/repositories/repositories.dart';

main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UsersRepository usersRepository = UsersRepository(
      usersApiClient: UsersApiClient(httpClient: http.Client()),
    );
    return MaterialApp(
      title: 'Github Users Bloc',
      home: ViewUsersList(
        usersRepository: usersRepository,
      ),
    );
  }
}
