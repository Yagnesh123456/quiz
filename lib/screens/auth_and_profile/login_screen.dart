import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quiz/configs/configs.dart';
import 'package:quiz/controllers/auth_controller.dart';
import 'package:quiz/utils/language_constant.dart';
import 'package:quiz/widgets/widgets.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: Container(
          constraints: const BoxConstraints(maxWidth: kTabletChangePoint),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.center,
          decoration: BoxDecoration(gradient: mainGradient(context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/app_splash_logo.svg'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 60),
                child: Text(
                  LANG_CONST.LOREM_TEXT.toString().tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: kOnSurfaceTextColor, fontWeight: FontWeight.bold),
                ),
              ),
              MainButton(
                onTap: () {
                  controller.siginInWithGoogle();
                 },
                color: Colors.white,
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        child: SvgPicture.asset(
                          'assets/icons/google.svg',
                        )),
                    Center(
                      child: Text(
                        LANG_CONST.SIGN_IN_WITH_GOOGLE.toString().tr,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
