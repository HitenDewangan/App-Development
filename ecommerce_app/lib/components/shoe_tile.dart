import 'package:flutter/material.dart';

import '../models/shoe.dart';

class ShoeTile extends StatelessWidget {
  Shoe shoe;
  ShoeTile({super.key, required this.shoe});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 25),
      width: 280,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // shoe pic
          // shoe pic
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 350, // specify a fixed height
              child: Image.asset(shoe.image, fit: BoxFit.cover), // add fit: BoxFit.cover to scale the image
            ),
          ),

          //  description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(shoe.name, style: TextStyle(color: Colors.grey[600])),
          ),

          //  price + detail
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // shoe name
                    Text(shoe.name, style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),),
            
                    const SizedBox(height: 4),
            
                    // shoe price
                    Text('\$' + shoe.price, style: TextStyle(
                      color: Colors.grey,
                    )),
                  ],
                ),
            
                //  button to add to cart (plus button)
              ],
            ),
          ),

          // button to add to cart
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
