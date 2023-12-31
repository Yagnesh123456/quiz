import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:quiz/configs/themes/custom_text_styles.dart';
import 'package:quiz/presentation/controllers/controllers.dart';
import 'package:quiz/data/firebase/firebase_configs.dart';
import 'package:quiz/data/models/models.dart';
import 'package:quiz/presentation/widgets/common/content_area.dart';
import 'package:quiz/presentation/widgets/common/custom_app_bar.dart';
import 'package:quiz/presentation/widgets/common/icon_with_text.dart';
import 'package:quiz/presentation/widgets/common/screen_background_decoration.dart';
import 'package:quiz/presentation/widgets/common/sizebox_space.dart';
import 'package:quiz/presentation/widgets/loading_shimmers/leaderboard_placeholder.dart';
import 'package:quiz/app/utils/language_constant.dart';

class LeaderBoardScreen extends GetView<LeaderBoardController> {
  LeaderBoardScreen({Key? key}) : super(key: key) {
    SchedulerBinding.instance.addPostFrameCallback((d) {
      final paper = Get.arguments as QuizPaperModel;
      controller.getAll(paper.id);
      controller.getMyScores(paper.id);
    });
  }

  static const String routeName = '/leaderboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      bottomNavigationBar: Obx(() => controller.myScores.value == null
          ? const SizedBox()
          : LeaderBoardCard(
              data: controller.myScores.value!,
              index: -1,
            )),
      body: Center(
        child: BackgroundDecoration(
          showGradient: true,
          child: Obx(
            () => controller.loadingStatus.value == LoadingStatus.loading
                ? const ContentArea(
                    addPadding: true,
                    child: LeaderBoardPlaceHolder(),
                  )
                : ContentArea(
                    addPadding: false,
                    child: controller.leaderBoard.isNotEmpty ?
                    ListView.separated(
                      itemCount: controller.leaderBoard.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                      itemBuilder: (BuildContext context, int index) {
                        final data = controller.leaderBoard[index];
                        return LeaderBoardCard(
                          data: data,
                          index: index,
                        );
                      },
                    )
                        :  Center(
                          child: Text(
                      LANG_CONST.NO_RECORD_FOUND.toString().tr,
                      style: kQuizeTS,
                    ),
                        ),
                  ),
          ),
        ),
      ),
    );
  }
}

class LeaderBoardCard extends StatelessWidget {
  const LeaderBoardCard({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  final LeaderBoardData data;
  final int index;

  @override
  Widget build(BuildContext context) {
    const tsStyle = TextStyle(fontWeight: FontWeight.bold);
    return ListTile(
      leading: CircleAvatar(
        foregroundImage:
            data.user.image == null ? null : NetworkImage(data.user.image!),
      ),
      title: Text(
        data.user.name,
        style: tsStyle,
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          IconWithText(
            icon: Icon(
              Icons.done_all,
              color: Theme.of(context).primaryColor,
            ),
            text: Text(
              data.correctCount!,
              style: tsStyle,
            ),
          ),
          horizontalSpace(width: 12),
          IconWithText(
            icon: Icon(
              Icons.timer,
              color: Theme.of(context).primaryColor,
            ),
            text: Text(
              '${data.time!}',
              style: tsStyle,
            ),
          ),
          horizontalSpace(
            width: 12.0
          ),
          IconWithText(
            icon: Icon(
              Icons.emoji_events_outlined,
              color: Theme.of(context).primaryColor,
            ),
            text: Text(
              '${data.points!}',
              style: tsStyle,
            ),
          ),
        ],
      ),
      trailing: Text(
        '#' + '${index + 1}'.padLeft(2, "0"),
        style: tsStyle,
      ),
    );
  }
}
