import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          const Text(
            "ad name",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          //seach
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(8.0)),
            // child: Image.asset(
            //   "assets/images/profile.png",
            //   fit: BoxFit.contain,
            // ),
          ),
        ],
      ),
    );
  }
}
