import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/core/lib/core.dart';
import 'package:flutter_chesslider_beta0/presentation/auth/bloc/auth_state.dart';
import 'package:flutter_chesslider_beta0/presentation/home/bloc/home_event.dart';
import 'package:flutter_chesslider_beta0/presentation/router/app_router.dart';

import 'bloc/home_bloc.dart';
import 'bloc/home_state.dart';

class CreateRoomScreen extends StatelessWidget {
  const CreateRoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myUser = AppDependencies().getMyPlayer();
    print('myUser: ${myUser.username}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Играть с другом'),
      ),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          print('state: $state');
          if (state.success && state.navigate == AuthNavigate.game) {
            context.replaceRoute(
                GameRoute(myTeam: state.team, gameType: state.gameType));
            print('переход к игре');
          }
        },
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  // _dialogBuilder(context);
                  context.read<HomeBloc>().add(HomeCreateRoom());
                },
                child: const Text('Создать комнату')),
            TextButton(
                onPressed: () {
                  _dialogBuilderConnect(context);
                },
                child: const Text('Присоединиться')),
          ],
        ),
      ),
    );
  }

  Future<void> _dialogBuilderConnect(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Присоединиться к игре'),
          content: Column(
            children: [
              TextFormField(
                controller: _controller,
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Введите код комнаты',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Введите код комнаты';
                  }

                  return null;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Присоединиться'),
              onPressed: () {
                Navigator.of(context).pop();

                context.read<HomeBloc>().add(ConnectToRoom(_controller.text));
              },
            ),
          ],
        );
      },
    );
  }
}
