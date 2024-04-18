// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $DeckTable extends Deck with TableInfo<$DeckTable, DeckData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeckTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _cardTotalMeta =
      const VerificationMeta('cardTotal');
  @override
  late final GeneratedColumn<int> cardTotal = GeneratedColumn<int>(
      'card_total', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _cardLeftMeta =
      const VerificationMeta('cardLeft');
  @override
  late final GeneratedColumn<int> cardLeft = GeneratedColumn<int>(
      'card_left', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, cardTotal, cardLeft, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'deck';
  @override
  VerificationContext validateIntegrity(Insertable<DeckData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('card_total')) {
      context.handle(_cardTotalMeta,
          cardTotal.isAcceptableOrUnknown(data['card_total']!, _cardTotalMeta));
    }
    if (data.containsKey('card_left')) {
      context.handle(_cardLeftMeta,
          cardLeft.isAcceptableOrUnknown(data['card_left']!, _cardLeftMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DeckData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeckData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      cardTotal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}card_total'])!,
      cardLeft: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}card_left'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $DeckTable createAlias(String alias) {
    return $DeckTable(attachedDatabase, alias);
  }
}

class DeckData extends DataClass implements Insertable<DeckData> {
  final int id;
  final String title;
  final int cardTotal;
  final int cardLeft;
  final DateTime createdAt;
  const DeckData(
      {required this.id,
      required this.title,
      required this.cardTotal,
      required this.cardLeft,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['card_total'] = Variable<int>(cardTotal);
    map['card_left'] = Variable<int>(cardLeft);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DeckCompanion toCompanion(bool nullToAbsent) {
    return DeckCompanion(
      id: Value(id),
      title: Value(title),
      cardTotal: Value(cardTotal),
      cardLeft: Value(cardLeft),
      createdAt: Value(createdAt),
    );
  }

  factory DeckData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeckData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      cardTotal: serializer.fromJson<int>(json['cardTotal']),
      cardLeft: serializer.fromJson<int>(json['cardLeft']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'cardTotal': serializer.toJson<int>(cardTotal),
      'cardLeft': serializer.toJson<int>(cardLeft),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DeckData copyWith(
          {int? id,
          String? title,
          int? cardTotal,
          int? cardLeft,
          DateTime? createdAt}) =>
      DeckData(
        id: id ?? this.id,
        title: title ?? this.title,
        cardTotal: cardTotal ?? this.cardTotal,
        cardLeft: cardLeft ?? this.cardLeft,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('DeckData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('cardTotal: $cardTotal, ')
          ..write('cardLeft: $cardLeft, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, cardTotal, cardLeft, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeckData &&
          other.id == this.id &&
          other.title == this.title &&
          other.cardTotal == this.cardTotal &&
          other.cardLeft == this.cardLeft &&
          other.createdAt == this.createdAt);
}

class DeckCompanion extends UpdateCompanion<DeckData> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> cardTotal;
  final Value<int> cardLeft;
  final Value<DateTime> createdAt;
  const DeckCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.cardTotal = const Value.absent(),
    this.cardLeft = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DeckCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.cardTotal = const Value.absent(),
    this.cardLeft = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : title = Value(title);
  static Insertable<DeckData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? cardTotal,
    Expression<int>? cardLeft,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (cardTotal != null) 'card_total': cardTotal,
      if (cardLeft != null) 'card_left': cardLeft,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DeckCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<int>? cardTotal,
      Value<int>? cardLeft,
      Value<DateTime>? createdAt}) {
    return DeckCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      cardTotal: cardTotal ?? this.cardTotal,
      cardLeft: cardLeft ?? this.cardLeft,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (cardTotal.present) {
      map['card_total'] = Variable<int>(cardTotal.value);
    }
    if (cardLeft.present) {
      map['card_left'] = Variable<int>(cardLeft.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeckCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('cardTotal: $cardTotal, ')
          ..write('cardLeft: $cardLeft, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CardItemTable extends CardItem
    with TableInfo<$CardItemTable, CardItemData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardItemTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _deckIdMeta = const VerificationMeta('deckId');
  @override
  late final GeneratedColumn<int> deckId = GeneratedColumn<int>(
      'deck_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES deck (id)'));
  static const VerificationMeta _frontMeta = const VerificationMeta('front');
  @override
  late final GeneratedColumn<String> front = GeneratedColumn<String>(
      'front', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 128),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _backMeta = const VerificationMeta('back');
  @override
  late final GeneratedColumn<String> back =
      GeneratedColumn<String>('back', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _answeredTypeMeta =
      const VerificationMeta('answeredType');
  @override
  late final GeneratedColumnWithTypeConverter<AnswerType?, int> answeredType =
      GeneratedColumn<int>('answered_type', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<AnswerType?>($CardItemTable.$converteransweredTypen);
  static const VerificationMeta _answeredAtMeta =
      const VerificationMeta('answeredAt');
  @override
  late final GeneratedColumn<DateTime> answeredAt = GeneratedColumn<DateTime>(
      'answered_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  @override
  List<GeneratedColumn> get $columns =>
      [id, deckId, front, back, answeredType, answeredAt, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'card_item';
  @override
  VerificationContext validateIntegrity(Insertable<CardItemData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('deck_id')) {
      context.handle(_deckIdMeta,
          deckId.isAcceptableOrUnknown(data['deck_id']!, _deckIdMeta));
    } else if (isInserting) {
      context.missing(_deckIdMeta);
    }
    if (data.containsKey('front')) {
      context.handle(
          _frontMeta, front.isAcceptableOrUnknown(data['front']!, _frontMeta));
    } else if (isInserting) {
      context.missing(_frontMeta);
    }
    if (data.containsKey('back')) {
      context.handle(
          _backMeta, back.isAcceptableOrUnknown(data['back']!, _backMeta));
    } else if (isInserting) {
      context.missing(_backMeta);
    }
    context.handle(_answeredTypeMeta, const VerificationResult.success());
    if (data.containsKey('answered_at')) {
      context.handle(
          _answeredAtMeta,
          answeredAt.isAcceptableOrUnknown(
              data['answered_at']!, _answeredAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CardItemData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CardItemData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      deckId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deck_id'])!,
      front: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}front'])!,
      back: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}back'])!,
      answeredType: $CardItemTable.$converteransweredTypen.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}answered_type'])),
      answeredAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}answered_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CardItemTable createAlias(String alias) {
    return $CardItemTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AnswerType, int, int> $converteransweredType =
      const EnumIndexConverter<AnswerType>(AnswerType.values);
  static JsonTypeConverter2<AnswerType?, int?, int?> $converteransweredTypen =
      JsonTypeConverter2.asNullable($converteransweredType);
}

class CardItemData extends DataClass implements Insertable<CardItemData> {
  final int id;
  final int deckId;
  final String front;
  final String back;
  final AnswerType? answeredType;
  final DateTime? answeredAt;
  final DateTime createdAt;
  const CardItemData(
      {required this.id,
      required this.deckId,
      required this.front,
      required this.back,
      this.answeredType,
      this.answeredAt,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['deck_id'] = Variable<int>(deckId);
    map['front'] = Variable<String>(front);
    map['back'] = Variable<String>(back);
    if (!nullToAbsent || answeredType != null) {
      map['answered_type'] = Variable<int>(
          $CardItemTable.$converteransweredTypen.toSql(answeredType));
    }
    if (!nullToAbsent || answeredAt != null) {
      map['answered_at'] = Variable<DateTime>(answeredAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CardItemCompanion toCompanion(bool nullToAbsent) {
    return CardItemCompanion(
      id: Value(id),
      deckId: Value(deckId),
      front: Value(front),
      back: Value(back),
      answeredType: answeredType == null && nullToAbsent
          ? const Value.absent()
          : Value(answeredType),
      answeredAt: answeredAt == null && nullToAbsent
          ? const Value.absent()
          : Value(answeredAt),
      createdAt: Value(createdAt),
    );
  }

  factory CardItemData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CardItemData(
      id: serializer.fromJson<int>(json['id']),
      deckId: serializer.fromJson<int>(json['deckId']),
      front: serializer.fromJson<String>(json['front']),
      back: serializer.fromJson<String>(json['back']),
      answeredType: $CardItemTable.$converteransweredTypen
          .fromJson(serializer.fromJson<int?>(json['answeredType'])),
      answeredAt: serializer.fromJson<DateTime?>(json['answeredAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'deckId': serializer.toJson<int>(deckId),
      'front': serializer.toJson<String>(front),
      'back': serializer.toJson<String>(back),
      'answeredType': serializer.toJson<int?>(
          $CardItemTable.$converteransweredTypen.toJson(answeredType)),
      'answeredAt': serializer.toJson<DateTime?>(answeredAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CardItemData copyWith(
          {int? id,
          int? deckId,
          String? front,
          String? back,
          Value<AnswerType?> answeredType = const Value.absent(),
          Value<DateTime?> answeredAt = const Value.absent(),
          DateTime? createdAt}) =>
      CardItemData(
        id: id ?? this.id,
        deckId: deckId ?? this.deckId,
        front: front ?? this.front,
        back: back ?? this.back,
        answeredType:
            answeredType.present ? answeredType.value : this.answeredType,
        answeredAt: answeredAt.present ? answeredAt.value : this.answeredAt,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('CardItemData(')
          ..write('id: $id, ')
          ..write('deckId: $deckId, ')
          ..write('front: $front, ')
          ..write('back: $back, ')
          ..write('answeredType: $answeredType, ')
          ..write('answeredAt: $answeredAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, deckId, front, back, answeredType, answeredAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardItemData &&
          other.id == this.id &&
          other.deckId == this.deckId &&
          other.front == this.front &&
          other.back == this.back &&
          other.answeredType == this.answeredType &&
          other.answeredAt == this.answeredAt &&
          other.createdAt == this.createdAt);
}

class CardItemCompanion extends UpdateCompanion<CardItemData> {
  final Value<int> id;
  final Value<int> deckId;
  final Value<String> front;
  final Value<String> back;
  final Value<AnswerType?> answeredType;
  final Value<DateTime?> answeredAt;
  final Value<DateTime> createdAt;
  const CardItemCompanion({
    this.id = const Value.absent(),
    this.deckId = const Value.absent(),
    this.front = const Value.absent(),
    this.back = const Value.absent(),
    this.answeredType = const Value.absent(),
    this.answeredAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CardItemCompanion.insert({
    this.id = const Value.absent(),
    required int deckId,
    required String front,
    required String back,
    this.answeredType = const Value.absent(),
    this.answeredAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : deckId = Value(deckId),
        front = Value(front),
        back = Value(back);
  static Insertable<CardItemData> custom({
    Expression<int>? id,
    Expression<int>? deckId,
    Expression<String>? front,
    Expression<String>? back,
    Expression<int>? answeredType,
    Expression<DateTime>? answeredAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (deckId != null) 'deck_id': deckId,
      if (front != null) 'front': front,
      if (back != null) 'back': back,
      if (answeredType != null) 'answered_type': answeredType,
      if (answeredAt != null) 'answered_at': answeredAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CardItemCompanion copyWith(
      {Value<int>? id,
      Value<int>? deckId,
      Value<String>? front,
      Value<String>? back,
      Value<AnswerType?>? answeredType,
      Value<DateTime?>? answeredAt,
      Value<DateTime>? createdAt}) {
    return CardItemCompanion(
      id: id ?? this.id,
      deckId: deckId ?? this.deckId,
      front: front ?? this.front,
      back: back ?? this.back,
      answeredType: answeredType ?? this.answeredType,
      answeredAt: answeredAt ?? this.answeredAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (deckId.present) {
      map['deck_id'] = Variable<int>(deckId.value);
    }
    if (front.present) {
      map['front'] = Variable<String>(front.value);
    }
    if (back.present) {
      map['back'] = Variable<String>(back.value);
    }
    if (answeredType.present) {
      map['answered_type'] = Variable<int>(
          $CardItemTable.$converteransweredTypen.toSql(answeredType.value));
    }
    if (answeredAt.present) {
      map['answered_at'] = Variable<DateTime>(answeredAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardItemCompanion(')
          ..write('id: $id, ')
          ..write('deckId: $deckId, ')
          ..write('front: $front, ')
          ..write('back: $back, ')
          ..write('answeredType: $answeredType, ')
          ..write('answeredAt: $answeredAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $DeckTable deck = $DeckTable(this);
  late final $CardItemTable cardItem = $CardItemTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [deck, cardItem];
}
