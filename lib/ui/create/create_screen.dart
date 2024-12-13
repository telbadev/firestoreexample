import 'package:firestoreexample/models/product_model.dart';
import 'package:firestoreexample/services/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController dscCtrl = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nomi'
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: priceCtrl,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Narxi'
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: dscCtrl,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Haqida'
              ),
            ),
            const SizedBox(height: 40,),
            CupertinoButton(
              onPressed: () => create(),
              child: Text("Yaratish"),
            )
          ],
        ),
      ),
    );
  }

  void create() async {
    if(
    nameCtrl.text.trim().isEmpty ||
        dscCtrl.text.trim().isEmpty  ||
        priceCtrl.text.trim().isEmpty
    ) return;

    ProductModel model = ProductModel(
      name: nameCtrl.text.trim(),
      description: dscCtrl.text.trim(),
      price: double.parse(priceCtrl.text.trim()),
    );

    await DatabaseService.createProduct(model);
    Navigator.pop(context);

  }


}
