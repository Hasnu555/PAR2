import 'package:equatable/equatable.dart';

abstract class WalletState extends Equatable {
  const WalletState();
}

class WalletLoadingState extends WalletState {
  @override
  List<Object?> get props => [];
}

class WalletLoadedState extends WalletState {
  final double balance;

  WalletLoadedState({required this.balance});

  @override
  List<Object?> get props => [balance];
}
