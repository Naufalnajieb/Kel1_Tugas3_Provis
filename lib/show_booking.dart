import 'package:flutter/material.dart';
import 'booking_status.dart';
import 'navbar.dart';
import 'pengembalian.dart';


class ShowBookingPage extends StatefulWidget {
  const ShowBookingPage({super.key});

  @override
  State<ShowBookingPage> createState() => _ShowBookingPageState();
}

class _ShowBookingPageState extends State<ShowBookingPage> {
  
  int selectedFilter = 0; // 0: Semua, 1: Hari ini, 2: Belum dikembalikan

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const SizedBox.shrink(),
        automaticallyImplyLeading: false,
        toolbarHeight: 20,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari Riwayat Booking',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),

            // Tab Bar
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
                        'Pengembalian Produk Sewa',
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
                          builder: (context) => const BookingStatusPage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: const Center(
                        child: Text(
                          'Riwayat Sewa Produk',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Filter Buttons
            // Filter Button (full width)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Tambahkan logika filter di sini jika diperlukan
                  },
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
            ),



            // Tanggal Hari Ini
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 4, bottom: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Tanggal Hari ini',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Card - Hari ini
            if (selectedFilter == 1 || selectedFilter == 0)
              _buildProductCard(
                image: 'assets/images/Produk1.png',
                title: 'Tenda Biru',
                tanggal: '17 April 2025',
                lokasi: 'Bandung',
                jam: '08:00 - 18:00 WIB',
                isDueToday: true,
              ),

            // Label belum dikembalikan
            if (selectedFilter == 2 || selectedFilter == 0)
              const Padding(
                padding: EdgeInsets.only(left: 16, top: 12, bottom: 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Belum dikembalikan',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),

            // Card - Belum Dikembalikan
            if (selectedFilter == 2 || selectedFilter == 0)
              _buildProductCard(
                image: 'assets/images/Produk2.png',
                title: 'Kompor Portable',
                tanggal: '18 April 2025',
                lokasi: 'Bandung',
                jam: '08:00 - 18:00 WIB',
                isDueToday: false,
              ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }

  Widget _buildProductCard({
    required String image,
    required String title,
    required String tanggal,
    required String lokasi,
    required String jam,
    required bool isDueToday,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          image,
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          children: [
                            _infoRow(Icons.calendar_today_outlined, 'Tanggal Pengembalian', tanggal),
                            const SizedBox(height: 8),
                            _infoRow(Icons.location_on_outlined, 'Lokasi Pengembalian', lokasi),
                            const SizedBox(height: 8),
                            _infoRow(Icons.access_time, 'Jam Operasional', jam),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (isDueToday) ...[
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  'barang wajib dikembalikan hari ini !',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PengembalianPage(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Kembalikan Barang',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade700),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 10, color: Colors.black54)),
                Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}