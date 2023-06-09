import 'package:flutter/material.dart';
import 'bottom_bar.dart';
import 'gradient_color.dart';
import 'products.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  Color colorMessage = Colors.red;
  String errorMessage = "";

  void addProduct() {
    String id = idController.text;
    String name = nameController.text;

    if (id.isEmpty || name.isEmpty) {
      setState(() {
        errorMessage = "Пожалуйста, заполните все поля для ввода.";
        colorMessage = Colors.red;
      });
      return;
    }

    if (!RegExp(r'^\d+$').hasMatch(id)) {
      setState(() {
        errorMessage = "ID может содержать только цифры.";
        colorMessage = Colors.red;
      });
      return;
    }

    Product product = Product(id, name);
    bool isAdded = Products.AddProduct(product);

    if (isAdded) {
      setState(() {
        errorMessage = "Товар успешно добавлен!";
        id = "";
        name = "";
        idController.clear();
        nameController.clear();
        colorMessage = Colors.green;
      });
    } else {
      setState(() {
        errorMessage = "Продукт с таким же ID уже существует";
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
      decoration: GetGradientBackgroundScreen(),
      child: Scaffold(
        key: _scaffoldKey,
        body: body,
        appBar: _buildAppBar(),
        bottomNavigationBar: CustomBottomBar(),
        backgroundColor: Colors.transparent,
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
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'ID',
              labelStyle: TextStyle(color: Colors.white, fontSize: 24),
            ),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: nameController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Название',
              labelStyle: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          SizedBox(height: 16.0),
          Center(
            child: ElevatedButton(
              onPressed: addProduct,
              child: Text(
                'Добавить',
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
        backgroundColor: Colors.transparent,
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
