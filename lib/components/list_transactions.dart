import 'package:flutter/material.dart';
import 'package:project_akhir/models/transaction.dart';
import 'package:project_akhir/pages/users/transactions/detail_transactions.dart';

class ListTransactions extends StatefulWidget {
  const ListTransactions({Key? key}) : super(key: key);

  @override
  _ListTransactionsState createState() => _ListTransactionsState();
}

class _ListTransactionsState extends State<ListTransactions> {

  List<Transactions> listTransactions = [];

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  Future<void> _fetchTransactions() async {
    try {
      List<Transactions> data = await Transactions.listTransactions();

      setState(() {
        listTransactions = data;
      });
    } catch(e) {
      setState(() {
        listTransactions = [];
      });
      print(e.toString());
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
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text ('List Transactions'),
          const SizedBox(height: 12.0),
          Column(
            children: listTransactions.map(
              (transaction) => GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Order ID: ${transaction.codeTransaction}',

                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Total: Rp. ${transaction.total.toString()}',
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Badge(
                            label: Text('${transaction.status}'),
                            backgroundColor: _getColors(transaction.status),
                          )
                        ],
                      ),
                      const Spacer(flex: 1,),
                      IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailTransactionPage(id: transaction.id!)));
                        },
                        icon: const Icon(
                          Icons.chevron_left,
                          color: Color(0xFFD65A31),
                          size: 2.4,
                        ),
                      ),
                    ]
                  ),
                ),
              )
            ).toList(),
          ),
        ],
      ),
    );
  }
} 