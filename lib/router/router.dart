import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:simple_flashcard/domain/models/card_model.dart';
import 'package:simple_flashcard/domain/models/deck_model.dart';
import 'package:simple_flashcard/domain/state/deck_card_overview/deck_card_overview_bloc.dart';
import 'package:simple_flashcard/presentation/screens/collections_screen.dart';
import 'package:simple_flashcard/presentation/screens/card_edit_screen.dart';
import 'package:simple_flashcard/presentation/screens/card_list_screen.dart';
import 'package:simple_flashcard/presentation/screens/card_detail_screen.dart';
import 'package:simple_flashcard/presentation/screens/deck_status_screen.dart';
import 'package:simple_flashcard/presentation/screens/home_screen.dart';
import 'package:simple_flashcard/presentation/screens/overview_done_screen.dart';
import 'package:simple_flashcard/presentation/screens/overview_screen.dart';
import 'package:simple_flashcard/presentation/screens/root_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: CardListRoute.page),
        AutoRoute(page: OverviewRoute.page),
        AutoRoute(page: CardDetailRoute.page),
        AutoRoute(page: CardEditRoute.page),
        AutoRoute(page: DeckStatusRoute.page),
        CustomRoute(
          page: OverviewDoneRoute.page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
        AutoRoute(
          path: '/',
          page: RootRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page, path: 'home'),
            AutoRoute(page: CollectionsRoute.page, path: 'browser'),
          ],
        ),
      ];
}
