import 'package:flutter/material.dart';
import 'package:nonton_test/bottom_bar.dart';
import 'package:nonton_test/products.dart';

class RemoveScreen extends StatefulWidget {
  @override
  _RemoveScreenState createState() => _RemoveScreenState();
}

class _RemoveScreenState extends State<RemoveScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController idController = TextEditingController();
  Color colorMessage = Colors.red;
  String errorMessage = "";

  void deleteProduct() {
    String id = idController.text;

    if (id.isEmpty) {
      setState(() {
        errorMessage = "Пожалуйста, укажите ID продукта";
        colorMessage = Colors.red;
      });
      return;
    }

    Product product = Product(id, "");
    bool isDeleted = Products.DeleteProduct(product);

    if (isDeleted) {
      setState(() {
        errorMessage = "Товар успешно удален!";
        id = "";
        idController.clear();
        colorMessage = Colors.green;
      });
    } else {
      setState(() {
        errorMessage = "Продукт с таким ID не найден.";
        colorMessage = Colors.red;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildAllBars();
  }

  Widget _buildAllBars() {
    var body = _buildBody();
    return Container(
      child: Scaffold(
        key: _scaffoldKey,
        body: body,
        appBar: _buildAppBar(),
        backgroundColor: Colors.white70,
        bottomNavigationBar: CustomBottomBar(),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: idController,
            decoration: InputDecoration(
              labelText: 'ID',
              labelStyle: TextStyle(color: Colors.blue, fontSize: 24),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16.0),
          Center(
            child: ElevatedButton(
              onPressed: deleteProduct,
              child: Text(
                'Удалить',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Center(
            child: Text(
              errorMessage,
              style: TextStyle(
                color: colorMessage,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: AppBar(
        backgroundColor: Colors.pink,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Center(
          child: Column(
            children: [
              Image.asset(
                "assets/img/logo.png",
                height: 50,
                width: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
