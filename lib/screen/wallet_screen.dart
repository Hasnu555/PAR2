import 'package:derviza_app/widgets/adwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:derviza_app/bloc/wallet/wallet_bloc.dart';
import 'package:derviza_app/bloc/wallet/wallet_event.dart';
import 'package:derviza_app/bloc/wallet/wallet_state.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet'),
      ),
      body: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          if (state is WalletLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WalletLoadedState) {
            return _buildLoadedState(context, state);
          } else {
            return Center(
              child: Text('Error loading wallet'),
            );
          }
        },
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, WalletLoadedState state) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 241, 228),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              padding: EdgeInsets.all(15.0),
              
              child: AdWidget(
                imageUrl: "https://tractorkarvan.com/storage/images/Blogs/what-is-agriculture-finance/Agricultural-Finance-Blog.jpg", 
                adLink: "https://www.freepik.com/free-photos-vectors/farm-banner"
                )
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.85,
              padding: EdgeInsets.all(15.0),
              
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF416422).withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                color: Color.fromARGB(255, 211, 238, 167),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Wallet Balance:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '\PKR ${state.balance.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Dispatch an event to add funds to the wallet
                          context.read<WalletBloc>().add(AddToWalletEvent(amount: 1000.0));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF416422),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text('Add (+\$1000)'),
                        ),
                      ),
                    ],
                  ), // Display payment details
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  
}
