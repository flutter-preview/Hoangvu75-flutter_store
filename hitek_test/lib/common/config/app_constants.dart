// ignore_for_file: constant_identifier_names


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const String API_HOST = "https://hitek-02.hitek.com.vn:7071";
const String API_PREFIX = "/api/v1";

const MethodChannel NATIVE_ANDROID_CHANNEL = MethodChannel("native_android_channel");
const MethodChannel NATIVE_IOS_CHANNEL = MethodChannel("native_ios_channel");
const String INTERNET_CONNECTION_METHOD = "internet_connection";
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
