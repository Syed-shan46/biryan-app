List<dynamic> categories = [
  {
    "_id": "6537ece708ff5b7de97d0695",
    "title": "Rice",
    "value": "Rice",
    "imageUrl": "assets/images/rice2.png",
    "__v": 0
  },
  {
    "_id": "6531209dbbe4998e90af3fef",
    "title": "Fry",
    "value": "fry",
    "imageUrl": "assets/images/fry.png",
    "__v": 0
  },
  {
    "_id": "6531209dbbe4998e90af3fef",
    "title": "Curry",
    "value": "curry",
    "imageUrl": "assets/images/curry1.png",
    "__v": 0
  },
  {
    "_id": "6537ece708ff5b7de97d0695",
    "title": "Juices",
    "value": "juices",
    "imageUrl": "assets/images/juice2.png",
    "__v": 0
  },
  {
    "_id": "6537ece708ff5b7de97d0695",
    "title": "Drinks",
    "value": "drinks",
    "imageUrl": "assets/images/coc.png",
    "__v": 0
  },
  {
    "_id": "6537ece708ff5b7de97d0695",
    "title": "Shawarma",
    "value": "shawarma",
    "imageUrl": "assets/images/shawarma.png",
    "__v": 0
  },
];

List<dynamic> restaurants = [
  {
    "_id": "6530ebbcc9e72013e5b65933",
    "title": "Lapisara Eatery",
    "time": "6:00am - 9:00pm",
    "imageUrl": "assets/images/cb.jpg",
    "owner": "fdfsdfsdfs",
    "code": "41007428",
    "logoUrl": "",
    "rating": 5,
    "ratingCount": "6765",
    "coords": {
      "id": "2023",
      "latitude": 37.78792117665919,
      "longitude": -122.41325651079953,
      "address": "698 Post St, San Francisco, CA 94109, United States",
      "title": "Lapisara Eatery",
      "latitudeDelta": 0.0122,
      "longitudeDelta": 0.0221
    }
  },
  {
    "_id": "6530ea6bc9e72013e5b6592d",
    "title": "Burger King",
    "time": "6:00am - 9:00pm",
    "imageUrl": "assets/images/mb.jpg",
    "owner": "sjgdsjgfjshhjs",
    "code": "41007428",
    "logoUrl": "",
    "rating": 5,
    "ratingCount": "3278",
    "coords": {
      "id": "2020",
      "latitude": 37.785925590588505,
      "longitude": -122.41007428687641,
      "address": "333 O'Farrell St, San Francisco, CA 94102, United States",
      "title": "Burger King",
      "latitudeDelta": 0.0122,
      "longitudeDelta": 0.0221
    }
  },
  {
    "_id": "6530eb66c9e72013e5b65931",
    "title": "La Foods",
    "time": "6:00am - 9:00pm",
    "imageUrl": "assets/images/bb.jpg",
    "owner": "fgdgdfgd",
    "code": "41007428",
    "logoUrl": "",
    "rating": 5,
    "ratingCount": "5666",
    "coords": {
      "id": "2022",
      "latitude": 37.787503258917035,
      "longitude": -122.39854938269353,
      "address": "333 O'Farrell St, San Francisco, CA 94102, United States",
      "title": "La Foods",
      "latitudeDelta": 0.0122,
      "longitudeDelta": 0.0221
    }
  },
];

List<Map<String, dynamic>> foods = [
  {
    "_id": "65316968f94c6496dc84f3c1",
    "title": "Chicken Biriyani",
    "foodTags": ["Italian", "Dessert", "Coffee", "Mascarpone", "Cocoa"],
    "foodType": ["Dessert"],
    "code": "41007428",
    "isAvailable": true,
    "restaurant": "6530ea6bc9e72013e5b6592d",
    "rating": 4.9,
    "ratingCount": "420",
    "description":
        "A classic Italian dessert made of layers of coffee-soaked ladyfingers and creamy mascarpone, topped with cocoa.",
    "price": 7.99,
    "additives": [
      {"id": 1, "title": "Ladyfingers", "price": "1.00"},
      {"id": 2, "title": "Coffee", "price": "1.50"},
      {"id": 3, "title": "Mascarpone Cheese", "price": "2.50"},
      {"id": 4, "title": "Cocoa", "price": "0.50"},
      {"id": 5, "title": "Sugar", "price": "0.50"}
    ],
    "imageUrl": "assets/images/cb.jpg",
    "__v": 0,
    "category": "6531209dbbe4998e90af3fef",
    "time": "35 min"
  },
  {
    "_id": "653168e9f94c6496dc84f3bf",
    "title": "Mutton Biriyani",
    "foodTags": ["Italian", "Creamy", "Pasta", "Bacon", "Egg"],
    "foodType": ["Main Course", "Lunch", null],
    "code": "41007428",
    "isAvailable": true,
    "restaurant": "6530ea6bc9e72013e5b6592d",
    "rating": 4.7,
    "ratingCount": "310",
    "description":
        "A traditional Italian pasta dish with creamy egg sauce, pancetta, and cheese.",
    "price": 14.99,
    "additives": [
      {"id": 1, "title": "Egg", "price": "1.00"},
      {"id": 2, "title": "Pancetta", "price": "3.00"},
      {"id": 3, "title": "Parmesan Cheese", "price": "2.00"},
      {"id": 4, "title": "Black Pepper", "price": "0.50"},
      {"id": 5, "title": "Pasta", "price": "3.00"}
    ],
    "imageUrl": "assets/images/mb.jpg",
    "__v": 2,
    "category": "6531209dbbe4998e90af3fef",
    "time": "20 min"
  },
  {
    "_id": "653169a9f94c6496dc84f3c3",
    "title": "Beef Biriyani",
    "foodTags": ["Vegan", "Healthy", "Salad", "Fresh", "Organic"],
    "foodType": ["Starter", "Lunch", "Dinner", "Health", "Vegan"],
    "code": "41007428",
    "isAvailable": true,
    "restaurant": "6530ea6bc9e72013e5b6592d",
    "rating": 4.6,
    "ratingCount": "230",
    "description":
        "A refreshing mix of organic vegetables, nuts, seeds, and a tangy vinaigrette.",
    "price": 11.99,
    "additives": [
      {"id": 1, "title": "Mixed Greens", "price": "1.50"},
      {"id": 2, "title": "Walnuts", "price": "2.00"},
      {"id": 3, "title": "Quinoa", "price": "1.50"},
      {"id": 4, "title": "Cherry Tomatoes", "price": "1.00"},
      {"id": 5, "title": "Vinaigrette", "price": "0.50"}
    ],
    "imageUrl": "assets/images/bb.jpg",
    "__v": 0,
    "category": "6531209dbbe4998e90af3fef",
    "time": "55 min"
  },
  {
    "_id": "65316771f94c6496dc84f3bd",
    "title": "Margherita Pizza",
    "foodTags": ["Italian", "Cheesy", "Vegetarian"],
    "foodType": ["Main Course"],
    "code": "41007428",
    "isAvailable": true,
    "restaurant": "6530ebbcc9e72013e5b65933",
    "rating": 4.5,
    "ratingCount": "150",
    "description":
        "A classic Margherita pizza with fresh tomatoes, mozzarella cheese, basil, and olive oil.",
    "price": 12.99,
    "additives": [
      {"id": 1, "title": "Cheese", "price": "2.00"},
      {"id": 2, "title": "Pepperoni", "price": "2.50"},
      {"id": 3, "title": "Ketch up", "price": "0.50"}
    ],
    "imageUrl": "assets/images/cb.jpg",
    "__v": 0,
    "category": "6531209dbbe4998e90af3fef",
    "time": "30 min"
  },
  {
    "_id": "65316a01f94c6496dc84f3c7",
    "title": "Chicken Biriyani",
    "foodTags": ["Fruit", "Smoothie", "Refreshing", "Sweet", "Cold"],
    "foodType": ["Drink", "Breakfast", "Snack", "Dessert", "Vegan"],
    "code": "41007428",
    "isAvailable": true,
    "restaurant": "6530ea6bc9e72013e5b6592d",
    "rating": 4.7,
    "ratingCount": "280",
    "description":
        "A delightful blend of tropical fruits, creating the perfect sweet and refreshing drink.",
    "price": 6.99,
    "additives": [
      {"id": 1, "title": "Mango", "price": "2.00"},
      {"id": 2, "title": "Pineapple", "price": "1.50"},
      {"id": 3, "title": "Banana", "price": "1.00"},
      {"id": 4, "title": "Coconut Milk", "price": "1.50"},
      {"id": 5, "title": "Ice", "price": "0.50"}
    ],
    "imageUrl": "assets/images/cb.jpg",
    "__v": 0,
    "category": "6531209dbbe4998e90af3fef",
    "time": "25 min"
  },
  {
    "_id": "653169d8f94c6496dc84f3c5",
    "title": "Mutton Biriyani",
    "foodTags": ["Barbecue", "Meat", "Grilled", "Spicy", "Savory"],
    "foodType": [
      "Main Course",
      "Dinner",
      "Grill",
      "Non-Vegetarian",
      "Barbecue"
    ],
    "code": "41007428",
    "isAvailable": true,
    "restaurant": "6530ea6bc9e72013e5b6592d",
    "rating": 4.8,
    "ratingCount": "320",
    "description":
        "A succulent assortment of grilled meats, served with sides and sauces.",
    "price": 18.99,
    "additives": [
      {"id": 1, "title": "Chicken", "price": "3.00"},
      {"id": 2, "title": "Beef", "price": "4.00"},
      {"id": 3, "title": "Lamb", "price": "4.00"},
      {"id": 4, "title": "Pork", "price": "3.50"},
      {"id": 5, "title": "Barbecue Sauce", "price": "1.00"}
    ],
    "imageUrl": "assets/images/mb.jpg",
    "__v": 0,
    "category": "6531209dbbe4998e90af3fef",
    "time": "45 min"
  }
];

const cart = [
  {
    "_id": "653b6588541d2aa2c1e89cd1",
    "userId": "6537a4448cd1bd140ebddcee",
    "productId": {
      "_id": "65316771f94c6496dc84f3bd",
      "title": "Margherita Pizza",
      "restaurant": "6530ebbcc9e72013e5b65933",
      "rating": 4.5,
      "ratingCount": "150",
      "imageUrl": ["", ""]
    },
    "additives": ["Extra Cheese", "Mushrooms"],
    "instructions": "",
    "totalPrice": 25.98,
    "quantity": 2,
    "__v": 0
  }
];

const profile = {
  "_id": "6537a4448cd1bd140ebddcee",
  "username": "Dbestech",
  "email": "db@king.com",
  "uid": "4NmOkCbvu7ToaBS9ZR1UVpv0G1g2",
  "address": [],
  "userType": "Vendor",
  "profile": "",
  "updatedAt": "2023-10-24T11:02:28.215Z"
};

const choicesList = [
  {
    "id": 1,
    "name": "Pick Up",
    "value": "pickup",
  },
  {
    "id": 2,
    "name": "4 Star",
    "value": "4star",
  },
  {
    "id": 3,
    "name": "3 Star",
    "value": "3star",
  },
  {
    "id": 4,
    "name": "Under 30 min",
    "value": "under30",
  },
  {
    "id": 5,
    "name": "Recommended",
    "value": "recommended",
  },
];
