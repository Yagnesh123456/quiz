import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quiz/configs/configs.dart';
import 'package:quiz/presentation/controllers/controllers.dart';
import 'package:quiz/presentation/widgets/common/content_area.dart';
import 'package:quiz/presentation/widgets/common/custom_app_bar.dart';
import 'package:quiz/presentation/widgets/common/main_button.dart';
import 'package:quiz/presentation/widgets/common/screen_background_decoration.dart';
import 'package:quiz/presentation/widgets/quiz/answer_card.dart';
import 'package:quiz/presentation/widgets/quiz/quize_number_card.dart';
import 'package:quiz/app/utils/language_constant.dart';

import 'answer_check_screen.dart';

class ResultScreen extends GetView<QuizController> {
  const ResultScreen({Key? key}) : super(key: key);

  static const String routeName = '/resultscreen';

  @override
  Widget build(BuildContext context) {
    final Color _textColor = UIParameters.isDarkMode(context)
        ? Colors.white
        : Theme.of(context).primaryColor;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: BackgroundDecoration(
          child: Column(
            children: [
              CustomAppBar(
                leading: const SizedBox(height: kToolbarHeight,),
                title: controller.correctAnsweredQuestions,
              ),
              Expanded(
                child: ContentArea(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/bulb.svg'),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      child: Text(
                        LANG_CONST.CONGRATULATIONS.toString().tr,
                        style: kHeaderTS.copyWith(color: _textColor),
                      ),
                    ),
                    Text(
                      LANG_CONST.YOU_HAVE_GOT_POINTS.toString().tr
                          .replaceAll("XXXXXX", controller.points),
                      style: TextStyle(color: _textColor),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                     Text(
                      LANG_CONST.TAP_BELOW_QUESTION_NUMBER.toString().tr,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Expanded(
                        child: GridView.builder(
                            itemCount: controller.allQuestions.length,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        UIParameters.getWidth(context) ~/ 75,
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (_, index) {
                              final _question = controller.allQuestions[index];

                              AnswerStatus _status = AnswerStatus.notanswered;

                              final _selectedAnswer = _question.selectedAnswer;
                              final _correctAnswer = _question.correctAnswer;

                              if (_selectedAnswer == _correctAnswer) {
                                _status = AnswerStatus.correct;
                              } else if (_question.selectedAnswer == null) {
                                _status = AnswerStatus.wrong;
                              } else {
                                _status = AnswerStatus.wrong;
                              }

                              return QuizNumberCard(
                                index: index + 1,
                                status: _status,
                                onTap: () {
                                  controller.jumpToQuestion(index,
                                      isGoBack: false);
                                  Get.toNamed(AnswersCheckScreen.routeName);
                                },
                              );
                            }))
                  ],
                )),
              ),
              ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                    padding: UIParameters.screenPadding,
                    child: Row(
                      children: [
                        Expanded(
                            child: MainButton(
                              color: Colors.blueGrey,
                          onTap: () {
                           controller.tryAgain();
                          },
                          title: LANG_CONST.RETAKE.toString().tr,
                        )),
                        const SizedBox(width: 5,),
                        Expanded(
                            child: MainButton(
                          onTap: () {
                            controller.saveQuizResults();
                          },
                          title: LANG_CONST.GO_TO_HOME.toString().tr,
                        ))
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
