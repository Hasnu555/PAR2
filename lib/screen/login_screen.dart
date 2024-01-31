import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:derviza_app/bloc/login/login_bloc.dart';
import 'package:derviza_app/bloc/login/login_event.dart';
import 'package:derviza_app/bloc/login/login_state.dart';
import 'package:derviza_app/screen/signup_screen.dart';
import 'package:derviza_app/screen/Home.dart'; // Import your Home page

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _animation;
  
  late AnimationController _textAnimationController;
  late Animation<double> _textAnimation;

  late AnimationController _positionAnimationController;
  late Animation<double> _positionAnimation;

  late AnimationController _fadeAnimationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 360).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
      
    _textAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _textAnimation = Tween<double>(begin: 0, end: 1).animate(_textAnimationController)
      ..addListener(() {
        setState(() {});
      });

    _textAnimationController.forward();

    _positionAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _positionAnimation = Tween<double>(begin: 50, end: 0).animate(
      CurvedAnimation(
        parent: _positionAnimationController,
        curve: Curves.easeOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _fadeAnimationController.forward();
        }
      });

    _fadeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _fadeAnimationController,
        curve: Curves.easeIn,
      ),
    );

    _positionAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4F5E2),
      resizeToAvoidBottomInset: true,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Transform.rotate(
                                    angle: _animation.value * 3.14159 / 180,
                                    child: Icon(
                                      Icons.eco,
                                      size: 50,
                                      color: Color(0xFF416422),
                                    ),
                                  ),
                                  AnimatedBuilder(
                                    animation: _positionAnimation,
                                    builder: (context, child) {
                                      return Transform.translate(
                                        offset: Offset(0, _positionAnimation.value),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Opacity(
                                              opacity: _fadeAnimation.value,
                                              child: Text(
                                                'PAR',
                                                style: TextStyle(
                                                  color: Color(0xFF416422),
                                                  fontSize: 50,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Opacity(
                                              opacity: 1 - _fadeAnimation.value,
                                              child: Text(
                                                'Pakistan Agriculture Research',
                                                style: TextStyle(
                                                  color: Color(0xFF416422),
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Log In',
                                  style: TextStyle(
                                    color: Color(0xFF416422),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextField(
                                controller: usernameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xFF416422)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xFF416422)),
                                    ),
                                    labelText: "Email",
                                    labelStyle: TextStyle(
                                      color: Color(0xFF416422),
                                    ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xFF416422)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xFF416422)),
                                    ),
                                    labelText: "Password",
                                    labelStyle: TextStyle(
                                      color: Color(0xFF416422),
                                    ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Container(
                                width: 350,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<LoginBloc>(context).add(
                                      LoginWithEmailAndPassword(
                                        email: usernameController.text,
                                        password: passwordController.text,
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF416422),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                  ),
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      // Handle Facebook login
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF3b5998),
                                    ),
                                    icon: Icon(Icons.facebook),
                                    label: Text("Facebook"),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      // Trigger Google login event with Bloc
                                      // BlocProvider.of<LoginBloc>(context).add(
                                      //   LoginWithGoogle(),
                                      // );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF4285F4),
                                    ),
                                    icon: Icon(Icons.g_mobiledata),
                                    label: Text("Google"),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                   "/siginup",
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Don't have an account? ",
                                        style: TextStyle(
                                          color: Color(0xFF416422),
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        "Sign Up",
                                        style: TextStyle(
                                          color: Color(0xFF416422),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                        color: Color(0xFF416422),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    _textAnimationController.dispose();
    _positionAnimationController.dispose();
    _fadeAnimationController.dispose();
    super.dispose();
  }
}
