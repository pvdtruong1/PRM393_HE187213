import 'dart:async';

void main() async {
  runExercise1();
  runExercise2();
  runExercise3();
  runExercise4();
  await runExercise5();
}

void runExercise1() {
  print("\n===== EXERCISE 1 =====");

  int cupsOfCoffee = 2;
  double pricePerCup = 4.25;
  String drinkName = "Caramel Macchiato";
  bool isTakeaway = true;

  print("Drink: $drinkName");
  print("Quantity: $cupsOfCoffee cups");
  print("Price per cup: \$$pricePerCup");
  print("Takeaway order: $isTakeaway");
  print("Total cost for $cupsOfCoffee cups is \$${cupsOfCoffee * pricePerCup}.");
}

void runExercise2() {
  print("\n===== EXERCISE 2 =====");

  List<int> groceryPrices = [12, 25, 38, 45];
  groceryPrices.add(60);
  groceryPrices.remove(25);
  int basketSum = groceryPrices[0] + groceryPrices[1];
  bool isLastCheaper = groceryPrices.last > groceryPrices.first;

  print("Grocery prices: $groceryPrices");
  print("Sum of first two items: \$$basketSum");
  print("Is most expensive item greater than first item: $isLastCheaper");

  Set<String> favoriteFruits = {"Apple", "Orange", "Apple"};
  favoriteFruits.add("Mango");
  favoriteFruits.remove("Orange");
  print("Favorite fruit basket: $favoriteFruits");

  Map<String, dynamic> bakeryItem = {
    "name": "Blueberry Muffin",
    "calories": 350,
    "isFresh": true
  };
  bakeryItem["rating"] = 4.8;
  print("Bakery item details: $bakeryItem");
  print("Item name: ${bakeryItem['name']}");

  String budgetStatus = (isLastCheaper && groceryPrices.length >= 4)
      ? "Within Budget"
      : "Exceeds Budget";
  print("Checkout verification: $budgetStatus");
}

void runExercise3() {
  print("\n===== EXERCISE 3 =====");

  int glassesOfWater = 7;
  if (glassesOfWater >= 8) {
    print("Hydration: Excellent job staying hydrated today!");
  } else if (glassesOfWater >= 5) {
    print("Hydration: Good progress, have another glass soon.");
  } else {
    print("Hydration: Low intake, remember to drink more water.");
  }

  int mealTime = 2;
  switch (mealTime) {
    case 1:
      print("Meal: Breakfast time");
      break;
    case 2:
      print("Meal: Lunch break");
      break;
    case 3:
      print("Meal: Dinner time");
      break;
    default:
      print("Meal: Light snack");
  }

  List<String> hobbies = ["Reading a novel", "Cycling in the park", "Cooking pasta"];
  for (int i = 0; i < hobbies.length; i++) {
    print("Planned activity [$i]: ${hobbies[i]}");
  }
  for (var hobby in hobbies) {
    print("Enjoying hobby: $hobby");
  }
  hobbies.forEach((hobby) => print("Completed hobby: $hobby"));

  print("Discounted price: \$${calculateDiscount(50.0, 10.0)}");
  print("Remaining reading time: ${calculateRemainingMinutes(60, 25)} minutes");
}

double calculateDiscount(double originalPrice, double discountPercent) =>
    originalPrice * (1.0 - (discountPercent / 100.0));

int calculateRemainingMinutes(int totalMinutes, int spentMinutes) {
  return totalMinutes - spentMinutes;
}

class Car {
  String brand;
  Car(this.brand);
  Car.cityCar() : brand = "Compact City Car";

  void drive() {
    print("The $brand car is driving smoothly on the street.");
  }
}

class ElectricCar extends Car {
  double batteryCapacity;

  ElectricCar(String brand, this.batteryCapacity) : super(brand);

  @override
  void drive() {
    print("The $brand electric car is cruising quietly with $batteryCapacity kWh battery.");
  }
}

void runExercise4() {
  print("\n===== EXERCISE 4 =====");

  Car familyCar = Car("Honda Civic");
  familyCar.drive();

  Car rentalCar = Car.cityCar();
  rentalCar.drive();

  ElectricCar modernCar = ElectricCar("Nissan Leaf", 40.0);
  modernCar.drive();
}

Future<String> brewCoffee() async {
  await Future.delayed(Duration(milliseconds: 1000));
  return "Fresh coffee is brewed and ready to serve!";
}

Stream<int> timerStream(int totalSeconds) async* {
  for (int i = 1; i <= totalSeconds; i++) {
    await Future.delayed(Duration(milliseconds: 300));
    yield i;
  }
}

Future<void> runExercise5() async {
  print("\n===== EXERCISE 5 =====");

  print("Brewing coffee, please wait...");
  String coffeeResult = await brewCoffee();
  print("Kitchen update: $coffeeResult");

  String? customerNote;
  print("Order note: ${customerNote ?? 'No special requests'}");
  customerNote = "Extra cinnamon on top";
  print("Note character count: ${customerNote!.length}");

  print("Waiting timer started...");
  await for (int second in timerStream(3)) {
    print("Timer countdown: $second second(s)");
  }
  print("Timer finished! Enjoy your drink.");
}
