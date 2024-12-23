import 'package:flutter/material.dart';

class EditInfor extends StatelessWidget {
  const EditInfor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "assets/images/lo.png",
            height: 80,
            // fit: BoxFit.cover,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text(
              "Edit Profile",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
