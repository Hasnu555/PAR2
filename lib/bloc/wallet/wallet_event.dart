import 'package:equatable/equatable.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();
}

class LoadWalletEvent extends WalletEvent {
  @override
  List<Object?> get props => [];
}

class AddToWalletEvent extends WalletEvent {
  final double amount;

  AddToWalletEvent({required this.amount});

  @override
  List<Object?> get props => [amount];
}

class WithdrawFromWalletEvent extends WalletEvent {
  final double amount;

  WithdrawFromWalletEvent({required this.amount});

  @override
  List<Object?> get props => [amount];
}

class MakePaymentEvent extends WalletEvent {
  final double amount;

  MakePaymentEvent({required this.amount});

  @override
  List<Object?> get props => [amount];
}
