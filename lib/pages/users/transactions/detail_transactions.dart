
import 'package:flutter/material.dart';
import 'package:project_akhir/models/transaction.dart';
import 'package:project_akhir/pages/users/transactions/payment_page.dart';
import 'package:project_akhir/pages/users/transactions/waiting_payment.dart';

class DetailTransactionPage extends StatefulWidget {
  final int id;

  const DetailTransactionPage({super.key, required this.id});

  @override
  State<DetailTransactionPage> createState() => _DetailTransactionPageState();
}

class _DetailTransactionPageState extends State<DetailTransactionPage> {

  Transactions? transaction;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTransaction();
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

  Widget _getButtonProceed(String? status) {
    switch (status) {
      case 'processed':
        return ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFD65A31)),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage(id: widget.id)));
          },
          child: const Text(
            'Proceed To Pay',
            style: TextStyle(color: Colors.white),
          ),
        );
      case 'waiting payment':
        return ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFD65A31)),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => WaitingPayment(id: widget.id)));
          },
          child: const Text(
            'See Payment',
            style: TextStyle(color: Colors.white),
          ),
        );
      default:
        return const SizedBox();
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
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Back'),
                  ),
                  _getButtonProceed(transaction!.status),
                ]
              )
            ]
          ),
        ),
      ),
    );
  }
}

