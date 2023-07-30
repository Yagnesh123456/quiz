import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quiz/presentation/controllers/auth_controller.dart';
import 'package:quiz/data/models/quiz_paper_model.dart';
import 'package:quiz/data/firebase/firebase_configs.dart';
import 'package:quiz/presentation/pages/home/home_screen.dart';
import 'package:quiz/presentation/pages/quiz/result_screen.dart';
import 'package:quiz/presentation/widgets/dialogs/dialogs.dart';
import 'package:quiz/app/utils/logger.dart';

import 'quiz_papers_controller.dart';

class QuizController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  final allQuestions = <Question>[];
  late QuizPaperModel quizPaperModel;
  Timer? _timer;
  int remainSeconds = 1;
  final time = '00:00'.obs;
  var consumedData = 0.0.obs;

  @override
  void onReady() {
    final _quizePaprer = Get.arguments as QuizPaperModel;
    loadData(_quizePaprer);
    super.onReady();
  }

  @override
  void onClose() {
    if(_timer != null){
      _timer!.cancel();
    }
    super.onClose();
  }

  

  Future<bool> onExitOfQuiz() async{
    return Dialogs.quizEndDialog( );
  }

  void _startTimer(int seconds) {
    const duration =   Duration(seconds: 1);
    remainSeconds = seconds;
    _timer =  Timer.periodic(
      duration,
      (Timer timer) {
        if (remainSeconds == 0) {
          showTimesUpAlertDialog();
          timer.cancel();

        } else {
          int minutes = remainSeconds~/60;
          int seconds = (remainSeconds%60);
          time.value = minutes.toString().padLeft(2,"0")+":"+seconds.toString().padLeft(2,"0");
         remainSeconds--;
        }
      },
    );
    
  }

 
  void loadData(QuizPaperModel quizPaper) async {
    quizPaperModel = quizPaper;
    loadingStatus.value = LoadingStatus.loading;
    try {
      final QuerySnapshot<Map<String, dynamic>> questionsQuery =
          await quizePaperFR.doc(quizPaper.id).collection('questions').get();
      final questions = questionsQuery.docs
          .map((question) => Question.fromSnapshot(question))
          .toList();
      quizPaper.questions = questions;
      for (Question _question in quizPaper.questions!) {
        final QuerySnapshot<Map<String, dynamic>> answersQuery =
            await quizePaperFR
                .doc(quizPaper.id)
                .collection('questions')
                .doc(_question.id)
                .collection('answers')
                .get();
        final answers = answersQuery.docs
            .map((answer) => Answer.fromSnapshot(answer))
            .toList();
        _question.answers = answers;
      }
    } on Exception catch (e) {
      RegExp exp =  RegExp(r'permission-denied', caseSensitive: false, ); 
      if(e.toString().contains(exp)){
         AuthController _authController = Get.find();
         Get.back();
        _authController.showLoginAlertDialog();
      }
      Logger.get().log(e);
      loadingStatus.value = LoadingStatus.error;
    } catch (e) {
      loadingStatus.value = LoadingStatus.error;
      Logger.get().log(e);
    }

    if (quizPaper.questions != null && quizPaper.questions!.isNotEmpty) {
      allQuestions.assignAll(quizPaper.questions!);
      currentQuestion.value = quizPaper.questions![0];
      _startTimer(quizPaper.timeSeconds);
      loadingStatus.value = LoadingStatus.completed;
    } else {
      loadingStatus.value = LoadingStatus.noReult;
    }

    questionIndex.listen((index) {
        consumedData.value = questionIndex.value / allQuestions.length;
    });
  }

  Rxn<Question> currentQuestion = Rxn<Question>();
  final questionIndex = 0.obs; //_curruntQuestionIndex

  bool get isFirstQuestion => questionIndex.value > 0;

  bool get islastQuestion => questionIndex.value >= allQuestions.length - 1;


  void nextQuestion() {
    if (questionIndex.value >= allQuestions.length - 1) return;
    questionIndex.value++;
    currentQuestion.value = allQuestions[questionIndex.value];
  }

  void prevQuestion() {
    if (questionIndex.value <= 0){
     return;
    } 
    questionIndex.value--;
    currentQuestion.value = allQuestions[questionIndex.value];
  }
  

  void jumpToQuestion(int index, {bool isGoBack = true}){
    questionIndex.value = index;
    currentQuestion.value = allQuestions[index];
    if(isGoBack) {
      Get.back();
    }
  }

  void selectAnswer(String? answer) {
    currentQuestion.value!.selectedAnswer = answer;
    update(['answers_list', 'answers_review_list']);
  }

  String get completedQuiz{
    final answeredQuestionCount = allQuestions.where((question) => question.selectedAnswer != null).toList().length;
    return '$answeredQuestionCount out of ${allQuestions.length} answered';
  }

  void complete(){
     _timer!.cancel();
     Get.offAndToNamed(ResultScreen.routeName);
  }

  void tryAgain(){
     Get.find<QuizPaperController>().navigatoQuestions(paper: quizPaperModel, isTryAgain: true);
  }

  void showTimesUpAlertDialog() {
    Get.dialog(
      Dialogs.quizTimeUpDialog(onTap: (){
        Get.back();
        Get.offAndToNamed(HomeScreen.routeName);
      }),
      barrierDismissible: false,
    );
  }

  void navigateToHome(){
     _timer!.cancel();
     Get.offNamedUntil(HomeScreen.routeName, (route) => false);
  }

  void checkAnswerSelectedOrNot(String? identifier, int index) {

    if(currentQuestion
        .value?.alreadySelectedAnswer == null || currentQuestion
        .value?.alreadySelectedAnswer == false ){
      currentQuestion
          .value?.alreadySelectedAnswer = true;
      selectAnswer(identifier);

    }

  }


}