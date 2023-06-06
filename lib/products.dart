class Product {
  late String id;
  late String name;

  Product(this.id, this.name);
}

class ProductsImpl {
  Map<String, Product> _productMap = {};

  ProductsImpl() {}

  bool AddProduct(Product product) {
    bool isIdUnique = !_productMap.containsKey(product.id);
    if (isIdUnique) {
      _productMap[product.id] = product;
    }
    return isIdUnique;
  }

  bool DeleteProduct(Product product) {
    return _productMap.remove(product.id) != null;
  }

  String GetName(String id) {
    Product? product = _productMap[id];
    return product?.name ?? "";
  }

  List<Product> FindByName(String name) {
    List<Product> list = [];
    _productMap.values.forEach((product) {
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
    return _productsImpl.AddProduct(product);
  }

  static bool DeleteProduct(Product product) {
    return _productsImpl.DeleteProduct(product);
  }

  static String GetName(String id) {
    return _productsImpl.GetName(id);
  }

  static List<Product> FindByName(String name) {
    return _productsImpl.FindByName(name);
  }

  static int GetSize() {
    return _productsImpl._productMap.length;
  }

  static Map<String, Product> GetAllProducts() {
    return _productsImpl._productMap;
  }
}
