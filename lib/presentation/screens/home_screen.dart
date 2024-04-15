import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_flashcard/domain/state/deck_list/deck_list_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:simple_flashcard/router/router.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hello Jhiven!',
          style: theme.textTheme.headlineMedium!.copyWith(
            color: theme.colorScheme.secondary,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 14),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.png'),
              radius: 24,
            ),
          )
        ],
      ),
      body: BlocBuilder<DeckListBloc, DeckListState>(
        builder: (context, state) {
          switch (state) {
            case DeckListInitial():
              return const Center(child: CircularProgressIndicator());
            case DeckListSuccess():
              return ListView.builder(
                itemCount: state.deckList.length,
                itemBuilder: (context, index) {
                  final deck = state.deckList[index];
                  return ListTile(
                    onTap: () {
                      context.router.push(DeckStatusRoute(deck: deck));
                    },
                    title: Text(deck.title),
                  );
                },
              );
            case DeckListFailure():
              return Text(state.errorMsg);
          }
        },
      ),
    );
  }
}
