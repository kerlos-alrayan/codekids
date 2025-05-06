import 'package:codekids/core/utils/app_router.dart';
import 'package:codekids/features/games/data/games_model.dart';
import 'package:codekids/features/games/presentation/views/widgets/custom_icon_game_info.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/styles.dart';

class GamesListViewBody extends StatelessWidget {
  const GamesListViewBody({
    super.key,
    required this.game,
  });
  final GameModel game;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 32),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(game.image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.kSortingGame);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      game.title,
                      style: Styles.textStyle18.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            CustomIconGameInfo(
              infoIcon: game.infoIcon,
              onPlay: () => GoRouter.of(context).push(game.route),
            ),
          ],
        ),
      ],
    );
  }
}
