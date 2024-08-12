import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nemo/app/ui/utils/global_context.dart';
import '../../../controllers/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF50BFFF),
          ),
          child: Form(
            key: GlobalService.formKey,
            child: ListView(
              padding: controller.deviceType.value == 'tablet' ? const EdgeInsets.fromLTRB(20, 20, 20, 0) : const EdgeInsets.all(0),
              children: [
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
                  child: Image.asset(
                    'assets/img/logo.png',
                    width: controller.deviceType.value == 'tablet' ? 300 : 150,
                    height: controller.deviceType.value == 'tablet' ? 300 : 150,
                  ),
                ),
                SizedBox(
                  height: controller.deviceType.value == 'tablet' ? 40 : 0,
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(Get.width * .35, controller.deviceType.value == 'tablet' ? 20 : 10, Get.width * .35, 0),
                      child: Column(
                        children: [
                          TextFormField(
                            // keyboardType: TextInputType.number,
                            validator: (e) {
                              if (e == null || e.isEmpty) {
                                return "Please input NIK";
                              }

                              return null;
                            },
                            controller: controller.nik,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person),
                              labelText: "NIK",
                              labelStyle: const TextStyle(fontSize: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: controller.deviceType.value == 'tablet' ? 20 : 10,
                          ),
                          Obx(
                            () {
                              return TextFormField(
                                validator: (e) {
                                  if (e == null || e.isEmpty) {
                                    return "Please input Password";
                                  }

                                  return null;
                                },
                                onChanged: (e) => controller.password.value = e,
                                obscureText: controller.secureText.value,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock),
                                  labelText: "Password",
                                  labelStyle: const TextStyle(fontSize: 20),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: controller.showHide,
                                    icon: Icon(controller.secureText.value ? Icons.visibility : Icons.visibility_off),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(Get.width * .35, 10, Get.width * .35, 0),
                            child: ElevatedButton(
                              onPressed: () {
                                if (GlobalService.formKey.currentState!.validate()) {
                                  GlobalService.formKey.currentState!.save();
                                  controller.login();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(FontAwesomeIcons.arrowRightToBracket),
                                  Padding(padding: EdgeInsets.all(2)),
                                  Text(
                                    "LOGIN",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
