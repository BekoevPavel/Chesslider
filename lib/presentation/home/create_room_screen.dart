import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/domain/entities/player_entity.dart';
import 'package:flutter_chesslider_beta0/presentation/auth/bloc/auth_state.dart';
import 'package:flutter_chesslider_beta0/presentation/home/bloc/home_event.dart';
import 'package:flutter_chesslider_beta0/presentation/router/app_router.dart';
import 'package:get_it/get_it.dart';

import 'bloc/home_bloc.dart';
import 'bloc/home_state.dart';

class CreateRoomScreen extends StatelessWidget {
  const CreateRoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myUser = GetIt.instance.get<List<PlayerEntity>>().first;
    print('myUser: ${myUser.username}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Играть с другом'),
      ),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.success && state.navigate == AuthNavigate.game) {
            context.replaceRoute(const GameRoute());
          }
        },
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  _dialogBuilder(context);
                },
                child: const Text('Создать комнату')),
            TextButton(onPressed: () {_dialogBuilderConnect(context);}, child: const Text('Присоединиться')),
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
                context.read<HomeBloc>().add(ConnectToRoom(_controller.text));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Создать комнату'),
          content: Column(
            children: [
              TextFormField(
                controller: _controller,
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Введите пин-код',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Введите свой пароль';
                  }
                  if (value.length < 5) {
                    return 'Слишком короткий пароль';
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
              child: const Text('Создать'),
              onPressed: () {
                context.read<HomeBloc>().add(HomeCreateRoom());
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
