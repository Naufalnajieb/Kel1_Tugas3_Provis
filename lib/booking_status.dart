import 'package:flutter/material.dart';
import 'show_booking.dart';   // halaman tab sebelah kiri
import 'navbar.dart';        // kalau dipakai di tempat lain

class BookingStatusPage extends StatelessWidget {
  const BookingStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        toolbarHeight: 20, // garis putih tipis di atas
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ────────────────── 1.  SEARCH BAR
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari Riwayat Booking',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                ),
              ),
            ),

            // ────────────────── 2.  TAB BAR
            Row(
              children: [
                // tab kiri
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ShowBookingPage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: const Center(
                        child: Text(
                          'Pengembalian Produk Sewa',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                // tab kanan (aktif)
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
                        'Riwayat Sewa Produk',
                        style: TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // ────────────────── 3.  FILTER BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: fungsi filter
                  },
                  icon: const Icon(Icons.filter_list, color: Colors.black),
                  label: const Text('Filter',
                      style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 4,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                  ),
                ),
              ),
            ),

            // ────────────────── 4.  LIST KARTU RIWAYAT
            BookingCard(
              title: 'Tenda Biru',
              category: 'Tenda',
              location: 'Bandung',
              price: 'Rp. 100.000',
              quantity: '1',
              rentalDate: '16‑04‑2025',
              returnDate: '17‑04‑2025',
              operationTime: '08:00 WIB – 18:00 WIB',
              image: 'assets/images/Produk1.png',
              status: 'Sedang Dipinjam',
              statusColor: Colors.green,
            ),
            BookingCard(
              title: 'Kompor Portable',
              category: 'Kompor',
              location: 'Bandung',
              price: 'Rp. 50.000',
              quantity: '1',
              rentalDate: '16‑04‑2025',
              returnDate: '18‑04‑2025',
              operationTime: '08:00 WIB – 18:00 WIB',
              image: 'assets/images/Produk2.png',
              status: 'Produk Di Booking',
              statusColor: Colors.amber,
            ),
            BookingCard(
              title: 'Raincoat',
              category: 'Raincoat',
              location: 'Bandung',
              price: 'Rp. 100.000',
              quantity: '1',
              rentalDate: '16‑04‑2025',
              returnDate: '18‑04‑2025',
              operationTime: '08:00 WIB – 18:00 WIB',
              image: 'assets/images/Produk3.png',
              status: 'Selesai Dipinjam',
              statusColor: Colors.grey,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
//                                BOOKING CARD
// ──────────────────────────────────────────────────────────────────────────────

  class BookingCard extends StatelessWidget {
  final String title,
      category,
      location,
      price,
      quantity,
      rentalDate,
      returnDate,
      operationTime,
      image,
      status;
  final Color statusColor;

  const BookingCard({
    super.key,
    required this.title,
    required this.category,
    required this.location,
    required this.price,
    required this.quantity,
    required this.rentalDate,
    required this.returnDate,
    required this.operationTime,
    required this.image,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar di sebelah kiri
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),

                // Deskripsi di sebelah kanan
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),

                      _infoLine('Kategori', category),
                      _infoLine('Lokasi', location),
                      _infoLine('Harga', price),
                      _infoLine('Jumlah Produk', quantity),
                      _infoLine('Tanggal Sewa', rentalDate),
                      _infoLine('Tanggal Pengembalian', returnDate), // <- tidak bold
                      _infoLine('Jam Operasi', operationTime),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),

            // Tombol di tengah
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi bantu teks
  Widget _infoLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 13, color: Colors.black87),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
