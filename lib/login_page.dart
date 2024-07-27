import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testdb/register.dart';


class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  late Color mycolor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;
  String check="";

    final IP = '192.168.1.243';

 void checkLogin(String pw, String eml) async {
    try {
      String url =
          "http://${IP}/flutter_login/login.php?password=$pw&email=$eml";

      print(url);
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'Charset': 'utf-8'
      });
      if (response.statusCode == 200) {
        var rs = response.body.replaceAll('ï»¿', '');
        var rsLogin = convert.jsonDecode(rs);

        setState(() {
          check = rsLogin['login'];
          if (check.contains('OK')) {
            print('ok');
            //alert สั่งซื้อสำเร็จ
            Navigator.push(context, MaterialPageRoute(builder: (context) => Register(),));
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
    mycolor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: mycolor,
        image: DecorationImage(image: const AssetImage("assets/images/Login.png"),
        fit: BoxFit.cover,
        colorFilter:ColorFilter.mode(mycolor.withOpacity(0.2), BlendMode.dstATop)

        
        ),
        
      ),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 63, 236, 233),
        body: Stack(children: [
          Positioned(top: 80,child: _buildTop()),
          Positioned(bottom: 0,child: _buildBottom(), )

        ],),
      ),
    );
  }

  Widget _buildTop(){
    return SizedBox(
      width: mediaSize.width,
      child:  const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.location_on_sharp,
          size: 100,
          color: Color.fromARGB(255, 21, 162, 49),
          ),
          Text("ร้านซักรีด",style: TextStyle(
            color: Color.fromARGB(31, 4, 49, 232),
            fontWeight: FontWeight.bold,
            fontSize: 40,
            letterSpacing: 2
          ),)

        ],
      ),
    );


  }
  Widget _buildBottom(){
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),

          )
        ),
        child:  Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );

  }
  Widget _buildForm(){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Welcomes",style: TextStyle(
          color: mycolor,
          fontSize: 32,
          fontWeight: FontWeight.w500
        ),
        ),
        Text("Please Loginwith yourinfromation"),
        const SizedBox(height: 60),
        _buildGreyText("Email Address"),
        _buildInputField(emailController),
        const SizedBox(height: 40),
        _buildGreyText("Password"),
        _buildInputField(passwordController,isPassword: true),
        const SizedBox(height:30 ),
        _buildRememberForget(),
        const SizedBox(height: 20),
        _buildLoginButton(),
        const SizedBox(height: 20),
        _buildOtherLogin(),
      ],
    );
  }
  Widget _buildGreyText(String text){
    return Text(
      text,
      style: const TextStyle(color: Color.fromARGB(255, 44, 16, 99)),
    );
  }
  Widget _buildInputField(TextEditingController controller,{isPassword = false}){
    return TextField(
      controller: controller,
      decoration:  InputDecoration(
        suffixIcon: isPassword?Icon(Icons.remove_red_eye) : Icon(Icons.done),
      ),
      obscureText:  isPassword,


    );

  }
  Widget _buildRememberForget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Row(
        children: [Checkbox(value: rememberUser, onChanged: (value){
          setState(() {
            rememberUser = value!;
          });


        }),
        _buildGreyText("Remember"),


        ],
      ),
      TextButton(onPressed: (){
       setState(() {
          checkLogin(passwordController.text, emailController.text);
          print('MSU');
       });
      }, child: _buildGreyText("i for got password"))
      ],

    );
  }
  Widget _buildLoginButton(){
    return ElevatedButton(
      onPressed: (){
        // debugPrint("Email :${emailController.text}");
        // debugPrint("Password : ${passwordController.text}");
       setState(() {
         print('MSU');
         checkLogin(passwordController.text, emailController.text);
          
       });
        
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: mycolor,
        minimumSize:  const Size.fromHeight(60),
      ),

     child: 
    const Text("LOGIN"),
    );
  }
  Widget _buildOtherLogin(){
    return Center(
      child: Column(
        children: [
          _buildGreyText(""),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Tab(
                icon:Image.asset("assets/images/Login.png"),
              )
            ],
          )
        ],
      ),
    );
  }
}

