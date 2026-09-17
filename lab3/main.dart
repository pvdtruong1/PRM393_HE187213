import 'dart:async';
import 'dart:convert';

void main() async {
  await runExercise1();
  await runExercise2();
  await runExercise3();
  await runExercise4();
  await runExercise5();
}

class Product {
  final int id;
  final String name;
  final double price;

  const Product({
    required this.id,
    required this.name,
    required this.price,
  });

  @override
  String toString() => 'Product(id: $id, name: "$name", price: \$$price)';
}

class ProductRepository {
  final List<Product> _products = [];
  final StreamController<Product> _controller = StreamController<Product>.broadcast();

  Future<List<Product>> getAll() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_products);
  }

  Stream<Product> liveAdded() => _controller.stream;

  void addProduct(Product product) {
    _products.add(product);
    _controller.sink.add(product);
  }

  Future<void> dispose() async {
    await _controller.close();
  }
}

Future<void> runExercise1() async {
  print("\n===== EXERCISE 1 =====");

  final repository = ProductRepository();

  final subscription = repository.liveAdded().listen((product) {
    print("[Live Stream Event] New Product Added: $product");
  });

  repository.addProduct(const Product(id: 1, name: "Mechanical Keyboard", price: 89.99));
  repository.addProduct(const Product(id: 2, name: "Ergonomic Mouse", price: 49.50));
  repository.addProduct(const Product(id: 3, name: "USB-C Hub", price: 29.99));

  await Future.delayed(const Duration(milliseconds: 100));

  final allProducts = await repository.getAll();
  print("[Future getAll()] Total inventory count: ${allProducts.length}");
  for (final product in allProducts) {
    print(" - $product");
  }

  await subscription.cancel();
  await repository.dispose();
}

class User {
  final String name;
  final String email;

  const User({
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String? ?? 'Unknown',
      email: json['email'] as String? ?? 'N/A',
    );
  }

  @override
  String toString() => 'User(name: "$name", email: "$email")';
}

class UserRepository {
  static const String _mockJsonPayload = '''
  [
    {"name": "Alice Johnson", "email": "alice@example.com"},
    {"name": "Bob Smith", "email": "bob@example.com"},
    {"name": "Charlie Brown", "email": "charlie@example.com"}
  ]
  ''';

  Future<List<User>> fetchUsers() async {
    await Future.delayed(const Duration(milliseconds: 300));

    final dynamic decoded = jsonDecode(_mockJsonPayload);
    if (decoded is List) {
      return decoded
          .map((item) => User.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }
}

Future<void> runExercise2() async {
  print("\n===== EXERCISE 2 =====");

  final repository = UserRepository();
  print("Simulating API request to fetch users...");

  final users = await repository.fetchUsers();
  print("Successfully parsed ${users.length} users from JSON:");
  for (var i = 0; i < users.length; i++) {
    print(" User [${i + 1}]: ${users[i]}");
  }
}

Future<void> runExercise3() async {
  print("\n===== EXERCISE 3 =====");

  final completer = Completer<void>();

  print("1. [Synchronous] Code execution starts");

  Future(() {
    print("5. [Event Queue] Future() callback executed");
    completer.complete();
  });

  scheduleMicrotask(() {
    print("3. [Microtask Queue] scheduleMicrotask() callback executed");
  });

  Future.microtask(() {
    print("4. [Microtask Queue] Future.microtask() callback executed");
  });

  print("2. [Synchronous] Code execution ends");

  await completer.future;
}

Future<void> runExercise4() async {
  print("\n===== EXERCISE 4 =====");

  final numberStream = Stream.fromIterable([1, 2, 3, 4, 5]);

  final transformedStream = numberStream
      .map((number) => number * number)
      .where((square) => square.isEven);

  print("Stream pipeline output (.map(n^2) -> .where(isEven)):");
  await for (final value in transformedStream) {
    print(" [Emitted Value] Even Square: $value");
  }
}

class Settings {
  Settings._internal();

  static final Settings _instance = Settings._internal();

  factory Settings() => _instance;
}

Future<void> runExercise5() async {
  print("\n===== EXERCISE 5 =====");

  final a = Settings();
  final b = Settings();

  print("identical(a, b): ${identical(a, b)}");
}
