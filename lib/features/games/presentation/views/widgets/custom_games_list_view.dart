import 'package:codekids/features/games/presentation/views/widgets/custom_games_list_view_body.dart';
import 'package:flutter/material.dart';

import '../../../data/games_data.dart';

class CustomGamesListView extends StatelessWidget {
  const CustomGamesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: games.length,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        final game = games[index];
        return GamesListViewBody(game: game); // مرر الداتا هنا
      },
    );
  }
}
