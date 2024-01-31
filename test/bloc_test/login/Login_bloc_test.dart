import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:derviza_app/bloc/login/login_bloc.dart';
import 'package:derviza_app/bloc/login/login_event.dart';
import 'package:derviza_app/bloc/login/login_state.dart';

import 'mockrepo.dart';

void main() {
  group('LoginBloc', () {
    late MockLoginRepository mockLoginRepository;
    late LoginBloc loginBloc;

    setUp(() {
      mockLoginRepository = MockLoginRepository();
      loginBloc = LoginBloc(mockLoginRepository);
    });

    blocTest<LoginBloc, LoginState>(
  'emits [LoginLoading, LoginSuccess] when LoginWithEmailAndPassword is added.',
  build: () => loginBloc,
  act: (bloc) => bloc.add(LoginWithEmailAndPassword(email: 'hasnu@gmail.com', password: '123456')),
  expect: () => [LoginLoading(), LoginSuccess()],
);


    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginFailure] when LoginWithEmailAndPassword is added with wrong credentials.',
      build: () => loginBloc,
      act: (bloc) => bloc.add(LoginWithEmailAndPassword(email: 'invalid@example.com', password: 'wrongpassword')),
      expect: () => [LoginLoading(), isA<LoginFailure>()],
    );


    blocTest<LoginBloc, LoginState>(
      'emits [LoginInitial] when Logout is added.',
      build: () => loginBloc,
      act: (bloc) => bloc.add(Logout()),
      expect: () => [LoginInitial()],
    );

    tearDown(() {
      loginBloc.close();
    });
  });
}
