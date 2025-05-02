import 'package:codekids/core/utils/assets.dart';
import 'package:codekids/core/utils/styles.dart';
import 'package:flutter/material.dart';

class GamesViewBody extends StatelessWidget {
  const GamesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Games',
          style: Styles.textStyle30,
        ),
        const SizedBox(
          height: 32,
        ),
        Expanded(child: CustomGamesListView()),
      ],
    );
  }
}

class CustomGamesListView extends StatelessWidget {
  const CustomGamesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(AssetsData.gamesSorting),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Start Game',
                  style: Styles.textStyle16.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}
