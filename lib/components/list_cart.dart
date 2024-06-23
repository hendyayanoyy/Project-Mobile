// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:project_akhir/models/cart.dart';

class ListCarts extends StatefulWidget {
  const ListCarts({Key? key}) : super(key: key);

  @override
  State<ListCarts> createState() => _ListCartsState();
}

class _ListCartsState extends State<ListCarts> {

  List<Cart> dataCart = [];

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
    } catch(e) {
      setState(() {
        dataCart = [];
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Column(
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
      )
    );
  }
}
