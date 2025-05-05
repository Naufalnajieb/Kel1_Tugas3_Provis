import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'payment.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> selectedProducts;

  const CartPage({super.key, required this.selectedProducts});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<DateTime?> startDates = [];
  List<DateTime?> endDates = [];
  List<int> quantities = [];

  @override
  void initState() {
    super.initState();
    startDates = List<DateTime?>.filled(widget.selectedProducts.length, null);
    endDates = List<DateTime?>.filled(widget.selectedProducts.length, null);
    quantities = List<int>.filled(widget.selectedProducts.length, 1);
  }

  Future<void> _selectDate(BuildContext context, int index, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startDates[index] = picked;
          // Reset end date jika tanggal mulai berubah
          if (endDates[index] != null && picked.isAfter(endDates[index]!)) {
            endDates[index] = null;
          }
        } else {
          // Validasi: hanya izinkan jika tanggal pengembalian setelah tanggal sewa
          if (startDates[index] != null && picked.isAfter(startDates[index]!)) {
            endDates[index] = picked;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Tanggal pengembalian harus setelah tanggal sewa')),
            );
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd/MM/yyyy');

    return Scaffold(
      backgroundColor: Colors.white, // Background putih
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text('Product Cart Page', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.selectedProducts.length,
        itemBuilder: (context, index) {
          final product = widget.selectedProducts[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product['name'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(product['image'] ?? '', width: 90, height: 90, fit: BoxFit.cover),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Tanggal Sewa'),
                            const SizedBox(height: 4),
                            GestureDetector(
                              onTap: () => _selectDate(context, index, true),
                              child: AbsorbPointer(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'DD/MM/YYYY',
                                    prefixIcon: const Icon(Icons.calendar_today, size: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                  ),
                                  controller: TextEditingController(
                                    text: startDates[index] != null
                                        ? formatter.format(startDates[index]!)
                                        : '',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text('Tanggal Pengembalian'),
                            const SizedBox(height: 4),
                            GestureDetector(
                              onTap: () => _selectDate(context, index, false),
                              child: AbsorbPointer(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'DD/MM/YYYY',
                                    prefixIcon: const Icon(Icons.calendar_today, size: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                  ),
                                  controller: TextEditingController(
                                    text: endDates[index] != null
                                        ? formatter.format(endDates[index]!)
                                        : '',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Text('Stok'),
                                const SizedBox(width: 12),
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() {
                                      if (quantities[index] > 1) {
                                        quantities[index]--;
                                      }
                                    });
                                  },
                                ),
                                Text(quantities[index].toString()),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      quantities[index]++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            List<Map<String, dynamic>> checkoutData = [];

            for (int i = 0; i < widget.selectedProducts.length; i++) {
              checkoutData.add({
                'product': widget.selectedProducts[i],
                'startDate': startDates[i],
                'endDate': endDates[i],
                'quantity': quantities[i],
              });
            }
            print(checkoutData);  

            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PaymentPage(product: checkoutData)),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Bayar Sewa Produk', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward),
            ],
          ),
        ),
      ),
    );
  }
}