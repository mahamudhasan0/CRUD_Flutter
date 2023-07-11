import 'package:crud/RestApi/RestClient.dart';
import 'package:crud/Screen/ProductCreateScreen.dart';
import 'package:crud/Screen/ProductUpdateScreen.dart';
import 'package:crud/Style/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductGridViewScreen extends StatefulWidget {
  const ProductGridViewScreen({super.key});

  @override
  State<ProductGridViewScreen> createState() => _ProductGridViewScreenState();
}

class _ProductGridViewScreenState extends State<ProductGridViewScreen> {
  List ProductList = [];
  bool Loading = true;

  @override
  void initState() {
    CallData();
    super.initState();
  }

  CallData() async {
    Loading = true;
    var data = await ProductGridViewListRequest();

    setState(() {
      ProductList = data;
      Loading = false;
    });
  }

  DeleteItem(id) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete!'),
            content: Text('Do you want to delete?'),
            actions: [
              OutlinedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    setState(() {
                      Loading = true;
                    });
                    await ProductDeleteRequest(id);
                    await CallData();
                  },
                  child: Text('Yes')),
              OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('No'))
            ],
          );
        });
  }

  GoToUpdate(context, productItem) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => ProductUpdateScreen(productItem)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Product'),
      ),
      body: Stack(
        children: [
          ScreenBackground(context),
          Container(
              child: Loading
                  ? (const Center(child: CircularProgressIndicator()))
                  : RefreshIndicator(
                      onRefresh: () async {
                        await CallData();
                      },
                      child: (GridView.builder(
                        gridDelegate: ProductGridViewStyle(),
                        itemCount: ProductList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                    child: Image.network(
                                  ProductList[index]['Img'],
                                  fit: BoxFit.fill,
                                )),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(6, 5, 5, 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(ProductList[index]['ProductName']),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                          "Price : ${ProductList[index]['UnitPrice']} BDT"),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          OutlinedButton(
                                              onPressed: () {
                                                GoToUpdate(context,
                                                    ProductList[index]);
                                              },
                                              child: const Icon(
                                                CupertinoIcons
                                                    .ellipsis_vertical_circle,
                                                size: 18,
                                                color: colorGreen,
                                              )),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          OutlinedButton(
                                              onPressed: () {
                                                DeleteItem(
                                                    ProductList[index]['_id']);
                                              },
                                              child: const Icon(
                                                CupertinoIcons.delete,
                                                size: 18,
                                                color: colorRed,
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ))))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => ProductCreateScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
