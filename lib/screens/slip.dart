import 'package:flutter/material.dart';
import 'package:testdb/screens/qrcode.dart';

class Slip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
           
            SizedBox(width: 8),
            Text('baby wash'),
            Spacer(),
           
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          
            
          
            SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'รายการ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    _buildItemRow('เครื่องซักผ้า', '50'),
                    _buildItemRow('เครื่องอบผ้า', '-'),
                    _buildItemRow('น้ำยาซักผ้า', '10'),
                    _buildItemRow('น้ำยาปรับผ้านุ่ม', '10'),
                    _buildItemRow('รวม', '70')
                  ],
                ),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Navigate to QR Code page when confirmation is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QrCode()), // Navigate to QRCodePage
                );
              },
              child: Text('ยืนยัน'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color) {
    return Column(
      children: [
        Icon(
          icon,
          size: 40,
          color: color,
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildItemRow(String item, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item,
            style: TextStyle(fontSize: 18),
          ),
          Text(
            price,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

