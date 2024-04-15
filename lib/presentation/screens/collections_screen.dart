import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_flashcard/domain/state/deck_list/deck_list_bloc.dart';
import 'package:simple_flashcard/presentation/widgets/deck_edit_dialog.dart';
import 'package:simple_flashcard/presentation/widgets/deck_list_tile.dart';

@RoutePage()
class CollectionsScreen extends StatelessWidget {
  const CollectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deck collections'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDeckDialog(context);
        },
        child: const Icon(Icons.add),
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
                  return DeckListTile(deck: state.deckList[index]);
                },
              );
            case DeckListFailure():
              return Text(state.errorMsg);
          }
        },
      ),
    );
  }

  Future<void> _showAddDeckDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return DeckEditDialog();
      },
    );
  }
}
