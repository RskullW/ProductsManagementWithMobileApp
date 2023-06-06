import 'package:flutter/material.dart';
import 'bottom_bar.dart';
import 'gradient_color.dart';
import 'products.dart';

class DisplayScreen extends StatelessWidget {
  final _productMap = Products.GetAllProducts();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: GetGradientBackgroundScreen(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        bottomNavigationBar: CustomBottomBar(),
        backgroundColor: Colors.transparent,
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

  Widget _buildBody() {
    int id = 1;
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'СПИСОК ТОВАРОВ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          if (_productMap.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: _productMap.length,
                itemBuilder: (context, index) {
                  final productId = _productMap.keys.elementAt(index);
                  final product = _productMap[productId];

                  return Text(
                    "${index + 1}. Наименование: ${product?.name ?? ""} || ID: ${product?.id ?? ""}",
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
          if (_productMap.isEmpty)
            Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                Center(
                  child: Text(
                    'Список пуст',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
