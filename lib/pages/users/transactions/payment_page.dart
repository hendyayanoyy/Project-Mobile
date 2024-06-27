import 'package:flutter/material.dart';
import 'package:project_akhir/models/banks.dart';
import 'package:project_akhir/models/payment.dart';
import 'package:project_akhir/models/transaction.dart';
import 'package:project_akhir/pages/users/transactions/waiting_payment.dart';

class PaymentPage extends StatefulWidget {
  final int id;

  const PaymentPage({Key? key, required this.id}) : super(key: key);
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Transactions? transaction;
  List<Banks> banks = [];
  bool _isLoading = true;

  // State
  int? bankId = 0;

  @override
  void initState() {
    super.initState();
    _fetchTransaction();
    _fetchBanks();
  }

  Future<void> _fetchTransaction() async {
    try {
      Transactions? newTransaction = await Transactions.detailTransaction(widget.id);

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

  Future<void> _fetchBanks() async {
    try {
      List<Banks> newBanks = await Banks.getBanks();
      setState(() {
        banks = newBanks;
      });
    } catch (e) {
      print(e);
    }
  }

  Future <void> _processPayment() async {
    try {
      bool result = await Payment.createPayment(transaction!.total, transaction!.memberId, transaction!.id, bankId);
      if (result) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => WaitingPayment(id: transaction!.id)));
      }
    } catch(e) {
      print(e);
    }
  }

  Color _getColors(String? status) {
    switch (status) {
      case 'completed':
        return Colors.green;
      case 'processed':
        return Colors.yellow;
      case 'cancelled':
        return Colors.red;
      case 'failed':
        return Colors.red.shade700;
      case 'waiting payment':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Transaction'),
      ),
      body: _isLoading ? const Center(child: CircularProgressIndicator()) : SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Order ID: ${transaction!.codeTransaction}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const Spacer(flex: 1,),
                        Badge(
                          smallSize: 12,
                          label: Text(
                            transaction!.status.toString(),
                          ),
                          backgroundColor: _getColors(transaction!.status),
                        )
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Total: ${transaction!.total}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Status: ${transaction!.status}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const Divider(),
                    Column(
                      children: transaction!.detail!.map(
                        (detail) => ListTile(
                          leading: Image(
                            image: NetworkImage(detail.book!.image),
                          ),
                          title: Text(detail.book!.title),
                          subtitle: Text('${detail.quantity} x Rp. ${detail.price}'),
                        )
                      ).toList(),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Choose Payment Method',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Column(
                      children: banks!.map(
                        (bank) => RadioListTile(
                          title: Text('${bank.name}'),
                          value: bank.id,
                          groupValue: bankId,
                          onChanged: (value) {
                            setState(() {
                              bankId = value;
                            });
                          },
                        ), 
                      ).toList(),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _processPayment();
                    },
                    child: const Text('Pay'),
                  ),
                ]
              )
            ]
          ),
        ),
      ),
    );
  }
}