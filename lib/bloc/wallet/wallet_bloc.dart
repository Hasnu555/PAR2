import 'package:bloc/bloc.dart';
import 'package:derviza_app/bloc/wallet/wallet_event.dart';
import 'package:derviza_app/bloc/wallet/wallet_state.dart';
import 'package:derviza_app/repository/wallet_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {



  final WalletRepository walletRepository = WalletRepository();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  WalletBloc() : super(WalletLoadingState()) {
    on<LoadWalletEvent>((event, emit) async {
      try {
        final user = _auth.currentUser;
        if (user != null) {
          final userId = user.uid;
          final balance = await walletRepository.getWalletBalance(userId);
          emit(WalletLoadedState(balance: balance));
        }
      } catch (e) {
        print("Error loading wallet: $e");
      }
    });

    on<AddToWalletEvent>((event, emit) async {
      try {
        final user = _auth.currentUser;
        if (user != null) {
          final userId = user.uid;
          await walletRepository.addToWallet(event.amount, userId);
          final updatedBalance = await walletRepository.getWalletBalance(userId);
          emit(WalletLoadedState(balance: updatedBalance));
        }
      } catch (e) {
        print("Error adding to wallet: $e");
      }
    });

    on<WithdrawFromWalletEvent>((event, emit) async {
      try {
        final user = _auth.currentUser;
        if (user != null) {
          final userId = user.uid;
          await walletRepository.withdrawFromWallet(event.amount, userId);
          final updatedBalance = await walletRepository.getWalletBalance(userId);
          emit(WalletLoadedState(balance: updatedBalance));
        }
      } catch (e) {
        print("Error withdrawing from wallet: $e");
      }
    });

    on<MakePaymentEvent>((event, emit) async {
  try {
    final user = _auth.currentUser;
    if (user != null) {
      final userId = user.uid;

      // Retrieve current wallet balance
      final currentBalance = await walletRepository.getWalletBalance(userId);

      // Check if the wallet balance is sufficient for the payment
      if (currentBalance >= event.amount) {
        // Sufficient balance, proceed with payment
        await walletRepository.withdrawFromWallet(event.amount, userId);
        final updatedBalance = await walletRepository.getWalletBalance(userId);
        emit(WalletLoadedState(balance: updatedBalance));
      } else {
        // Insufficient balance, emit an InsufficientBalanceState or handle it as needed
        print("Insufficient balance");
        // emit(InsufficientBalanceState());
      }
    }
  } catch (e) {
    print("Error making payment: $e");
  }
});


  }
}
