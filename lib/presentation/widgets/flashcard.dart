import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_flashcard/data/provider/local/card_item.dart';

class Flashcard extends StatelessWidget {
  const Flashcard({
    super.key,
    required this.front,
    required this.back,
    required this.isOpen,
    this.answeredAt,
    this.createdAt,
    this.answerType,
    this.showDetail = false,
  });

  final String front;
  final String back;
  final bool isOpen;
  final DateTime? answeredAt;
  final DateTime? createdAt;
  final AnswerType? answerType;
  final bool showDetail;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  front,
                  style: theme.textTheme.headlineSmall!.copyWith(
                    color: theme.colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
            ],
          ),
          if (isOpen)
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Text(
                            back,
                            style: theme.textTheme.bodyLarge!.copyWith(
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (showDetail) ..._buildDetail(theme),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildDetail(ThemeData theme) {
    return [
      const SizedBox(
        height: 12,
      ),
      if (createdAt != null)
        Text(
          'Card created date: ${DateFormat.yMMMMEEEEd().add_jm().format(createdAt!)}',
          style: theme.textTheme.bodySmall!.copyWith(
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
      Text(
        'Last answered date: ${answeredAt == null ? 'Unanswered' : DateFormat.yMMMMEEEEd().add_jm().format(answeredAt!)}',
        style: theme.textTheme.bodySmall!.copyWith(
          color: theme.colorScheme.onPrimaryContainer,
        ),
      ),
      Text(
        'Last answered type: ${answerType == null ? 'Unanswered' : answerType!.name}',
        style: theme.textTheme.bodySmall!.copyWith(
          color: theme.colorScheme.onPrimaryContainer,
        ),
      ),
    ];
  }
}
