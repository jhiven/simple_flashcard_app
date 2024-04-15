part of 'deck_edit_bloc.dart';

enum DeckEditStatus { initial, success, failure }

final class DeckEditState extends Equatable {
  final String title;
  final DeckEditStatus status;

  const DeckEditState({
    this.title = '',
    this.status = DeckEditStatus.initial,
  });

  DeckEditState copyWith({
    String? title,
    DeckEditStatus? status,
  }) {
    return DeckEditState(
      title: title ?? this.title,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [title, status];
}

final class DeckEditInitial extends DeckEditState {}
