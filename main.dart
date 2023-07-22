import 'dart:io';

// Define constants for menu items
Map<String, double> menuItems = {
  "Zinger Burger": 400,
  "Chicken Burger": 350,
  "Beef Burger     ": 300,
  "Zinger Cheese Burger": 450,
  "Club Sandwich": 400,
  "Grill Sandwich": 350,
  "Chicken Sandwich": 300,
  "Chicken Roll     ": 200,
  "Beef Roll     ": 180,
  "Kabab Roll     ": 150,
  "Chicken Mayo Roll": 250,
  "Chicken Chowmein": 400,
  "Chicken Manchurian": 550,
  "Chicken Shashlik": 500,
  "Egg Fried Rice": 350,
};

// Define a list to store the orders
List<Map<String, dynamic>> orders = [];

void main() {
  print("\n\n*****************************************************");
  print(
      "\t\x1B[1m \x1B[4mWelcome to Restaurant Management System\x1B[0m\x1B[0m\n");
  print("\t1.Admin\n");
  print("\t2.User\n");
  print("\t0.Exit");
  var choice = int.parse(stdin.readLineSync()!);

  switch (choice) {
    case 1:
      String correctUsername = 'samad';
      String correctPassword = 'samad';

      // Input username
      print('Enter your username:');
      String username = stdin.readLineSync()!;

      // Input password (passwords are usually masked when typing)
      print('Enter your password:');
      String password = stdin.readLineSync()!;

      // Check if the entered username and password match the predefined values
      if (username == correctUsername && password == correctPassword) {
        print('Login successful!');
        adminOptions();
      } else {
        print('Incorrect username or password. Please try again.');
      }
      break;

    case 2:
      while (true) {
        print("\n\n*****************************************************");
        print('\n\n1. Display Menu');
        print('2. Place Order');
        print('3. Display Orders');
        print('4. View Receipt');
        print('5. Exit');
        print('Enter your choice: ');
        int userChoice = int.parse(stdin.readLineSync()!);

        // Handle the menu options using if-else statements
        if (userChoice == 1) {
          displayMenu();
        } else if (userChoice == 2) {
          placeOrder();
        } else if (userChoice == 3) {
          displayOrders();
        } else if (userChoice == 4) {
          viewReceipt();
        } else if (userChoice == 5) {
          print('Goodbye!');
          break;
        } else {
          print('Invalid choice. Please try again.');
        }
      }
      break;

    case 0:
      print('Goodbye!');
      break;

    default:
      print('Invalid choice. Please try again.');
      break;
  }
}

void displayMenu() {
  print("*****************************************************");
  print("\t\t\t\x1B[1m \x1B[4mMenu\x1B[0m\x1B[0m\n");
  int index = 1;
  menuItems.forEach((itemName, price) {
    print('$index. $itemName\t\t\tRs. $price');
    index++;
  });
  print('0. Exit');
  print('Enter your choice: ');
  int menuChoice = int.parse(stdin.readLineSync()!);

  if (menuChoice > 0 && menuChoice <= menuItems.length) {
    print("Enter quantity: ");
    int quantity = int.parse(stdin.readLineSync()!);

    // Add the order to the orders list
    String itemName = menuItems.keys.elementAt(menuChoice - 1);
    Map<String, dynamic> order = {
      'itemName': itemName,
      'quantity': quantity,
    };
    orders.add(order);
    print('Order placed successfully!');
  } else if (menuChoice == 0) {
    print('Goodbye!');
  } else {
    print('Invalid choice. Please try again.');
  }
}

void placeOrder() {
  displayMenu();
}

void displayOrders() {
  if (orders.isEmpty) {
    print('No orders to display.');
  } else {
    print("*****************************************************");
    print("\t\t\t\x1B[1m \x1B[4mOrders\x1B[0m\x1B[0m\n");
    for (int i = 0; i < orders.length; i++) {
      double billAmount = calculateBill(orders[i]);
      print(
          '${i + 1}. ${orders[i]['itemName']} x ${orders[i]['quantity']}\tRs. $billAmount');
    }
  }
}

void viewReceipt() {
  if (orders.isEmpty) {
    print('No orders to generate a receipt.');
  } else {
    print("*****************************************************");
    print("\t\t\t\x1B[1m \x1B[4mReceipt\x1B[0m\x1B[0m\n");
    double totalAmount = 0;
    for (int i = 0; i < orders.length; i++) {
      double billAmount = calculateBill(orders[i]);
      print(
          '${orders[i]['itemName']} x ${orders[i]['quantity']}\tRs. $billAmount');
      totalAmount += billAmount;
    }
    print("Total Amount: Rs. $totalAmount");
  }
}

// Calculate the bill for an order
double calculateBill(Map<String, dynamic> order) {
  String itemName = order['itemName'];
  int quantity = order['quantity'];
  double price = menuItems[itemName]!;
  return price * quantity;
}

void adminOptions() {
  while (true) {
    print("\n\n*****************************************************");
    print('\n\nAdmin Options:');
    print('1. Display Menu');
    print('2. Add New Item to Menu');
    print('3. Update Item Price');
    print('4. Remove Item from Menu');
    print('5. Exit Admin Mode');
    print('Enter your choice: ');
    int adminChoice = int.parse(stdin.readLineSync()!);

    switch (adminChoice) {
      case 1:
        displayMenu();
        break;

      case 2:
        addNewItem();
        break;

      case 3:
        updateItemPrice();
        break;

      case 4:
        removeItem();
        break;

      case 5:
        print('Exiting Admin Mode...');
        return;

      default:
        print('Invalid choice. Please try again.');
    }
  }
}

void addNewItem() {
  print('Enter the name of the new item:');
  String itemName = stdin.readLineSync()!;
  print('Enter the price of $itemName:');
  double itemPrice = double.parse(stdin.readLineSync()!);

  if (menuItems.containsKey(itemName)) {
    print('$itemName already exists in the menu.');
  } else {
    menuItems[itemName] = itemPrice;
    print('New item added successfully!');
  }
}

void updateItemPrice() {
  print('Enter the name of the item to update its price:');
  String itemName = stdin.readLineSync()!;

  if (menuItems.containsKey(itemName)) {
    print('Enter the new price for $itemName:');
    double itemPrice = double.parse(stdin.readLineSync()!);
    menuItems[itemName] = itemPrice;
    print('Price for $itemName updated successfully!');
  } else {
    print('$itemName does not exist in the menu.');
  }
}

void removeItem() {
  print('Enter the name of the item to remove from the menu:');
  String itemName = stdin.readLineSync()!;

  if (menuItems.containsKey(itemName)) {
    menuItems.remove(itemName);
    print('$itemName removed from the menu.');
  } else {
    print('$itemName does not exist in the menu.');
  }
}
