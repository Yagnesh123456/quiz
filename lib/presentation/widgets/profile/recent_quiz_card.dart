import 'package:flutter/material.dart';
import 'package:quiz/configs/configs.dart';
import 'package:quiz/data/models/models.dart';
import 'package:quiz/presentation/widgets/common/icon_with_text.dart';
import 'package:quiz/presentation/widgets/common/sizebox_space.dart';

class RecentQuizCard extends StatelessWidget {
  const RecentQuizCard({Key? key, required this.recentTest}) : super(key: key);

  final RecentTest recentTest;

  @override
  Widget build(BuildContext context) {
    const double _padding = 10.0;
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: Theme.of(context).cardColor),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(_padding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: UIParameters.cardBorderRadius,
                  child: ColoredBox(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    child: recentTest.paperimage == null
                        ? const SizedBox(
                            width: 40,
                            height: 40,
                          )
                        : SizedBox(
                            width: 40,
                            height: 40,
                            child: Image.network(
                              recentTest.paperimage!,
                              fit: BoxFit.cover,
                            )),
                  ),
                ),
                horizontalSpace(
                    width: 12
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recentTest.papername ?? '',
                        style: cardTitleTs(context),
                      ),
                      verticalSpace(
                        height: 10
                      ),
                      DefaultTextStyle(
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(

                            children: [
                              IconWithText(
                                icon: const Icon(
                                  Icons.done_all,
                                  color: Colors.green,
                                ),
                                text: Text(recentTest.correctCount!),
                              ),
                              horizontalSpace(width: 10),
                              IconWithText(
                                icon: const Icon(
                                  Icons.timer,
                                  color: Colors.orange,
                                ),
                                text: Text(recentTest.time!.toString()),
                              ),
                              horizontalSpace(width: 10),
                              IconWithText(
                                icon: const Icon(
                                  Icons.emoji_events_outlined,
                                  color: Colors.purple,
                                ),
                                text: Text(recentTest.points.toString()),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}
