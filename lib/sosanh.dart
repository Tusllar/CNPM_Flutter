import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComparisonPage extends StatelessWidget {
  final TextEditingController cupertinoController = TextEditingController();
  final TextEditingController materialController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("So sánh CupertinoTextField và TextField"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "CupertinoTextField (iOS Style)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            CupertinoTextField(
              controller: cupertinoController,
              placeholder: "Nhập tên của bạn",
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey6,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: CupertinoColors.systemGrey4),
              ),
              prefix: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(CupertinoIcons.person),
              ),
              suffix: CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(CupertinoIcons.clear_circled),
                onPressed: () {
                  cupertinoController.clear();
                },
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              "TextField (Material Style)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: materialController,
              decoration: InputDecoration(
                hintText: "Nhập tên của bạn",
                border: const OutlineInputBorder(
                  // borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                prefixIcon: Icon(Icons.person),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    materialController.clear();
                  },
                ),
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Thông tin nhập"),
                      content: Text(
                        "CupertinoTextField: ${cupertinoController.text}\n"
                        "TextField: ${materialController.text}",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Đóng"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text("Hiển thị dữ liệu"),
            ),
          ],
        ),
      ),
    );
  }
}
