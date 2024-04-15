import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_flashcard/data/repository/card_item_repository.dart';
import 'package:simple_flashcard/domain/state/card_detail/card_detail_bloc.dart';
import 'package:simple_flashcard/presentation/widgets/flashcard.dart';

@RoutePage()
class CardDetailScreen extends StatelessWidget implements AutoRouteWrapper {
  const CardDetailScreen({super.key, required this.cardId});

  final int cardId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocBuilder<CardDetailBloc, CardDetailState>(
          builder: (context, state) {
            switch (state.status) {
              case CardDetailStatus.initial:
                return const Center(child: CircularProgressIndicator());
              case CardDetailStatus.success:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Flashcard(
                        front: state.card!.front,
                        back: state.card!.back,
                        isOpen: true,
                        showDetail: true,
                        answerType: state.card!.answerType,
                        answeredAt: state.card!.answerAt,
                        createdAt: state.card!.createdAt,
                      ),
                    ),
                  ],
                );
              case CardDetailStatus.failure:
                return const Scaffold(
                  body: Text('Error'),
                );
            }
          },
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => CardDetailBloc(
        cardItemRepository: context.read<CardItemRepository>(),
      )..add(CardDetailRequested(cardId: cardId)),
      child: this,
    );
  }
}
