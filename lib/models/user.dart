import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String login;
  final int id;
  final String avatarUrl;

  User({this.login, this.id, this.avatarUrl});
}