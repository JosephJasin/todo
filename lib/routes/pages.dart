library pages;

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:animations/animations.dart';

import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';

import 'package:provider/provider.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../appDatabase.dart';
import '../controlNotification.dart';

import '../models/notes.dart';
import '../models/settings.dart';

part 'homePage.dart';
part 'notePage.dart';
part 'editNotePage.dart';
part 'settingsPage.dart';
part 'helpPage.dart';

const whiteGreyColor = Color(0xFFf0f2f5);
const redColor = const Color(0xffFF0057);
const yellowColor = const Color(0xffFFE600);
const greenColor = const Color(0xff00FF80);
