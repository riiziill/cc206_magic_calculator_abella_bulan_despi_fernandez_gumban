import 'package:flutter/material.dart';

class ClothesShopPage extends StatefulWidget {
  const ClothesShopPage({super.key});

  @override
  _ClothesShopPageState createState() => _ClothesShopPageState();
}

class _ClothesShopPageState extends State<ClothesShopPage> {
  String selectedCategory = 'All';
  final List<String> categories = [
    'All',
    'T-Shirts',
    'Jeans',
    'Dresses',
    'Sweaters'
  ];

  final List<Map<String, String>> clothes = [
    {
      'name': 'T-Shirt',
      'price': '350',
      'image': 'assets/shirt.png',
      'brand': 'Brand A',
      'description': 'A comfortable cotton t-shirt for everyday wear.',
      'category': 'T-Shirts',
    },
    {
      'name': 'Jeans',
      'price': '800',
      'image': 'assets/pants.png',
      'brand': 'Brand B',
      'description': 'Stylish and durable jeans with a perfect fit.',
      'category': 'Jeans',
    },
    {
      'name': 'Dress',
      'price': '1200',
      'image': 'assets/dress.png',
      'brand': 'Brand C',
      'description':
          'A stylish and comfortable dress perfect for both casual and formal occasions.',
      'category': 'Dresses',
    },
    {
      'name': 'Sweater',
      'price': '950',
      'image': 'assets/sweater.png',
      'brand': 'Brand D',
      'description': 'Soft and snug sweater, perfect for winter.',
      'category': 'Sweaters',
    },
    {
      'name': 'Graphic T-Shirt',
      'price': '400',
      'image': 'assets/shirt.png',
      'brand': 'Brand E',
      'description': 'A trendy graphic t-shirt with unique design.',
      'category': 'T-Shirts',
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredClothes = selectedCategory == 'All'
        ? clothes
        : clothes
            .where((item) => item['category'] == selectedCategory)
            .toList();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          'Clothes Shop',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: const Color(0xFF0A264A),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: const Color(0xFF0A264A),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'West Clothes Shop',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Your one-stop shop for stylish and affordable clothes. Explore our latest collection of clothes and accessories!',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 8),
                Text(
                  'Operating Hours: Mon-Fri: 8:00 AM - 5:00 PM',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 8),
                Text(
                  'Contact: +1 234 567 890',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              value: selectedCategory,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
              items: categories.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.75,
              ),
              itemCount: filteredClothes.length,
              itemBuilder: (context, index) {
                final item = filteredClothes[index];
                return GestureDetector(
                  onTap: () {
                    _showItemDetails(context, item);
                  },
                  child: Card(
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          item['image']!,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item['name']!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '₱${item['price']}',
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showItemDetails(BuildContext context, Map<String, String> item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(item['name']!),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                item['image']!,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Text('Brand: ${item['brand']}'),
              Text('Price: ₱${item['price']}'),
              Text('Description: ${item['description']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
