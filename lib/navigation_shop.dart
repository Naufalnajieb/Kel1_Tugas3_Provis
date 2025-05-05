import 'package:flutter/material.dart';
import 'navbar.dart';
import 'navigation.dart';

class NavigationShopPage extends StatelessWidget {
  const NavigationShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> rentalStores = [
      {'name': 'BandungOutdoor', 'location': 'Bandung'},
      {'name': 'JakartaCamp', 'location': 'Jakarta'},
      {'name': 'BogorFlood', 'location': 'Bogor'},
      {'name': 'SukabumiCamp', 'location': 'Sukabumi'},
      {'name': 'RiauEagle', 'location': 'Riau'},
      {'name': 'RiauEagle', 'location': 'Riau'},
      {'name': 'RiauEagle', 'location': 'Riau'},
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
                hintText: 'Cari Toko...',
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
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NavigationPage()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: const Center(
                      child: Text(
                        'Produk Sewa',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),

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
                      'Toko Sewa',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const Divider(),

          // Daftar toko
          Expanded(
            child: ListView.builder(
              itemCount: rentalStores.length,
              itemBuilder: (context, index) {
                final store = rentalStores[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    elevation: 2,
                    color: Colors.grey[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          // Gambar toko
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[200],
                            ),
                            child: Image.asset(
                              'assets/images/Shop_Icon.png', // Ganti sesuai file kamu
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Nama dan lokasi
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                store['name']!,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text('Lokasi : ${store['location']}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }
}
