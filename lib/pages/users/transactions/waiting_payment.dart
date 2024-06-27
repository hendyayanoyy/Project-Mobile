import 'package:flutter/material.dart';
import 'package:project_akhir/models/transaction.dart';
import 'package:project_akhir/pages/users/dashboard_user.dart';

class WaitingPayment extends StatefulWidget {
  final int? id;
  const WaitingPayment({super.key, required this.id});

  @override
  State<WaitingPayment> createState() => _WaitingPaymentState();
}

class _WaitingPaymentState extends State<WaitingPayment> {
  Transactions? transaction;

  @override
  void initState() {
    super.initState();
    _fetchTransaction();
  }

  Future<void> _fetchTransaction() async {
    try {
      Transactions? newTransaction = await Transactions.detailTransaction(widget.id!);

      setState(() {
        transaction = newTransaction;
      });
    } catch (e) {
      setState(() {
        transaction = null;
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waiting Payment'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ 
                  Text(
                    transaction!.payment!.numberVirtual!,
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD65A31),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    "Number Virtual"
                  )
                ]
              ),
              const SizedBox(height: 24.0),
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
                        const Text(
                          'Order ID: ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(flex: 1,),
                        Text(
                          '${transaction!.codeTransaction}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
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
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Text(
                          'Total: ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(flex: 1,),
                        Text(
                          'Rp. ${transaction!.total}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        const Text(
                          'Admin Fee: ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(flex: 1,),
                        Text(
                          'Rp. ${transaction!.payment!.bank!.adminFee!}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        const Text(
                          'Grand Total: ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(flex: 1,),
                        Text(
                          'Rp. ${transaction!.total! + transaction!.payment!.bank!.adminFee!}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFD65A31)),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardUser()));
                },
                child: const Text(
                  'Back To Home',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}