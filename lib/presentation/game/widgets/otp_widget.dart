import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chesslider_beta0/domain/entities/room_entity.dart';
import 'package:get_it/get_it.dart';

class OtpWidget extends StatelessWidget {
  const OtpWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25),
      color: Colors.green,
      child: Text(
        GetIt.instance.get<List<RoomEntity>>().first.id,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
