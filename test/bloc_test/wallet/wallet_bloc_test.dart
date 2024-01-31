// import 'package:derviza_app/bloc/wallet/wallet_bloc.dart';
// import 'package:derviza_app/bloc/wallet/wallet_event.dart';
// import 'package:derviza_app/bloc/wallet/wallet_state.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:bloc_test/bloc_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'mock_wallet_repo.dart';

// void main() {
//   group('WalletBloc', () {
//     late MockWalletRepository mockWalletRepository;
//     WalletBloc walletBloc;

//     setUp(() {
//       mockWalletRepository = MockWalletRepository();
//       walletBloc = WalletBloc(walletRepository: mockWalletRepository);
//     });

//     tearDown(() {
//       walletBloc.close();
//     });

//     test('initial state is WalletLoadingState', () {
//       expect(walletBloc.state, equals(WalletLoadingState()));
//     });

//     blocTest<WalletBloc, WalletState>(
//       'emits [WalletLoadedState] when LoadWalletEvent is added',
//       build: () => walletBloc,
//       act: (bloc) => bloc.add(LoadWalletEvent()),
//       expect: () => [isA<WalletLoadedState>()],
//     );

//     blocTest<WalletBloc, WalletState>(
//       'emits [WalletLoadedState] with updated balance when AddToWalletEvent is added',
//       build: () => walletBloc,
//       act: (bloc) => bloc.add(AddToWalletEvent(amount: 100)),
//       expect: () => [isA<WalletLoadedState>()],
//     );

//     blocTest<WalletBloc, WalletState>(
//       'emits [WalletLoadedState] with updated balance when WithdrawFromWalletEvent is added',
//       build: () => walletBloc,
//       act: (bloc) => bloc.add(WithdrawFromWalletEvent(amount: 50)),
//       expect: () => [isA<WalletLoadedState>()],
//     );
//   });
// }
