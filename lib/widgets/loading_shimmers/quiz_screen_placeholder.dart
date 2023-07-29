import 'package:flutter/material.dart';
import 'package:quiz/widgets/common/sizebox_space.dart';
import 'package:shimmer/shimmer.dart';

class QuizScreenPlaceHolder extends StatelessWidget {
  const QuizScreenPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    var line = Container(
      width: double.infinity,
      height: 12.0,
      color: Theme.of(context).scaffoldBackgroundColor,
    );

    var answer = Container(
            width: double.infinity,
            height: 50.0,
            color: Theme.of(context).scaffoldBackgroundColor,
          );

    return Shimmer.fromColors(
      baseColor: Colors.white.withOpacity(0.4),
      highlightColor: Colors.blueGrey.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              line,
              verticalSpace(height: 10),
              line,
              verticalSpace(height: 10),
              line,
            ],

          ),
          verticalSpace(height: 20),
          answer,
          verticalSpace(height: 20),
          answer,
          verticalSpace(height: 20),
          answer,
          verticalSpace(height: 20),
          answer,
        ],
      ),
    );
  }


}
