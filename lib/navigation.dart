import 'package:flutter/material.dart';
import 'navbar.dart';
import 'navigation_shop.dart';
import 'detail_product.dart';
import 'cart.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  List<Map<String, dynamic>> cartItems = [];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> products = [
      {
        'name': 'Tenda Biru',
        'category': 'Tenda',
        'location': 'Bandung',
        'price': 'Rp. 100.000',
        'image': 'assets/images/Produk1.png',
      },
      {
        'name': 'Kompor Portable',
        'category': 'Kompor',
        'location': 'Bandung',
        'price': 'Rp. 50.000',
        'image': 'assets/images/Produk2.png',
      },
      {
        'name': 'Sleeping Bag',
        'category': 'Sleeping Bag',
        'location': 'Bandung',
        'price': 'Rp. 100.000',
        'image': 'assets/images/Produk3.png',
      },
      {
        'name': 'Raincoat',
        'category': 'Raincoat',
        'location': 'Bandung',
        'price': 'Rp. 100.000',
        'image': 'assets/images/Produk4.png',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: SizedBox.shrink(), // Tidak menampilkan konten di appBar
          automaticallyImplyLeading: false, // ini menonaktifkan panah back
          toolbarHeight: 20, // Atur tinggi AppBar sesuai kebutuhan
      ),
      body: Column(
        children: [
          // Search Field
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari produk...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),

          // Produk Sewa & Toko Sewa (Tab Style)
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 2, color: Colors.orange),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: const Center(
                    child: Text(
                      'Produk Sewa',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NavigationShopPage()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: const Center(
                      child: Text(
                        'Toko Sewa',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Tombol Filter dan Urutkan
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width / 2) - 24,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list, color: Colors.black),
                    label: const Text('Filter', style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width / 2) - 24,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.sort, color: Colors.black),
                    label: const Text('Urutkan', style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(),

          // Daftar Produk sebagai GridView 2 kolom
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.65, // DARI 0.75 → lebih tinggi item-nya
                ),

                itemBuilder: (context, index) {
                  final product = products[index];
                  final isAdded = cartItems.any((item) => item['name'] == product['name']);

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailProductPage(product: product),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.grey[100],
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                product['image']!,
                                height: 220,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(product['name']!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            const SizedBox(height: 4),
                            Text('Kategori : ${product['category']}',
                                style: const TextStyle(fontSize: 12)),
                            Text('Lokasi    : ${product['location']}',
                                style: const TextStyle(fontSize: 12)),
                            Text('Harga     : ${product['price']}',
                                style: const TextStyle(fontSize: 12)),
                            const Spacer(),
                            ElevatedButton.icon(
                            onPressed: () {
                            setState(() {
                                final currentProduct = products[index];
                                final exists = cartItems.any((item) => item['name'] == currentProduct['name']);
                                if (exists) {
                                  cartItems.removeWhere((item) => item['name'] == currentProduct['name']);
                                } else {
                                  cartItems.add(currentProduct);
                                }
                              });
                            },
                            icon: Icon(
                              isAdded ? Icons.check : Icons.add,
                              size: 14,
                            ),
                            label: Text(
                              isAdded ? 'Keranjang' : 'Tambah', // Teks berubah sesuai kondisi
                              style: const TextStyle(fontSize: 12),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isAdded
                                  ? Colors.green // Warna hijau jika sudah ditambahkan
                                  : Colors.amber, // Warna biru (bukan ungu) jika belum ditambahkan
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 6),
                            ),
                          )

                          ],
                        ),
                      ),

                    ),
                  );
              
                },
              ),
            ),
          ),
        ],
      ),

      // Floating Keranjang
      floatingActionButton: Stack(
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(selectedProducts: cartItems.toList()),
                ),
              );
            },
            backgroundColor: Colors.amber,
            child: Image.asset(
              'assets/icons/Cart.png',
              width: 24,
              height: 24,
            ),
          ),

          if (cartItems.isNotEmpty)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                child: Center(
                  child: Text(
                    cartItems.length.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }
}