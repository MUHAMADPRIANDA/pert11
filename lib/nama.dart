import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProductListPage(),
    );
  }
}

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final List<Product> products = [
    Product(id: 1, name: 'kaos hitam', price: 'Rp. 10,000'),
    Product(id: 2, name: 'celana pendek', price: 'Rp. 20,000'),
    Product(id: 3, name: 'celana panjang', price: 'Rp. 30,000'),
    Product(id: 4, name: 'topi', price: 'Rp. 40,000'),
    Product(id: 5, name: 'hoodie', price: 'Rp. 50,000'),
    Product(id: 6, name: 'jaket pria', price: 'Rp. 60,000'),
    Product(id: 7, name: 'jam tangan', price: 'Rp. 70,000'),
    Product(id: 8, name: 'kemeja', price: 'Rp. 80,000'),
    Product(id: 9, name: 'rompi', price: 'Rp. 90,000'),
    Product(id: 10, name: 'bando', price: 'Rp. 100,000'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name),
            subtitle: Text('Harga: ${products[index].price}'),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                _showDeleteDialog(context, index);
              },
            ),
            onTap: () {
              // Tambahkan aksi atau navigasi ke halaman detail jika diperlukan
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddProductDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showDeleteDialog(BuildContext context, int index) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi Penghapusan'),
          content: const Text('Apakah Anda yakin ingin menghapus produk ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                _deleteProduct(index);
                Navigator.pop(context);
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  void _deleteProduct(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  Future<void> _showAddProductDialog(BuildContext context) async {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Produk Baru'),
          content: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama Produk'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Harga'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                _addProduct(nameController.text, priceController.text);
                Navigator.pop(context);
              },
              child: const Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  void _addProduct(String name, String price) {
    setState(() {
      products.add(Product(
        id: products.length + 1,
        name: name,
        price: 'Rp $price',
      ));
    });
  }
}

class Product {
  final int id;
  final String name;
  final String price;

  Product({
    required this.id,
    required this.name,
    required this.price,
  });
}
