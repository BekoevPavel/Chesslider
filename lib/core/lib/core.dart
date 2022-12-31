library core;

import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_chesslider_beta0/data/repositories/auth_repository_impl.dart';
import 'package:flutter_chesslider_beta0/domain/entities/step_entity.dart';
import 'package:flutter_chesslider_beta0/domain/enums/team_enum.dart';
import 'package:flutter_chesslider_beta0/domain/repositories/auth_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../../domain/entities/figure_entity.dart';

part 'dependencies/app_dependencies.dart';
part 'app_logger/app_logger.dart';
part 'failure/failure.dart';
