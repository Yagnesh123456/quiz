import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/configs/configs.dart';
import 'package:quiz/controllers/controllers.dart';
import 'package:quiz/firebase/loading_status.dart';
import 'package:quiz/screens/quiz/quiz_overview_screen.dart';
import 'package:quiz/utils/language_constant.dart';
import 'package:quiz/widgets/widgets.dart';

class QuizeScreen extends GetView<QuizController> {
  const QuizeScreen({Key? key}) : super(key: key);

  static const String routeName = '/quizescreen';


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onExitOfQuiz,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: CustomAppBar(
            leading: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Obx(
                () => CountdownTimer(
                  time: controller.time.value,
                  color: kOnSurfaceTextColor,
                ),
              ),
              decoration: const ShapeDecoration(
                shape: StadiumBorder(
                    side: BorderSide(color: kOnSurfaceTextColor, width: 2)),
              ),
            ),
            showActionIcon: true,
            titleWidget: Obx(() => Text(
                  '${LANG_CONST.Q.toString().tr} ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}',
                  style: kAppBarTS,
                )),
          ),
          body: BackgroundDecoration(
            child: Obx(
              () => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:kMobileScreenPadding,right: kMobileScreenPadding),
                    child: LinearProgressIndicator(
                      value: controller.consumedData.value,
                    ),
                  ),
                  if (controller.loadingStatus.value == LoadingStatus.loading)
                    const Expanded(
                        child: ContentArea(child: QuizScreenPlaceHolder())),
                  if (controller.loadingStatus.value == LoadingStatus.completed)
                    Expanded(
                      child: ContentArea(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Text(
                                controller.currentQuestion.value!.question,
                                style: kQuizeTS,
                              ),
                              GetBuilder<QuizController>(
                                  id: 'answers_list',
                                  builder: (context) {
                                    return ListView.separated(
                                      itemCount: controller.currentQuestion
                                          .value!.answers.length,
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.only(top: 25),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const SizedBox(
                                          height: 10,
                                        );
                                      },
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final answer = controller
                                            .currentQuestion
                                            .value!
                                            .answers[index];

                                        final selectedAnswer = controller
                                            .currentQuestion.value?.selectedAnswer;
                                        final correctAnswer = controller
                                            .currentQuestion.value?.correctAnswer;

                                        final String answerText =
                                            '${answer.identifier}. ${answer.answer}';

                                        if (correctAnswer == selectedAnswer &&
                                            answer.identifier == selectedAnswer) {
                                          return CorrectAnswerCard(
                                              answer: answerText);
                                        }  else if (correctAnswer != selectedAnswer &&
                                            answer.identifier == selectedAnswer) {
                                          return WrongAnswerCard(answer: answerText);
                                        } else if (selectedAnswer != null && correctAnswer ==
                                            answer.identifier) {
                                          return CorrectAnswerCard(
                                              answer: answerText);
                                        }

                                        return AnswerCard(
                                          isSelected: answer.identifier ==
                                              controller.currentQuestion.value!
                                                  .selectedAnswer,
                                          onTap: () {
                                            controller.checkAnswerSelectedOrNot(answer.identifier, index);
                                          },
                                          answer:
                                              '${answer.identifier}. ${answer.answer}',
                                        );
                                      },
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ColoredBox(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Padding(
                      padding: UIParameters.screenPadding,
                      child: Row(
                        children: [
                          Visibility(
                            visible: controller.isFirstQuestion,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: SizedBox(
                                height: 55,
                                width: 55,
                                child: MainButton(
                                  onTap: () {
                                    controller.prevQuestion();
                                  },
                                  child: const Icon(Icons.arrow_back_ios_new),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Obx(
                              () => Visibility(
                                visible: controller.loadingStatus.value == LoadingStatus.completed,
                                child: MainButton(
                                  onTap: () {
                                    controller.islastQuestion ?  Get.toNamed(QuizOverviewScreen.routeName) : controller.nextQuestion();
                                  },
                                  title: controller.islastQuestion ? LANG_CONST.COMPLETE.toString().tr : LANG_CONST.NEXT.toString().tr,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
