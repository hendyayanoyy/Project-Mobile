// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_akhir/models/cart.dart';
import 'package:project_akhir/models/transaction.dart';
import 'package:project_akhir/pages/users/screens/transactions.dart' as PageTransaction;

class ListCarts extends StatefulWidget {
  const ListCarts({Key? key}) : super(key: key);

  @override
  State<ListCarts> createState() => _ListCartsState();
}

class _ListCartsState extends State<ListCarts> {

  List<Cart> dataCart = [];
  late int totalOrder = 0;
  late double totalPrice = 0;

  late BuildContext _context;

  @override
  void initState() {
    super.initState();
    _fetchCarts();
  }

  Future<void> _fetchCarts() async {
    try {
      List<Cart> data = await Cart.listCart();

      setState(() {
        dataCart = data;
      });

      _setTotalOrder();
    } catch(e) {
      setState(() {
        dataCart = [];
      });
      print('error' + e.toString());
    }
  }

  Future<void> _setTotalOrder() async {
    try {
      int newTotalOrder = 0;
      double newTotalPrice = 0;

      for (var cart in dataCart) {
        newTotalOrder += cart.quantity;
        newTotalPrice += cart.book!.price * cart.quantity;
      }
      
      setState(() {
        totalOrder = newTotalOrder;
        totalPrice = newTotalPrice;
      });
    } catch(e) {
      print('error' + e.toString());
    }
  }

  Future<void> _checkout() async {
    try {

      List<dynamic> transactionDetail = [];

      for (var cart in dataCart) {
        transactionDetail.add({
          'book_id': cart.book!.id,
          'price': cart.book!.price,
          'quantity': cart.quantity
        });
      }

      bool transaction = await Transactions.createTransaction(
        totalPrice,
        transactionDetail,
      );

      if (transaction == true) {
        Navigator.push(
          _context,
          MaterialPageRoute(builder: (context) => const PageTransaction.Transactions()),
        );
      }
    } catch(e) {
      print('error' + e.toString());
    }
  }

  void incrementQuantity(int index) {
    setState(() {
      dataCart[index].quantity++;
    });
    _setTotalOrder();
  }

  void decrementQuantity(int index) {
    setState(() {
      dataCart[index].quantity--;
    });
    _setTotalOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Column(
            children: dataCart.map((cart) 
            => Container(
              margin: const EdgeInsets.only(bottom: 12.0),
              padding: const EdgeInsets.only(right: 8.0),
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
                children: [
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage(cart.book!.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(cart.book!.title, style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                      )),
                      Text(cart.book!.author, style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      )),
                      Text('Rp.' + cart.book!.price.toString()),
                    ],
                  ),
                  const Spacer(flex: 1),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          incrementQuantity(dataCart.indexOf(cart));
                        },
                      ),
                      Text(cart.quantity.toString()),
                      IconButton(
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          if (cart.quantity > 1) {
                            decrementQuantity(dataCart.indexOf(cart));
                            _setTotalOrder();
                          }
                        },
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      bool result = await Cart.deleteCart(context, cart.id);
                      if (result) {
                        await _fetchCarts();
                      }
                    },
                  ),
                ]
              ),
            ),
            ).toList(),
          ),
          SizedBox(height: 10.0),
          Container(
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'Total Order',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Spacer(flex: 1,),
                    Text(
                      totalOrder.toString(),
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0,),
                Row(
                  children: [
                    const Text(
                      'Total Price',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Spacer(flex: 1,),
                    Text(
                      'Rp. ' + totalPrice.toString(),
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ]
            )
          ),
          SizedBox(height: 12.0,),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _context = context;
              });
              _checkout();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFFD65A31),
            ),
            child: const Text('Checkout'),
          )
        ],
      )
    );
  }
}