import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController pass=TextEditingController();
  var insertSt="";

  final IP = '192.168.1.243';


 void insertOrder(String un, String pw, String eml) async {
    try {
      String url =
          "http://${IP}/flutter_login/register.php?name=$un&password=$pw&email=$eml";

      print(url);
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'Charset': 'utf-8'
      });
      if (response.statusCode == 200) {
        var rs = response.body.replaceAll('ï»¿', '');
        var rsInsert = convert.jsonDecode(rs);

        setState(() {
          insertSt = rsInsert['add'];
          if (insertSt.contains('OK')) {
            print('ok');
            //alert สั่งซื้อสำเร็จ
          } else {
            //alert มีข้อผิดพลาด
            print('no');
          }
          //Navigator.pop(context);
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
        throw Exception('Failed to load Data');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สมัครสมาชิก'),
      )
      ,body: Column(
        children:  [
          Container(
	padding: EdgeInsets.all(20),
		child:TextField(

      controller: name,
			decoration: InputDecoration(
			border: OutlineInputBorder(),
			hintText: "Username",
			labelText: "Name",
			helperText: "Enter username ",
		),
	)
)
,Container(
	padding: EdgeInsets.all(20),
		child:TextField(

      controller: email,
			decoration: InputDecoration(
			border: OutlineInputBorder(),
			hintText: "Username",
			labelText: "Email",
			helperText: "Enter email ",
		),
	)
)
,Container(
	padding: EdgeInsets.all(20),
		child:TextField(
      controller: pass,
			decoration: InputDecoration(
			border: OutlineInputBorder(),
			hintText: "Username",
			labelText: "Password",
			helperText: "Enter Password ",
		),
	)
),
Container(
  child: IconButton(onPressed: () {
    setState(() {
      insertOrder(name.text, pass.text, email.text);
    });
  }, icon: Icon(Icons.app_registration_rounded,
  size: 50,)),
)



        ],
      ),
    );
    
  }
}


