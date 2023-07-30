import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/configs/themes/app_colors.dart';
import 'package:quiz/presentation/pages/home/home_screen.dart';
import 'package:quiz/presentation/widgets/common/circle_button.dart';
import 'package:quiz/app/utils/language_constant.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({Key? key}) : super(key: key);
  static const String routeName = '/introduction';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(gradient: mainGradient(context)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.warning_amber_sharp,
                size: 65,
                color: kOnSurfaceTextColor,
              ),
              const SizedBox(
                height: 40,
              ),
               Text(
                LANG_CONST.APP_INTRODUCTION.toString().tr,
                //'This is not a production app. This quiz app is made for practical purpose the firebase integrations, state management, and the app flow.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: kOnSurfaceTextColor,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              CircularButton(
                  onTap: () => Get.offAndToNamed(HomeScreen.routeName),
                  child: const Icon(
                    Icons.arrow_forward,
                    size: 35,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
