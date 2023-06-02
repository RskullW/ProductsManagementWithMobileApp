class Product {
  late String id;
  late String name;

  Product(this.id, this.name);
}

class ProductsImpl {
  List<Product> _productList = [];

  ProductsImpl() {}
  bool addProduct(Product product) {
    bool isIdUnique = !_productList.any((p) => p.id == product.id);
    if (isIdUnique) {
      _productList.add(product);
    }
    return isIdUnique;
  }

  bool deleteProduct(Product product) {
    String id = product.id;

    for (int i = 0; i < _productList.length; i++) {
      if (_productList[i].id == id) {
        _productList.removeAt(i);
        return true;
      }
    }

    return false;
  }

  String getName(String id) {
    Product? product = _productList.firstWhere((p) => p.id == id,
        orElse: () => Product("", ""));
    return product.name;
  }

  List<Product> findByName(String name) {
    List<Product> list = [];
    _productList.forEach((product) {
      if (product.name == name) {
        list.add(product);
      }
    });
    return list;
  }
}

class Products {
  static ProductsImpl _productsImpl = ProductsImpl();

  static bool AddProduct(Product product) {
    return _productsImpl.addProduct(product);
  }

  static bool DeleteProduct(Product product) {
    return _productsImpl.deleteProduct(product);
  }

  static String GetName(String id) {
    return _productsImpl.getName(id);
  }

  static List<Product> FindByName(String name) {
    return _productsImpl.findByName(name);
  }

  static int GetSize() {
    return _productsImpl._productList.length;
  }

  static List<Product> getAllProducts() {
    return _productsImpl._productList;
  }
}
