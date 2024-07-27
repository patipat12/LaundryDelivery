import 'package:flutter/material.dart';
import 'package:testdb/screens/otp.dart';
class Forget extends StatefulWidget {
  const Forget({super.key});

  @override
  _ForgetState createState() => _ForgetState();
  
}

class _ForgetState extends State<Forget> {
  GlobalKey<ScaffoldState>globalKey = GlobalKey<ScaffoldState>();
  @override
  
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: globalKey,
        body: SafeArea(child: Container(
          height: screenSize.height,
          width: screenSize.width,
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Text("Forget Password",
              style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 40.0,
              ),
              
              Padding(padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "โปรดกรอกที่อยู่อีเมล",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,color: Colors.red,
                ),
              ),
              ),
               SizedBox(
                height: 40.0,
              ),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 70.0),
              child: Text(
                "we will send link to reset your password",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,color: Colors.red.shade200,
                ),
              ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal:30.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                hintText: "Enter Email Address",
                

                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  
                ),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(
                    color: Colors.pink,
                  ),
                  )
                  ),
                
                ),
              ),
                 SizedBox(
                height: 40.0,
                
              ),
              Container(
                
                width: screenSize.width*0.5,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(
                    color: Colors.black,
                    blurRadius: 0.5,
                    spreadRadius: 0.3,
                  ),
                  
                    
                  ],
                  borderRadius: BorderRadius.circular(16.0),
                  color: Color.fromARGB(255, 242, 243, 242),
                ),
                
                child: Text("send",
                
               
                

                ),
                
              ),
             TextButton(onPressed: (){
        setState(() {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Otp(),));
          
        });
      },  style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: Color.fromARGB(11, 0, 0, 0),
        backgroundColor: Color.fromARGB(255, 243, 248, 243),
        
        minimumSize:  const Size.fromHeight(60),
      ),

     child: 
    const Text("send"),
    ),
      


            ],
          ),
        )),
      ),
    );
  }
}