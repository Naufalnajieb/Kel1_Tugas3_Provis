import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'payment.dart';

class DetailProductPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const DetailProductPage({Key? key, required this.product}) : super(key: key);

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  DateTime? _tanggalSewa;
  DateTime? _tanggalPengembalian;
  int _jumlahStok = 2;
  

  
  int _currentReviewIndex = 0;
  final List<Map<String, dynamic>> _reviews = [
    {
      "name": "Naufal Fakhri",
      "comment": "Tenda dengan kualitas terbaik dan nyaman digunakan",
      "avatar": 'assets/images/Person.png',
      "rating": 5.0
    },
    {
      "name": "Muhamad Radhi",
      "comment": "Kondisi bagus dan sesuai ekspektasi",
      "avatar": 'assets/images/Person.png',
      "rating": 4.0
    },
    {
      "name": "Haniel Septian",
      "comment": "Pengalaman menyenangkan, recommended!",
      "avatar": 'assets/images/Person.png',
      "rating": 5.0
    },
    {
      "name": "Muhammad Fathan",
      "comment": "Tenda bersih dan kokoh",
      "avatar": 'assets/images/Person.png',
      "rating": 4.0
    },
    {
      "name": "Yoga Ilham",
      "comment": "Cocok untuk camping keluarga",
      "avatar": 'assets/images/Person.png',
      "rating": 4.0
    },
  ];

  void _changeReview(int direction) {
    setState(() {
      _currentReviewIndex =
          (_currentReviewIndex + direction) % _reviews.length;
      if (_currentReviewIndex < 0) {
        _currentReviewIndex += _reviews.length;
      }
    });
  }

  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  Future<void> _selectTanggalSewa() async {
    final DateTime today = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: today.add(const Duration(days: 2)),
      firstDate: today.add(const Duration(days: 2)),
      lastDate: today.add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _tanggalSewa = picked;
        if (_tanggalPengembalian != null &&
            !_tanggalPengembalian!.isAfter(_tanggalSewa!)) {
          _tanggalPengembalian = null;
        }
      });
    }
  }

  Future<void> _selectTanggalPengembalian() async {
    if (_tanggalSewa == null) return;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _tanggalSewa!.add(const Duration(days: 1)),
      firstDate: _tanggalSewa!.add(const Duration(days: 1)),
      lastDate: _tanggalSewa!.add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _tanggalPengembalian = picked;
      });
    }
  }

    Widget buildReview(Map<String, dynamic> review) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(review['avatar']),
                  radius: 24,
                ),

                const SizedBox(height: 6),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("${review['rating'].toString()}/5", style: const TextStyle(fontSize: 12)),
                    const SizedBox(width: 2),
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                  ],
                ),
              ],
            ),

            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(review['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(review['comment'], maxLines: 3, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 6),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < review['rating'].round()
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 16,
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => _changeReview(-1),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () => _changeReview(1),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    product["stok"] = _jumlahStok.toString();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar:  AppBar(
        title: const Text("Detail Produk"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(product['image']!, height: 300, width: double.infinity, fit: BoxFit.cover),
                      ),
                      const SizedBox(height: 12),
                      Text(product['name'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 8),
                      Text("Kategori : ${product['category']}"),
                      Text("Lokasi    : ${product['location']}"),
                      Text("Harga     : ${product['price']}"),
                      const Text("Stok        : 2"),
                      const SizedBox(height: 16),

                      const Text("Waktu Buka Toko", style: TextStyle(fontWeight: FontWeight.bold)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Center(child: Text("Mulai: 08:00 WIB")),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Center(child: Text("Sampai: 18:00 WIB")),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      const Text("Tanggal Sewa", style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: _selectTanggalSewa,
                          child: AbsorbPointer(
                            child: TextFormField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                prefixIcon: const Icon(Icons.calendar_today),
                                hintText: 'DD/MM/YYYY',
                                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              controller: TextEditingController(
                                text: _tanggalSewa == null ? '' : _dateFormat.format(_tanggalSewa!),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),
                      
                      const Text("Tanggal Pengembalian", style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: _selectTanggalPengembalian,
                          child: AbsorbPointer(
                            child: TextFormField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                prefixIcon: const Icon(Icons.calendar_today),
                                hintText: 'DD/MM/YYYY',
                                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              controller: TextEditingController(
                                text: _tanggalPengembalian == null ? '' : _dateFormat.format(_tanggalPengembalian!),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),
                      const Text("Jumlah Produk yang Disewa", style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          initialValue: _jumlahStok.toString(),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            prefixIcon: const Icon(Icons.inventory),
                            hintText: 'Jumlah',
                            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _jumlahStok = int.tryParse(value) ?? 1;
                            });
                          },
                        ),
                      ),


                      const SizedBox(height: 16),

                      const Text("Deskripsi Detail Produk", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 8),
                      const Text("Tenda Biru"),
                      const Text("Jenis : Produk sewa"),
                      const Text("Kapasitas tidur : 2P (dua orang)"),
                      
                      const SizedBox(height: 20),
                      const Text("Produk ini disewakan.\nItem yang disewakan sesuai ketersediaan.\nSilahkan ambil dan kembalikan sesuai jadwal sewa booking Anda."),

                      const SizedBox(height: 20),
                      const Text("Review Produk", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 12),
                      buildReview(_reviews[_currentReviewIndex]),



                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            if (_tanggalSewa != null && _tanggalPengembalian != null) {
              product["stok"] = _jumlahStok;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentPage(
                    product: widget.product,
                  ),
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amberAccent,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text(
            'Bayar Sewa Produk',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
