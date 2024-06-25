import 'package:flutter/material.dart';

class DiscriptionPage extends StatelessWidget {
  const DiscriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laptop Description', style: TextStyle(color: Colors.blueAccent)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            'assets/img/lap.png', // Adjust the path according to your image location
            height: 200,
            // fit: BoxFit.cover,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                ListTile(
                  title: Text('Components'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('1. Processor AMD RYZEN 37320U'),
                      Text('2. RAM 8GB'),
                      Text('3. Storage (HDD/SSD) 512GB SSD'),
                      Text('4. Graphics Card Integrated AMD Radeon 610'),
                      Text('5. Display 1.79 cm Thin & 1.58kg Light '),
                      // Add more components if needed
                    ],
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('Features of Components', style: TextStyle(color: Colors.blueAccent)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('1. Processor: Speed, number of cores, cache size'),
                      Text('2. RAM:Random Access Memory. Amount of memory, speed, type (DDR3, DDR4)'),
                      Text('3. Storage: Capacity, type (HDD, SSD), speed'),
                      Text('4. Graphics Card: Model, VRAM, performance'),
                      Text('5. Display: Size, resolution, panel type (IPS, TN)'),
                      // Add more features if needed
                    ],
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('Popular Brands', style: TextStyle(color: Colors.blueAccent)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('1. Dell'),
                      Text('2. HP (Hewlett-Packard)'),
                      Text('3. Lenovo'),
                      Text('4. Apple (MacBook)'),
                      Text('5. ASUS'),
                      // Add more brands if needed
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
