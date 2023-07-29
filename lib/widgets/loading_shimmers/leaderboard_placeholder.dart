import 'package:flutter/material.dart';
import 'package:quiz/widgets/common/sizebox_space.dart';
import 'package:shimmer/shimmer.dart';

class LeaderBoardPlaceHolder extends StatelessWidget {
  const LeaderBoardPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var line = Container(
      width: double.infinity,
      height: 8.0,
      color: Theme.of(context).scaffoldBackgroundColor,
    );

    var tile = Row(
      children: [
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            children: [
              line,
              const SizedBox(
                height: 5,
              ),
              line
            ],
          ),
        )
      ],
    );
    return Shimmer.fromColors(
        baseColor: Colors.white.withOpacity(0.4),
        highlightColor: Colors.blueGrey.withOpacity(0.1),
        child: Column(
          children: [
            tile,
            verticalSpace(height: 25),
            tile,
            verticalSpace(height: 25),
            tile,
            verticalSpace(height: 25),
            tile,
            verticalSpace(height: 25),
            tile
          ],
        ));
  }


}
