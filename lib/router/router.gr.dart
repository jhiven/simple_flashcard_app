// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    CardDetailRoute.name: (routeData) {
      final args = routeData.argsAs<CardDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: CardDetailScreen(
          key: args.key,
          cardId: args.cardId,
        )),
      );
    },
    CardEditRoute.name: (routeData) {
      final args = routeData.argsAs<CardEditRouteArgs>(
          orElse: () => const CardEditRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: CardEditScreen(
          key: args.key,
          card: args.card,
          deckId: args.deckId,
        )),
      );
    },
    CardListRoute.name: (routeData) {
      final args = routeData.argsAs<CardListRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: CardListScreen(
          key: args.key,
          deckId: args.deckId,
        )),
      );
    },
    CollectionsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CollectionsScreen(),
      );
    },
    DeckStatusRoute.name: (routeData) {
      final args = routeData.argsAs<DeckStatusRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: DeckStatusScreen(
          key: args.key,
          deck: args.deck,
        )),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    OverviewDoneRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OverviewDoneScreen(),
      );
    },
    OverviewRoute.name: (routeData) {
      final args = routeData.argsAs<OverviewRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: OverviewScreen(
          key: args.key,
          bloc: args.bloc,
        )),
      );
    },
    RootRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RootScreen(),
      );
    },
  };
}

/// generated route for
/// [CardDetailScreen]
class CardDetailRoute extends PageRouteInfo<CardDetailRouteArgs> {
  CardDetailRoute({
    Key? key,
    required int cardId,
    List<PageRouteInfo>? children,
  }) : super(
          CardDetailRoute.name,
          args: CardDetailRouteArgs(
            key: key,
            cardId: cardId,
          ),
          initialChildren: children,
        );

  static const String name = 'CardDetailRoute';

  static const PageInfo<CardDetailRouteArgs> page =
      PageInfo<CardDetailRouteArgs>(name);
}

class CardDetailRouteArgs {
  const CardDetailRouteArgs({
    this.key,
    required this.cardId,
  });

  final Key? key;

  final int cardId;

  @override
  String toString() {
    return 'CardDetailRouteArgs{key: $key, cardId: $cardId}';
  }
}

/// generated route for
/// [CardEditScreen]
class CardEditRoute extends PageRouteInfo<CardEditRouteArgs> {
  CardEditRoute({
    Key? key,
    CardModel? card,
    int? deckId,
    List<PageRouteInfo>? children,
  }) : super(
          CardEditRoute.name,
          args: CardEditRouteArgs(
            key: key,
            card: card,
            deckId: deckId,
          ),
          initialChildren: children,
        );

  static const String name = 'CardEditRoute';

  static const PageInfo<CardEditRouteArgs> page =
      PageInfo<CardEditRouteArgs>(name);
}

class CardEditRouteArgs {
  const CardEditRouteArgs({
    this.key,
    this.card,
    this.deckId,
  });

  final Key? key;

  final CardModel? card;

  final int? deckId;

  @override
  String toString() {
    return 'CardEditRouteArgs{key: $key, card: $card, deckId: $deckId}';
  }
}

/// generated route for
/// [CardListScreen]
class CardListRoute extends PageRouteInfo<CardListRouteArgs> {
  CardListRoute({
    Key? key,
    required int deckId,
    List<PageRouteInfo>? children,
  }) : super(
          CardListRoute.name,
          args: CardListRouteArgs(
            key: key,
            deckId: deckId,
          ),
          initialChildren: children,
        );

  static const String name = 'CardListRoute';

  static const PageInfo<CardListRouteArgs> page =
      PageInfo<CardListRouteArgs>(name);
}

class CardListRouteArgs {
  const CardListRouteArgs({
    this.key,
    required this.deckId,
  });

  final Key? key;

  final int deckId;

  @override
  String toString() {
    return 'CardListRouteArgs{key: $key, deckId: $deckId}';
  }
}

/// generated route for
/// [CollectionsScreen]
class CollectionsRoute extends PageRouteInfo<void> {
  const CollectionsRoute({List<PageRouteInfo>? children})
      : super(
          CollectionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'CollectionsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DeckStatusScreen]
class DeckStatusRoute extends PageRouteInfo<DeckStatusRouteArgs> {
  DeckStatusRoute({
    Key? key,
    required DeckModel deck,
    List<PageRouteInfo>? children,
  }) : super(
          DeckStatusRoute.name,
          args: DeckStatusRouteArgs(
            key: key,
            deck: deck,
          ),
          initialChildren: children,
        );

  static const String name = 'DeckStatusRoute';

  static const PageInfo<DeckStatusRouteArgs> page =
      PageInfo<DeckStatusRouteArgs>(name);
}

class DeckStatusRouteArgs {
  const DeckStatusRouteArgs({
    this.key,
    required this.deck,
  });

  final Key? key;

  final DeckModel deck;

  @override
  String toString() {
    return 'DeckStatusRouteArgs{key: $key, deck: $deck}';
  }
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OverviewDoneScreen]
class OverviewDoneRoute extends PageRouteInfo<void> {
  const OverviewDoneRoute({List<PageRouteInfo>? children})
      : super(
          OverviewDoneRoute.name,
          initialChildren: children,
        );

  static const String name = 'OverviewDoneRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OverviewScreen]
class OverviewRoute extends PageRouteInfo<OverviewRouteArgs> {
  OverviewRoute({
    Key? key,
    required DeckCardOverviewBloc bloc,
    List<PageRouteInfo>? children,
  }) : super(
          OverviewRoute.name,
          args: OverviewRouteArgs(
            key: key,
            bloc: bloc,
          ),
          initialChildren: children,
        );

  static const String name = 'OverviewRoute';

  static const PageInfo<OverviewRouteArgs> page =
      PageInfo<OverviewRouteArgs>(name);
}

class OverviewRouteArgs {
  const OverviewRouteArgs({
    this.key,
    required this.bloc,
  });

  final Key? key;

  final DeckCardOverviewBloc bloc;

  @override
  String toString() {
    return 'OverviewRouteArgs{key: $key, bloc: $bloc}';
  }
}

/// generated route for
/// [RootScreen]
class RootRoute extends PageRouteInfo<void> {
  const RootRoute({List<PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
