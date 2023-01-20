library core;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_chesslider_beta0/data/repositories/auth_repository_impl.dart';
import 'package:flutter_chesslider_beta0/data/repositories/game_repository_impl.dart';
import 'package:flutter_chesslider_beta0/data/repositories/rooms_repository_impl.dart';
import 'package:flutter_chesslider_beta0/domain/enums/team_enum.dart';
import 'package:flutter_chesslider_beta0/domain/repositories/auth_repository.dart';
import 'package:flutter_chesslider_beta0/domain/repositories/game_repository.dart';
import 'package:flutter_chesslider_beta0/domain/repositories/rooms_repository.dart';
import 'package:flutter_chesslider_beta0/presentation/game/states/board_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../../data/dto/figure/figure.dart';
import '../../data/dto/player/player.dart';
import '../../data/dto/room/room.dart';
import '../../data/dto/step/step.dart' as s;

part 'dependencies/app_dependencies.dart';

part 'app_logger/app_logger.dart';

part 'failure/failure.dart';
