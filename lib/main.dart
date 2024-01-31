import 'package:derviza_app/bloc/article/article_bloc.dart';
import 'package:derviza_app/bloc/cart/cart_bloc.dart';
import 'package:derviza_app/bloc/expert/expert_bloc.dart';
import 'package:derviza_app/bloc/login/login_bloc.dart';
import 'package:derviza_app/bloc/login/login_repo.dart';
import 'package:derviza_app/bloc/product/product_bloc.dart';
import 'package:derviza_app/bloc/product/product_event.dart';
import 'package:derviza_app/bloc/wallet/wallet_bloc.dart';
import 'package:derviza_app/bloc/wallet/wallet_event.dart';
import 'package:derviza_app/model/article.dart';
import 'package:derviza_app/model/expert.dart';
import 'package:derviza_app/model/product.dart';
import 'package:derviza_app/routes.dart';
import 'package:derviza_app/screen/article_card.dart';
import 'package:derviza_app/screen/expert_screen.dart';
import 'package:derviza_app/screen/product_list.dart';
import 'package:derviza_app/repository/expert_repo.dart';
import 'package:derviza_app/repository/product_repo.dart';
import 'package:derviza_app/screen/article_list.dart';
import 'package:derviza_app/screen/charts_screen.dart';
import 'package:derviza_app/screen/expert_list.dart';
import 'package:derviza_app/screen/login_screen.dart';

import 'package:derviza_app/bloc/crops/crops_bloc.dart';
import 'package:derviza_app/repository/app_state.dart';
import 'package:derviza_app/repository/firebase_options.dart';
import 'package:derviza_app/screen/Home.dart';
import 'package:derviza_app/screen/product_screen.dart';
import 'package:derviza_app/widgets/productcard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:derviza_app/repository/article_repo.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ApplicationState()),
        BlocProvider(create: (context) => WalletBloc()..add(LoadWalletEvent())),
          
        BlocProvider<CartBloc>(create: (context) => CartBloc()),
        
        BlocProvider<ArticleBloc>(
          create: (context) => ArticleBloc(FirestoreService()),
        ),
        BlocProvider<CropsBloc>(create: (context) => CropsBloc()),
        BlocProvider<ProductBloc>(create: (context) => ProductBloc(ProductFirestoreService())),
        
        BlocProvider<ExpertBloc>(create: (context) => ExpertBloc(ExpertFirestoreService())),
        BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(LoginRepository()),
      ),
         
      ],
      child: const MyApp(),
    ),
  );
}





class MyApp extends StatelessWidget {
  const MyApp({super.key});


  
  @override
  Widget build(BuildContext context) {
    final lightTheme = ThemeData(
      colorScheme: ColorScheme.light(
        primary: Colors.white,
        background:
            Color(0xFF155751), // Set background color to white for light theme
      ),
      useMaterial3: true,
      brightness: Brightness.light, // Set brightness to light
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFF598216), // Set appbar background color to white
        foregroundColor: Colors.white, // Set appbar text color to black
      ),
      scaffoldBackgroundColor:
          Colors.white, // Set scaffold background color to white
      primaryTextTheme: TextTheme(
        
        headlineMedium: TextStyle(
          color: Color(0xFF598216), 
          fontSize: 30,
          fontStyle: FontStyle.normal,
        ),
        bodyMedium: TextStyle(
          color: Colors.white, // Set text color to grey for light theme
          fontSize: 16,
        ),
        bodySmall: TextStyle(
          color: Colors.white, // Set text color to grey for light theme
          fontSize: 16,
        ),
      ),
      iconTheme: IconThemeData(
        color: Color(0xFF598216), // Set icon color to grey for light theme
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white, // Set text field background color to white
        hintStyle: TextStyle(
          color: Color(0xFF598216),
          backgroundColor: Colors.white,
        ),
        labelStyle: TextStyle(
          color: Color(0xFF598216),
          backgroundColor: Colors.white,
        ),
        
      ),
      
    );
    



    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
      // home :   const list(),
      // home: const ButtonWidget(),  
      routes: routes,
       onGenerateRoute: (settings) {
        if (settings.name == '/productPage') {
          final Product product = settings.arguments as Product;
          return MaterialPageRoute(
            builder: (context) => ProductPage(product: product),
          );
        } else if(settings.name == '/expertsPage'){
          final Expert expert = settings.arguments as Expert;
          return MaterialPageRoute(
            builder: (context) => ExpertProfilePage(expert: expert),
          );
        } else if(settings.name == '/articlecard'){
          final Article article = settings.arguments as Article;
          return MaterialPageRoute(
            builder: (context) => ArticleListItem(article: article),
          );
        }
       }
    );
  }
}

