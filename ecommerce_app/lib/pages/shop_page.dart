import 'package:ecommerce_app/components/shoe_tile.dart';
import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/shoe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageStateState();
}

class _ShopPageStateState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(builder: (context, value, child) => SafeArea(
      child: Column(
        children: [
          // search bar
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Search',
                  style: TextStyle(color: Colors.grey[500], fontSize: 16),
                ),
                Spacer(),
                Icon(Icons.search, color: Colors.grey),
              ],
            ),
          ),
      
          //  message
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text(
              "everyone flies... someone fly longer than others",
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          ),
      
          //  hot picks
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Hot Picks 🔥",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Text(
                  "See all",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
      
          const SizedBox(height: 20),
      
          // list of shoes for sale
          Expanded(
            child: ListView.builder(
              itemCount: value.getShoes().length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                //  get a shoe from the shoplist
                Shoe shoe = value.getShoes()[index];

                //  return the shoe
                return ShoeTile(shoe: shoe);
              },
            ),
          ),
      
          Padding(
            padding: const EdgeInsets.only(top:25.0, left: 25.0, right: 25.0),
            child: Divider(
              color: Colors.white,
            ),
          )
        ],
      ),
    ));
  }
}
