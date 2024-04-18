import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_flashcard/data/provider/local/drift_database.dart';
import 'package:simple_flashcard/data/repository/card_item_repository.dart';
import 'package:simple_flashcard/data/repository/deck_repository.dart';
import 'package:simple_flashcard/domain/state/deck_list/deck_list_bloc.dart';
import 'package:simple_flashcard/router/router.dart';
import 'package:simple_flashcard/theme/app_theme.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:simple_flashcard/theme/default_colorscheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();
  final appRoute = AppRouter();

  initializeDateFormatting();

  runApp(MainApp(
    db: database,
    appRouter: appRoute,
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
    required this.db,
    required this.appRouter,
  });

  final AppDatabase db;
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => DeckRepository(db: db),
        ),
        RepositoryProvider(
          create: (context) => CardItemRepository(db: db),
        ),
      ],
      child: BlocProvider(
        create: (context) => DeckListBloc(
          deckRepository: context.read<DeckRepository>(),
        )..add(DeckListFetchRequested()),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter.config(),
          themeMode: ThemeMode.light,
          theme: AppTheme.getTheme(
            colorScheme: DefaultColorScheme.lightScheme,
          ),
          darkTheme: AppTheme.getTheme(
            colorScheme: DefaultColorScheme.darkScheme,
          ),
        ),
      ),
    );
  }
}
