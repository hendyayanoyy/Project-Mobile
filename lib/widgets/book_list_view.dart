
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:project_akhir/models/book.dart';

class BookListView extends StatelessWidget {
  final List<Book> books;

  const BookListView({
    Key? key,
    required this.books,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14.0),
                    child: Image(
                      fit: BoxFit.fill,
                      width: 80,
                      height: 112,
                      image: AssetImage(books[index].image),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          books[index].title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          books[index].description,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.blueGrey,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                              ),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minHeight: 20,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.person,
                                      size: 12,
                                      color: Colors.black87,
                                    ),
                                    Text(
                                      ' ${books[index].author}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black87,
                                      ),
                                    )
                                  ],
                                )
                              )
                            ),
                            const SizedBox(width: 8.0,),
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                              ),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minHeight: 20,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 12,
                                      color: Colors.yellow,
                                    ),
                                    Text(
                                      ' ${books[index].rating}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black87,
                                      ),
                                    )
                                  ],
                                )
                              )
                            ),
                          ]
                        )
                      ],
                    ),
                  ),
                  const Spacer(flex: 1,),
                  MenuAnchor(
                    // childFocusNode: ,
                    menuChildren: <Widget>[
                      MenuItemButton(
                        child: const Row(
                          children: <Widget>[
                            Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            Text(
                              'Wishlist',
                            )
                          ],
                        ),
                        onPressed: () {
                          print('wishlist');
                        }
                      ),
                      MenuItemButton(
                        child: const Row(
                          children: <Widget>[
                            Icon(
                              Icons.edit,
                              color: Colors.greenAccent,
                            ),
                            Text(
                              'Edit',
                            )
                          ],
                        ),
                        onPressed: () {
                          print('edit');
                        }
                      ),
                      MenuItemButton(
                        child: const Row(
                          children: <Widget>[
                            Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            Text(
                              'Delete',
                            )
                          ],
                        ),
                        onPressed: () {
                          print('delete');
                        }
                      )
                    ],
                    builder: (BuildContext context, MenuController controller, Widget? child) {
                      return InkWell(
                        focusNode: FocusNode(debugLabel: "Menu Button"),
                        onTap: () {
                          if(controller.isOpen) {
                            controller.close();
                          } else {
                            controller.open();
                          }
                        },
                        child: const Icon(
                          Icons.menu,
                          color: Colors.blueGrey,
                        ),
                      );
                    },
                  )
                  // InkWell(
                  //   onTap: () {
                  //     print('wishlist');
                  //   },
                  //   child: const Icon(
                  //     Icons.menu,
                  //     color: Colors.blueGrey,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}