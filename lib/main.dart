import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:simple_flashcard/data/provider/local/drift_database.dart';
import 'package:simple_flashcard/data/repository/card_item_repository.dart';
import 'package:simple_flashcard/data/repository/deck_repository.dart';
import 'package:simple_flashcard/domain/state/deck_list/deck_list_bloc.dart';
import 'package:simple_flashcard/router/router.dart';
import 'package:simple_flashcard/theme/app_theme.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:simple_flashcard/theme/colorscheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();
  final appRoute = AppRouter();

  initializeDateFormatting();

  Intl.defaultLocale = 'id';

  await database.into(database.deck).insert(
        DeckCompanion.insert(
          title: 'Agile manifesto',
        ),
      );
  await database.into(database.deck).insert(
        DeckCompanion.insert(
          title: 'Agile principles',
        ),
      );
  await database.into(database.cardItem).insert(
        CardItemCompanion.insert(
          deckId: 1,
          front: 'Agile manifesto no 1',
          back: 'Individuals and interactions',
        ),
      );
  await database.into(database.cardItem).insert(
        CardItemCompanion.insert(
          deckId: 1,
          front: 'Agile manifesto no 2',
          back: 'Working software',
        ),
      );
  await database.into(database.cardItem).insert(
        CardItemCompanion.insert(
          deckId: 1,
          front: 'Agile manifesto no 3',
          back: 'Customer collaboration',
        ),
      );
  await database.into(database.cardItem).insert(
        CardItemCompanion.insert(
          deckId: 1,
          front: 'Agile manifesto no 4',
          back: 'Responding to change',
        ),
      );
  await database.into(database.cardItem).insert(
        CardItemCompanion.insert(
          deckId: 1,
          front: 'Individuals and interaction over...',
          back: 'Tool and processes',
        ),
      );
  await database.into(database.cardItem).insert(
        CardItemCompanion.insert(
          deckId: 1,
          front: 'Working software over...',
          back: 'Comprehensive documentation',
        ),
      );
  await database.into(database.cardItem).insert(
        CardItemCompanion.insert(
          deckId: 1,
          front: 'Customer collaboration over...',
          back: 'Contract and negotiation',
        ),
      );
  await database.into(database.cardItem).insert(
        CardItemCompanion.insert(
          deckId: 1,
          front: 'Responding to change over...',
          back: 'Following plan',
        ),
      );
  await database.into(database.cardItem).insert(
        CardItemCompanion.insert(
          deckId: 2,
          front: "testing ",
          back:
              "The ozone layer in the stratosphere absorbs a portion of the radiation from the sun, preventing it from reaching the planet's surface. Most importantly, it absorbs the portion of UV light called UVB. UVB is a kind of ultraviolet light from the sun (and sun lamps) that has several harmful effects.  Suspendisse nisi urna, efficitur vel tempor ut, mollis ac velit. Morbi vel sem id magna iaculis tincidunt. Fusce blandit ligula et mi rhoncus, non pulvinar augue hendrerit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nulla a molestie urna. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam condimentum tincidunt ultrices. Donec nec ex nisl. Donec sed vestibulum tellus.   In sed sapien lacus. Phasellus sapien ante, placerat sed aliquam et, rhoncus ac est. Sed facilisis suscipit sapien, at accumsan urna consectetur id. Quisque luctus tellus eu urna rhoncus, vitae dictum quam consequat. Etiam ex turpis, consequat sed pulvinar eget, imperdiet posuere lorem. Mauris accumsan accumsan est, ac posuere sapien porta quis. Maecenas molestie consectetur purus, et scelerisque justo vulputate nec. ",
        ),
      );

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
          theme: AppTheme(colorScheme: DefaultColorScheme.lightScheme).theme,
          darkTheme: AppTheme(colorScheme: DefaultColorScheme.darkScheme).theme,
        ),
      ),
    );
  }
}
