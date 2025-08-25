import 'package:ecommerce_app/models/shoe.dart';
import 'package:flutter/material.dart';

class Cart extends ChangeNotifier{
  //  list of shoes to display for sale
  List<Shoe> shoes = [
    Shoe(
      image: "lib/images/AIR+MAX+DN8.avif",
      name: "AIR MAX DN8",
      price: "240",
      description: "Experience next-level comfort and style.",
    ),
    Shoe(
      image: "lib/images/AIR+MAX+DN8+(GS).avif",
      name: "AIR MAX DN8 (GS)",
      price: "320",
      description: "Iconic design for a timeless look.",
    ),
    Shoe(
      image: "lib/images/AIR+MAX+DN8.avif",
      name: "NIKE DUNK LOW",
      price: "180",
      description: "Classic sneaker for everyday wear.",
    ),
    Shoe(
      image: "lib/images/AIR+MAX+DN8+(GS).avif",
      name: "NIKE PEGASUS 41",
      price: "150",
      description: "Performance running shoe for your daily runs.",
    ),
    Shoe(
      image: "lib/images/AIR+MAX+DN8.avif",
      name: "NIKE PEGASUS 41",
      price: "150",
      description: "Performance running shoe for your daily runs.",
    ),
    
  ];
  // list of items in user cart
  List<Shoe> cart = [];

  // get the list of shoes for sale
  List<Shoe> getShoes() => shoes;

  // get cart
  List<Shoe> getCart() => cart;

  // add items to cart
  void addToCart(Shoe shoe) {
    cart.add(shoe);
    notifyListeners();
  }

  //  remove items from cart
  void removeFromCart(Shoe shoe) {
    cart.remove(shoe);
    notifyListeners();
  }
}
