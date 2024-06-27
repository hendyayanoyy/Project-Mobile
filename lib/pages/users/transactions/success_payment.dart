import 'package:flutter/material.dart';
import 'package:project_akhir/models/transaction.dart';

class SuccessPayment extends StatefulWidget {
  final int? id;
  const SuccessPayment({super.key, required this.id});

  @override
  State<SuccessPayment> createState() => _SuccessPaymentState();
}

class _SuccessPaymentState extends State<SuccessPayment> {
  Transactions? transaction;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTransaction();
  }

  Future<void> _fetchTransaction() async {
    try {
      Transactions? newTransaction = await Transactions.detailTransaction(widget.id!);

      setState(() {
        _isLoading = false;
        transaction = newTransaction;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success Payment'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Success Payment',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16.0),
            const Image(
              image: NetworkImage(
                'https://img.freepik.com/free-vector/successful-payment-concept-illustration_114360-1181.jpg?w=2000',
              ),
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Transaction Order: ${transaction!.codeTransaction}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Total: ${transaction!.total! + transaction!.payment!.bank!.adminFee!}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}