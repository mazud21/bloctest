
import 'package:bloc_pattern/repositories/users_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/users_bloc.dart';
import 'bloc/users_event.dart';
import 'bloc/users_state.dart';
import 'models/user.dart';

class ViewUsersList extends StatefulWidget {
  final UsersRepository usersRepository;

  const ViewUsersList({Key key, this.usersRepository}) : super(key: key);

  @override
  _ViewUsersListState createState() => _ViewUsersListState();
}

class _ViewUsersListState extends State<ViewUsersList> {
  UsersBloc _usersBloc;

  @override
  void initState() {
    _usersBloc = UsersBloc(usersRepository: widget.usersRepository);
    _usersBloc.dispatch(FetchUsers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Users'),
      ),
      body: BlocBuilder<UsersBloc, UsersState>(
          bloc: _usersBloc,
          builder: (context, state) {
            if (state is UsersLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UsersLoaded) {
              return _buildListView(state.users);
            }
            if (state is UsersError) {
              return Center(
                child: Text('Error :('),
              );
            }
            return Container();
          }),
    );
  }

  ListView _buildListView(List<User> users) {
    return ListView.builder(
      itemBuilder: (context, i) {
        return ListTile(
          title: Text(users[i].login),
          subtitle: Text(users[i].id.toString()),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(30),
              child: Image.network(users[i].avatarUrl.toString())),
        );
      },
      itemCount: users.length,
    );
  }

  @override
  void dispose() {
    _usersBloc.dispose();
    super.dispose();
  }
}