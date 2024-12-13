import 'package:firestoreexample/models/product_model.dart';
import 'package:firestoreexample/services/database_service.dart';
import 'package:firestoreexample/ui/create/create_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<ProductModel> items = [];

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: items.length,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.3),
                  spreadRadius: 4,
                  blurRadius: 7
                )
              ]
            ),
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(7),
            clipBehavior: Clip.hardEdge,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(items[index].name??"",style: const TextStyle(fontWeight: FontWeight.bold),),
                      Text(items[index].price.toString(),style: const TextStyle(fontWeight: FontWeight.bold),),
                      Text(items[index].description??"",style: const TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => deleteProduct(items[index]),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Colors.red,),
                    child: const Icon(Icons.delete,color: Colors.white,),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context,CupertinoPageRoute(builder: (context) => const CreateScreen(),));
          getProducts();
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }


  void getProducts() async {
    items = await DatabaseService.getProducts();
    setState(() {});
  }

  void deleteProduct(ProductModel model) async {
    await DatabaseService.delProduct(model);
    getProducts();
  }
}
