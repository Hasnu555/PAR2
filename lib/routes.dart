import 'package:derviza_app/screen/cart_screen.dart';
import 'package:derviza_app/screen/payment_screen.dart';
import 'package:derviza_app/screen/product_screen.dart';
import 'package:derviza_app/screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:derviza_app/screen/article_list.dart';
import 'package:derviza_app/screen/edit_user_screen.dart';
import 'package:derviza_app/screen/product_list.dart';
import 'package:derviza_app/screen/expert_list.dart';
import 'package:derviza_app/screen/login_screen.dart';
import 'package:derviza_app/screen/wallet_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/login': (BuildContext context) => LoginPage(),
  '/wallet': (BuildContext context) => WalletPage(),
  '/articles': (BuildContext context) => ArticleView(),
  '/editProfile': (BuildContext context) => EditProfilePage(),
  '/experts': (BuildContext context) => ExpertListPage(),
  '/products': (BuildContext context) => ProductListPage(),
  '/payment': (BuildContext context) => PaymentPage(),
  '/siginup': (BuildContext context) => Signup(),
  '/cart': (BuildContext context) => CartPage(),
  };
