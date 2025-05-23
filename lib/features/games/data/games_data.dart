import 'package:codekids/features/games/data/games_model.dart';

import '../../../core/utils/app_router.dart';
import '../../../core/utils/assets.dart';

final List<GameModel> games = [
  GameModel(
    title: 'Sorting Game',
    image: AssetsData.gamesSorting,
    bgImage: 'assets/images/bg_sorting.png',
    infoIcon: [
      AssetsData.gamesSortingLottie1,
      AssetsData.gamesSortingLottie2,
      'Arrange the code lines in the correct order to complete the program!',
    ],
    route: AppRouter.kSortingGame,
  ),
  GameModel(
    title: 'Scratch Game',
    image: AssetsData.gamesScratch,
    bgImage: 'assets/images/bg_scratch.png',
    infoIcon: [
      AssetsData.gamesSortingLottie1,
      AssetsData.gamesSortingLottie2,
      'Explore coding using colorful Scratch blocks!',
    ],
    route: AppRouter.kSortingGame,
  ),
  GameModel(
    title: 'Demo Game',
    image: AssetsData.gamesDemo,
    bgImage: 'assets/images/bg_scratch.png',
    infoIcon: [
      AssetsData.gamesSortingLottie1,
      AssetsData.gamesSortingLottie2,
      'Demo game',
    ],
    route: AppRouter.kSortingGame,
  ),
];
