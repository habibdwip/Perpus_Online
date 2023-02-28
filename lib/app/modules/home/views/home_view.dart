import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selamat datang di',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Perpus Online',
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Silahkan login sebagai',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () => Get.toNamed('/staff'),
                    child: Text("Staff")),
                ElevatedButton(
                    onPressed: (() => Get.toNamed('/siswa')),
                    child: Text("Siswa")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
