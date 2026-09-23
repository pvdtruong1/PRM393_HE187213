class Vehicle {
  String brand;
  int year;

  Vehicle(this.brand, this.year);

  void startEngine() {
    print("Khởi động phương tiện...");
  }
}

class Car extends Vehicle {
  bool isElectric;

  Car(String brand, int year, this.isElectric) : super(brand, year);

  Car.tesla(int year)
      : isElectric = true,
        super("Tesla", year);

  @override
  void startEngine() {
    if (isElectric) {
      print("$brand ($year): là xe điện.");
    } else {
      print("$brand ($year): là xe xăng.");
    }
  }
}

void main() {
  Car normalCar = Car("Toyota", 2022, false);
  normalCar.startEngine();

  Car teslaCar = Car.tesla(2024);
  teslaCar.startEngine();
}