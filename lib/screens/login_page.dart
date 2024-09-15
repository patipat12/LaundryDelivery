import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:testdb/screens/main_home_owner_shop.dart';
import 'package:testdb/screens/register.dart';
import 'package:testdb/screens/forget.dart';
import 'package:testdb/utility/app_constant.dart';
import 'package:testdb/utility/app_dialog.dart';
import 'package:testdb/utility/app_service.dart';
import 'package:testdb/widgets/widget_button.dart';
import 'package:testdb/widgets/widget_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Color mycolor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mycolor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: mycolor,
        image: DecorationImage(
            image: const AssetImage("assets/images/Login.png"),
            fit: BoxFit.cover,
            colorFilter:
                ColorFilter.mode(mycolor.withOpacity(0.2), BlendMode.dstATop)),
      ),
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Stack(
          children: [
            Positioned(top: 80, child: _buildTop()),
            Positioned(
              bottom: 0,
              child: _buildBottom(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.water_drop_sharp,
            size: 100,
            color: Color.fromARGB(255, 244, 231, 231),
          ),
          Text(
            "",
            style: TextStyle(
                color: Color.fromARGB(31, 18, 1, 1),
                fontWeight: FontWeight.bold,
                fontSize: 40,
                letterSpacing: 5),
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: keyForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ซักรีดออนไลน์",
            style: TextStyle(
                color: mycolor, fontSize: 32, fontWeight: FontWeight.w500),
          ),

          const Text("Please Login with your in fromation"),

          const SizedBox(height: 60),
          _buildGreyText("Email Address"),

          //_buildInputField(emailController),
          WidgetForm(
            controller: emailController,
            validator: (p0) {
              if (p0?.isEmpty ?? true) {
                return 'โปรดกรอกอีเมล';
              } else {
                return null;
              }
            },
          ),

          const SizedBox(height: 40),
          _buildGreyText("Password"),

          // _buildInputField(passwordController,isPassword: true),
          WidgetForm(
            controller: passwordController,
            validator: (p0) {
              if (p0?.isEmpty ?? true) {
                return 'โปรดกรอกรหัสผ่าน';
              } else {
                return null;
              }
            },
          ),

          const SizedBox(height: 30),

          _buildRememberForget(),

          const SizedBox(height: 20),
          _buildLoginButton(),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetButton(
                onPressed: () {
                  TextEditingController emailControllre =
                      TextEditingController();
                  TextEditingController passwordController =
                      TextEditingController();

                  AppDialog().normalDialog(
                      title: 'ลงชื่อใช้งาน',
                      contentWidget: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('สำหรับเจ้าของร้านเท่านั้น'),
                          const SizedBox(
                            height: 16,
                          ),
                          WidgetForm(
                            controller: emailControllre,
                            hintText: 'Email :',
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          WidgetForm(
                            controller: passwordController,
                            hintText: 'Password :',
                            //obscureText: true,
                          ),
                        ],
                      ),
                      firstAction: WidgetButton(
                          onPressed: () {
                             Get.back();
                           

                            if ((emailControllre.text.isEmpty) ||
                                (passwordController.text.isEmpty)) {
                              Get.snackbar('กรุณากรอกให้ครบ', 'กรอกข้อมูล',
                                  backgroundColor: GFColors.DANGER,
                                  colorText: GFColors.WHITE);
                            } else if ((emailControllre.text !=
                                    AppConstant.ownerShopLogin['email']) ||
                                (passwordController.text !=
                                    AppConstant.ownerShopLogin['password'])) {
                              Get.snackbar(
                                  'Login False', 'Emailหรือpassword ผิด',
                                  backgroundColor: GFColors.DANGER,
                                  colorText: GFColors.WHITE);
                            } else {
                              Get.offAll(const MainHomeOwnerShop());
                            }
                          },
                          text: 'Login'));
                },
                text: "สำหรับเจ้าของร้าน",
                type: GFButtonType.transparent,
              ),
            ],
          ),
          // const SizedBox(height: 16),
          //_buildOtherLogin(),
        ],
      ),
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Color.fromARGB(255, 44, 16, 99)),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword ? Icon(Icons.remove_red_eye) : Icon(Icons.done),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildRememberForget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WidgetButton(
          text: 'สมัครสมาชิก',
          onPressed: () {
            Get.to(const Register());
          },
          type: GFButtonType.transparent,
          textStyle: const TextStyle(fontSize: 15, color: Colors.blue),
        ),
        WidgetButton(
          text: 'ลืมรหัสผ่าน',
          onPressed: () {
            Get.to(Forget());
          },
          type: GFButtonType.transparent,
          textStyle: const TextStyle(fontSize: 15, color: Colors.blue),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        if (keyForm.currentState!.validate()) {}

        // debugPrint("Email :${emailController.text}");
        // debugPrint("Password : ${passwordController.text}");
        // setState(() {
        //   Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));
        // });

        AppServicr().processCheckLogin(
            email: emailController.text, password: passwordController.text);
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: mycolor,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text("LOGIN"),
    );
  }

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          _buildGreyText(""),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Tab(
                icon: Image.asset("assets/images/Login.png"),
              )
            ],
          )
        ],
      ),
    );
  }
}
