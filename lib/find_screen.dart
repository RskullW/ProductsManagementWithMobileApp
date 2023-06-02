import 'package:flutter/material.dart';
import 'package:nonton_test/bottom_bar.dart';
import 'package:nonton_test/products.dart';

class FindScreen extends StatefulWidget {
  @override
  _FindScreenState createState() => _FindScreenState();
}

class _FindScreenState extends State<FindScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController nameController = TextEditingController();
  Color colorMessage = Colors.red;
  List<Product> idList = [];
  String errorMessage = "";

  void findProducts() {
    String name = nameController.text;

    if (name.isEmpty) {
      setState(() {
        errorMessage = "Название продукта не задано";
        colorMessage = Colors.red;
        nameController.clear();
        idList.clear();
      });
      return;
    }

    idList = Products.FindByName(name);

    if (idList.isEmpty) {
      setState(() {
        errorMessage = "Продуктов с таким названием не найдено!";
        colorMessage = Colors.red;
        nameController.clear();
      });

      return;
    }
    setState(() {
      errorMessage = "Найдено " + idList.length.toString() + " позиции(-й)!";
      colorMessage = Colors.green;
      nameController.clear();
    });
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
    int id = 1;

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Название',
              labelStyle: TextStyle(color: Colors.blue, fontSize: 24),
            ),
          ),
          SizedBox(height: 16.0),
          Center(
            child: ElevatedButton(
              onPressed: findProducts,
              child: Text(
                'Найти',
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
          SizedBox(height: 8.0),
          if (idList.isNotEmpty)
            Center(
              child: Text(
                'СПИСОК',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          SizedBox(height: 8.0),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: idList.length,
              itemBuilder: (context, index) {
                return Text(
                  "${id++}. Наименование: " +
                      idList[index].name +
                      " || ID: " +
                      idList[index].id,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
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
