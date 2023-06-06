import 'package:flutter/material.dart';
import 'bottom_bar.dart';
import 'gradient_color.dart';
import 'products.dart';

class FindScreen extends StatefulWidget {
  @override
  _FindScreenState createState() => _FindScreenState();
}

class _FindScreenState extends State<FindScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController nameController = TextEditingController();
  Color colorMessage = Colors.red;
  Map<String, Product> productMap = {};
  String errorMessage = "";

  void findProducts() {
    String name = nameController.text;

    if (name.isEmpty) {
      setState(() {
        errorMessage = "Название продукта не задано";
        colorMessage = Colors.red;
        nameController.clear();
        productMap.clear();
      });
      return;
    }

    List<Product> productList = Products.FindByName(name);
    productMap = Map.fromIterable(
      productList,
      key: (product) => product.id,
      value: (product) => product,
    );

    if (productMap.isEmpty) {
      setState(() {
        errorMessage = "Продуктов с таким названием не найдено!";
        colorMessage = Colors.red;
        nameController.clear();
      });
      return;
    }

    setState(() {
      errorMessage = "Найдено ${productMap.length} позиции(-й)!";
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
    int id = 1;

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          if (productMap.isNotEmpty)
            Container(
              height: 1.0,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.35),
              ),
            ),
          SizedBox(
            height: 10,
          ),
          if (productMap.isNotEmpty)
            Center(
              child: Text(
                'СПИСОК',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          SizedBox(height: 8.0),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: productMap.length,
              itemBuilder: (context, index) {
                final productId = productMap.keys.elementAt(index);
                final product = productMap[productId];
                return Text(
                  "${id++}. Наименование: ${product?.name ?? ""} || ID: ${product?.id ?? ""}",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
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
