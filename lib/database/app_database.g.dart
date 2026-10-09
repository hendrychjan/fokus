// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 30,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _goalMeta = const VerificationMeta('goal');
  @override
  late final GeneratedColumn<int> goal = GeneratedColumn<int>(
    'goal',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorARGBMeta = const VerificationMeta(
    'colorARGB',
  );
  @override
  late final GeneratedColumn<int> colorARGB = GeneratedColumn<int>(
    'color_a_r_g_b',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, goal, colorARGB];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('goal')) {
      context.handle(
        _goalMeta,
        goal.isAcceptableOrUnknown(data['goal']!, _goalMeta),
      );
    }
    if (data.containsKey('color_a_r_g_b')) {
      context.handle(
        _colorARGBMeta,
        colorARGB.isAcceptableOrUnknown(data['color_a_r_g_b']!, _colorARGBMeta),
      );
    } else if (isInserting) {
      context.missing(_colorARGBMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tag(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      goal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}goal'],
      ),
      colorARGB: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_a_r_g_b'],
      )!,
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final int id;
  final String title;

  /// Optional goal in minutes
  final int? goal;

  /// Tag color (hex string consisting of two-digit components
  /// ALPHA-RED-GREEN-BLUE).
  ///
  /// Dart UI color is then created like so: `Color(tag.colorARGB)`
  final int colorARGB;
  const Tag({
    required this.id,
    required this.title,
    this.goal,
    required this.colorARGB,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || goal != null) {
      map['goal'] = Variable<int>(goal);
    }
    map['color_a_r_g_b'] = Variable<int>(colorARGB);
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      title: Value(title),
      goal: goal == null && nullToAbsent ? const Value.absent() : Value(goal),
      colorARGB: Value(colorARGB),
    );
  }

  factory Tag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      goal: serializer.fromJson<int?>(json['goal']),
      colorARGB: serializer.fromJson<int>(json['colorARGB']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'goal': serializer.toJson<int?>(goal),
      'colorARGB': serializer.toJson<int>(colorARGB),
    };
  }

  Tag copyWith({
    int? id,
    String? title,
    Value<int?> goal = const Value.absent(),
    int? colorARGB,
  }) => Tag(
    id: id ?? this.id,
    title: title ?? this.title,
    goal: goal.present ? goal.value : this.goal,
    colorARGB: colorARGB ?? this.colorARGB,
  );
  Tag copyWithCompanion(TagsCompanion data) {
    return Tag(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      goal: data.goal.present ? data.goal.value : this.goal,
      colorARGB: data.colorARGB.present ? data.colorARGB.value : this.colorARGB,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('goal: $goal, ')
          ..write('colorARGB: $colorARGB')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, goal, colorARGB);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag &&
          other.id == this.id &&
          other.title == this.title &&
          other.goal == this.goal &&
          other.colorARGB == this.colorARGB);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<int> id;
  final Value<String> title;
  final Value<int?> goal;
  final Value<int> colorARGB;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.goal = const Value.absent(),
    this.colorARGB = const Value.absent(),
  });
  TagsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.goal = const Value.absent(),
    required int colorARGB,
  }) : title = Value(title),
       colorARGB = Value(colorARGB);
  static Insertable<Tag> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? goal,
    Expression<int>? colorARGB,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (goal != null) 'goal': goal,
      if (colorARGB != null) 'color_a_r_g_b': colorARGB,
    });
  }

  TagsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<int?>? goal,
    Value<int>? colorARGB,
  }) {
    return TagsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      goal: goal ?? this.goal,
      colorARGB: colorARGB ?? this.colorARGB,
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
    if (goal.present) {
      map['goal'] = Variable<int>(goal.value);
    }
    if (colorARGB.present) {
      map['color_a_r_g_b'] = Variable<int>(colorARGB.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('goal: $goal, ')
          ..write('colorARGB: $colorARGB')
          ..write(')'))
        .toString();
  }
}

class $SessionRecordsTable extends SessionRecords
    with TableInfo<$SessionRecordsTable, SessionRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sessionStartMeta = const VerificationMeta(
    'sessionStart',
  );
  @override
  late final GeneratedColumn<DateTime> sessionStart = GeneratedColumn<DateTime>(
    'session_start',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionEndMeta = const VerificationMeta(
    'sessionEnd',
  );
  @override
  late final GeneratedColumn<DateTime> sessionEnd = GeneratedColumn<DateTime>(
    'session_end',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, sessionStart, sessionEnd, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'session_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_start')) {
      context.handle(
        _sessionStartMeta,
        sessionStart.isAcceptableOrUnknown(
          data['session_start']!,
          _sessionStartMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sessionStartMeta);
    }
    if (data.containsKey('session_end')) {
      context.handle(
        _sessionEndMeta,
        sessionEnd.isAcceptableOrUnknown(data['session_end']!, _sessionEndMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionEndMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SessionRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionStart: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}session_start'],
      )!,
      sessionEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}session_end'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $SessionRecordsTable createAlias(String alias) {
    return $SessionRecordsTable(attachedDatabase, alias);
  }
}

class SessionRecord extends DataClass implements Insertable<SessionRecord> {
  final int id;
  final DateTime sessionStart;
  final DateTime sessionEnd;
  final String? note;
  const SessionRecord({
    required this.id,
    required this.sessionStart,
    required this.sessionEnd,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_start'] = Variable<DateTime>(sessionStart);
    map['session_end'] = Variable<DateTime>(sessionEnd);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  SessionRecordsCompanion toCompanion(bool nullToAbsent) {
    return SessionRecordsCompanion(
      id: Value(id),
      sessionStart: Value(sessionStart),
      sessionEnd: Value(sessionEnd),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory SessionRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionRecord(
      id: serializer.fromJson<int>(json['id']),
      sessionStart: serializer.fromJson<DateTime>(json['sessionStart']),
      sessionEnd: serializer.fromJson<DateTime>(json['sessionEnd']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionStart': serializer.toJson<DateTime>(sessionStart),
      'sessionEnd': serializer.toJson<DateTime>(sessionEnd),
      'note': serializer.toJson<String?>(note),
    };
  }

  SessionRecord copyWith({
    int? id,
    DateTime? sessionStart,
    DateTime? sessionEnd,
    Value<String?> note = const Value.absent(),
  }) => SessionRecord(
    id: id ?? this.id,
    sessionStart: sessionStart ?? this.sessionStart,
    sessionEnd: sessionEnd ?? this.sessionEnd,
    note: note.present ? note.value : this.note,
  );
  SessionRecord copyWithCompanion(SessionRecordsCompanion data) {
    return SessionRecord(
      id: data.id.present ? data.id.value : this.id,
      sessionStart: data.sessionStart.present
          ? data.sessionStart.value
          : this.sessionStart,
      sessionEnd: data.sessionEnd.present
          ? data.sessionEnd.value
          : this.sessionEnd,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionRecord(')
          ..write('id: $id, ')
          ..write('sessionStart: $sessionStart, ')
          ..write('sessionEnd: $sessionEnd, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionStart, sessionEnd, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionRecord &&
          other.id == this.id &&
          other.sessionStart == this.sessionStart &&
          other.sessionEnd == this.sessionEnd &&
          other.note == this.note);
}

class SessionRecordsCompanion extends UpdateCompanion<SessionRecord> {
  final Value<int> id;
  final Value<DateTime> sessionStart;
  final Value<DateTime> sessionEnd;
  final Value<String?> note;
  const SessionRecordsCompanion({
    this.id = const Value.absent(),
    this.sessionStart = const Value.absent(),
    this.sessionEnd = const Value.absent(),
    this.note = const Value.absent(),
  });
  SessionRecordsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime sessionStart,
    required DateTime sessionEnd,
    this.note = const Value.absent(),
  }) : sessionStart = Value(sessionStart),
       sessionEnd = Value(sessionEnd);
  static Insertable<SessionRecord> custom({
    Expression<int>? id,
    Expression<DateTime>? sessionStart,
    Expression<DateTime>? sessionEnd,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionStart != null) 'session_start': sessionStart,
      if (sessionEnd != null) 'session_end': sessionEnd,
      if (note != null) 'note': note,
    });
  }

  SessionRecordsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? sessionStart,
    Value<DateTime>? sessionEnd,
    Value<String?>? note,
  }) {
    return SessionRecordsCompanion(
      id: id ?? this.id,
      sessionStart: sessionStart ?? this.sessionStart,
      sessionEnd: sessionEnd ?? this.sessionEnd,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionStart.present) {
      map['session_start'] = Variable<DateTime>(sessionStart.value);
    }
    if (sessionEnd.present) {
      map['session_end'] = Variable<DateTime>(sessionEnd.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionRecordsCompanion(')
          ..write('id: $id, ')
          ..write('sessionStart: $sessionStart, ')
          ..write('sessionEnd: $sessionEnd, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $SessionRecordTagsTable extends SessionRecordTags
    with TableInfo<$SessionRecordTagsTable, SessionRecordTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionRecordTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sessionRecordMeta = const VerificationMeta(
    'sessionRecord',
  );
  @override
  late final GeneratedColumn<int> sessionRecord = GeneratedColumn<int>(
    'session_record',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES session_records (id)',
    ),
  );
  static const VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<int> tag = GeneratedColumn<int>(
    'tag',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tags (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [sessionRecord, tag];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'session_record_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionRecordTag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('session_record')) {
      context.handle(
        _sessionRecordMeta,
        sessionRecord.isAcceptableOrUnknown(
          data['session_record']!,
          _sessionRecordMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sessionRecordMeta);
    }
    if (data.containsKey('tag')) {
      context.handle(
        _tagMeta,
        tag.isAcceptableOrUnknown(data['tag']!, _tagMeta),
      );
    } else if (isInserting) {
      context.missing(_tagMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  SessionRecordTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionRecordTag(
      sessionRecord: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_record'],
      )!,
      tag: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tag'],
      )!,
    );
  }

  @override
  $SessionRecordTagsTable createAlias(String alias) {
    return $SessionRecordTagsTable(attachedDatabase, alias);
  }
}

class SessionRecordTag extends DataClass
    implements Insertable<SessionRecordTag> {
  final int sessionRecord;
  final int tag;
  const SessionRecordTag({required this.sessionRecord, required this.tag});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['session_record'] = Variable<int>(sessionRecord);
    map['tag'] = Variable<int>(tag);
    return map;
  }

  SessionRecordTagsCompanion toCompanion(bool nullToAbsent) {
    return SessionRecordTagsCompanion(
      sessionRecord: Value(sessionRecord),
      tag: Value(tag),
    );
  }

  factory SessionRecordTag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionRecordTag(
      sessionRecord: serializer.fromJson<int>(json['sessionRecord']),
      tag: serializer.fromJson<int>(json['tag']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sessionRecord': serializer.toJson<int>(sessionRecord),
      'tag': serializer.toJson<int>(tag),
    };
  }

  SessionRecordTag copyWith({int? sessionRecord, int? tag}) => SessionRecordTag(
    sessionRecord: sessionRecord ?? this.sessionRecord,
    tag: tag ?? this.tag,
  );
  SessionRecordTag copyWithCompanion(SessionRecordTagsCompanion data) {
    return SessionRecordTag(
      sessionRecord: data.sessionRecord.present
          ? data.sessionRecord.value
          : this.sessionRecord,
      tag: data.tag.present ? data.tag.value : this.tag,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionRecordTag(')
          ..write('sessionRecord: $sessionRecord, ')
          ..write('tag: $tag')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(sessionRecord, tag);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionRecordTag &&
          other.sessionRecord == this.sessionRecord &&
          other.tag == this.tag);
}

class SessionRecordTagsCompanion extends UpdateCompanion<SessionRecordTag> {
  final Value<int> sessionRecord;
  final Value<int> tag;
  final Value<int> rowid;
  const SessionRecordTagsCompanion({
    this.sessionRecord = const Value.absent(),
    this.tag = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionRecordTagsCompanion.insert({
    required int sessionRecord,
    required int tag,
    this.rowid = const Value.absent(),
  }) : sessionRecord = Value(sessionRecord),
       tag = Value(tag);
  static Insertable<SessionRecordTag> custom({
    Expression<int>? sessionRecord,
    Expression<int>? tag,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sessionRecord != null) 'session_record': sessionRecord,
      if (tag != null) 'tag': tag,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionRecordTagsCompanion copyWith({
    Value<int>? sessionRecord,
    Value<int>? tag,
    Value<int>? rowid,
  }) {
    return SessionRecordTagsCompanion(
      sessionRecord: sessionRecord ?? this.sessionRecord,
      tag: tag ?? this.tag,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sessionRecord.present) {
      map['session_record'] = Variable<int>(sessionRecord.value);
    }
    if (tag.present) {
      map['tag'] = Variable<int>(tag.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionRecordTagsCompanion(')
          ..write('sessionRecord: $sessionRecord, ')
          ..write('tag: $tag, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<AppThemeMode, String> themeMode =
      GeneratedColumn<String>(
        'theme_mode',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AppThemeMode>($AppSettingsTable.$converterthemeMode);
  static const VerificationMeta _themeSeedColorARGBMeta =
      const VerificationMeta('themeSeedColorARGB');
  @override
  late final GeneratedColumn<int> themeSeedColorARGB = GeneratedColumn<int>(
    'theme_seed_color_a_r_g_b',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wakelockEnabledMeta = const VerificationMeta(
    'wakelockEnabled',
  );
  @override
  late final GeneratedColumn<bool> wakelockEnabled = GeneratedColumn<bool>(
    'wakelock_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("wakelock_enabled" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    themeMode,
    themeSeedColorARGB,
    wakelockEnabled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('theme_seed_color_a_r_g_b')) {
      context.handle(
        _themeSeedColorARGBMeta,
        themeSeedColorARGB.isAcceptableOrUnknown(
          data['theme_seed_color_a_r_g_b']!,
          _themeSeedColorARGBMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_themeSeedColorARGBMeta);
    }
    if (data.containsKey('wakelock_enabled')) {
      context.handle(
        _wakelockEnabledMeta,
        wakelockEnabled.isAcceptableOrUnknown(
          data['wakelock_enabled']!,
          _wakelockEnabledMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_wakelockEnabledMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      themeMode: $AppSettingsTable.$converterthemeMode.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}theme_mode'],
        )!,
      ),
      themeSeedColorARGB: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}theme_seed_color_a_r_g_b'],
      )!,
      wakelockEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}wakelock_enabled'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AppThemeMode, String, String> $converterthemeMode =
      const EnumNameConverter<material.ThemeMode>(material.ThemeMode.values);
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final int id;

  /// Theme mode (light/dark/system)
  final AppThemeMode themeMode;

  /// Theme seed color (hex string consisting of two-digit components
  /// ALPHA-RED-GREEN-BLUE).
  ///
  /// Dart UI color is then created like so: `Color(appSettings.colorARGB)`
  final int themeSeedColorARGB;

  /// Wakelock on session page enabled
  final bool wakelockEnabled;
  const AppSetting({
    required this.id,
    required this.themeMode,
    required this.themeSeedColorARGB,
    required this.wakelockEnabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['theme_mode'] = Variable<String>(
        $AppSettingsTable.$converterthemeMode.toSql(themeMode),
      );
    }
    map['theme_seed_color_a_r_g_b'] = Variable<int>(themeSeedColorARGB);
    map['wakelock_enabled'] = Variable<bool>(wakelockEnabled);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      themeMode: Value(themeMode),
      themeSeedColorARGB: Value(themeSeedColorARGB),
      wakelockEnabled: Value(wakelockEnabled),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<int>(json['id']),
      themeMode: $AppSettingsTable.$converterthemeMode.fromJson(
        serializer.fromJson<String>(json['themeMode']),
      ),
      themeSeedColorARGB: serializer.fromJson<int>(json['themeSeedColorARGB']),
      wakelockEnabled: serializer.fromJson<bool>(json['wakelockEnabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'themeMode': serializer.toJson<String>(
        $AppSettingsTable.$converterthemeMode.toJson(themeMode),
      ),
      'themeSeedColorARGB': serializer.toJson<int>(themeSeedColorARGB),
      'wakelockEnabled': serializer.toJson<bool>(wakelockEnabled),
    };
  }

  AppSetting copyWith({
    int? id,
    AppThemeMode? themeMode,
    int? themeSeedColorARGB,
    bool? wakelockEnabled,
  }) => AppSetting(
    id: id ?? this.id,
    themeMode: themeMode ?? this.themeMode,
    themeSeedColorARGB: themeSeedColorARGB ?? this.themeSeedColorARGB,
    wakelockEnabled: wakelockEnabled ?? this.wakelockEnabled,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      themeSeedColorARGB: data.themeSeedColorARGB.present
          ? data.themeSeedColorARGB.value
          : this.themeSeedColorARGB,
      wakelockEnabled: data.wakelockEnabled.present
          ? data.wakelockEnabled.value
          : this.wakelockEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('themeSeedColorARGB: $themeSeedColorARGB, ')
          ..write('wakelockEnabled: $wakelockEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, themeMode, themeSeedColorARGB, wakelockEnabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.themeMode == this.themeMode &&
          other.themeSeedColorARGB == this.themeSeedColorARGB &&
          other.wakelockEnabled == this.wakelockEnabled);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<AppThemeMode> themeMode;
  final Value<int> themeSeedColorARGB;
  final Value<bool> wakelockEnabled;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.themeSeedColorARGB = const Value.absent(),
    this.wakelockEnabled = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    required AppThemeMode themeMode,
    required int themeSeedColorARGB,
    required bool wakelockEnabled,
  }) : themeMode = Value(themeMode),
       themeSeedColorARGB = Value(themeSeedColorARGB),
       wakelockEnabled = Value(wakelockEnabled);
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<String>? themeMode,
    Expression<int>? themeSeedColorARGB,
    Expression<bool>? wakelockEnabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (themeMode != null) 'theme_mode': themeMode,
      if (themeSeedColorARGB != null)
        'theme_seed_color_a_r_g_b': themeSeedColorARGB,
      if (wakelockEnabled != null) 'wakelock_enabled': wakelockEnabled,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<AppThemeMode>? themeMode,
    Value<int>? themeSeedColorARGB,
    Value<bool>? wakelockEnabled,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      themeMode: themeMode ?? this.themeMode,
      themeSeedColorARGB: themeSeedColorARGB ?? this.themeSeedColorARGB,
      wakelockEnabled: wakelockEnabled ?? this.wakelockEnabled,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(
        $AppSettingsTable.$converterthemeMode.toSql(themeMode.value),
      );
    }
    if (themeSeedColorARGB.present) {
      map['theme_seed_color_a_r_g_b'] = Variable<int>(themeSeedColorARGB.value);
    }
    if (wakelockEnabled.present) {
      map['wakelock_enabled'] = Variable<bool>(wakelockEnabled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('themeSeedColorARGB: $themeSeedColorARGB, ')
          ..write('wakelockEnabled: $wakelockEnabled')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $SessionRecordsTable sessionRecords = $SessionRecordsTable(this);
  late final $SessionRecordTagsTable sessionRecordTags =
      $SessionRecordTagsTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    tags,
    sessionRecords,
    sessionRecordTags,
    appSettings,
  ];
}

typedef $$TagsTableCreateCompanionBuilder =
    TagsCompanion Function({
      Value<int> id,
      required String title,
      Value<int?> goal,
      required int colorARGB,
    });
typedef $$TagsTableUpdateCompanionBuilder =
    TagsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<int?> goal,
      Value<int> colorARGB,
    });

final class $$TagsTableReferences
    extends BaseReferences<_$AppDatabase, $TagsTable, Tag> {
  $$TagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SessionRecordTagsTable, List<SessionRecordTag>>
  _sessionRecordTagsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.sessionRecordTags,
        aliasName: 'tags__id__session_record_tags__tag',
      );

  $$SessionRecordTagsTableProcessedTableManager get sessionRecordTagsRefs {
    final manager = $$SessionRecordTagsTableTableManager(
      $_db,
      $_db.sessionRecordTags,
    ).filter((f) => f.tag.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _sessionRecordTagsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TagsTableFilterComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorARGB => $composableBuilder(
    column: $table.colorARGB,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sessionRecordTagsRefs(
    Expression<bool> Function($$SessionRecordTagsTableFilterComposer f) f,
  ) {
    final $$SessionRecordTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessionRecordTags,
      getReferencedColumn: (t) => t.tag,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionRecordTagsTableFilterComposer(
            $db: $db,
            $table: $db.sessionRecordTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableOrderingComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorARGB => $composableBuilder(
    column: $table.colorARGB,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get goal =>
      $composableBuilder(column: $table.goal, builder: (column) => column);

  GeneratedColumn<int> get colorARGB =>
      $composableBuilder(column: $table.colorARGB, builder: (column) => column);

  Expression<T> sessionRecordTagsRefs<T extends Object>(
    Expression<T> Function($$SessionRecordTagsTableAnnotationComposer a) f,
  ) {
    final $$SessionRecordTagsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.sessionRecordTags,
          getReferencedColumn: (t) => t.tag,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SessionRecordTagsTableAnnotationComposer(
                $db: $db,
                $table: $db.sessionRecordTags,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$TagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TagsTable,
          Tag,
          $$TagsTableFilterComposer,
          $$TagsTableOrderingComposer,
          $$TagsTableAnnotationComposer,
          $$TagsTableCreateCompanionBuilder,
          $$TagsTableUpdateCompanionBuilder,
          (Tag, $$TagsTableReferences),
          Tag,
          PrefetchHooks Function({bool sessionRecordTagsRefs})
        > {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int?> goal = const Value.absent(),
                Value<int> colorARGB = const Value.absent(),
              }) => TagsCompanion(
                id: id,
                title: title,
                goal: goal,
                colorARGB: colorARGB,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<int?> goal = const Value.absent(),
                required int colorARGB,
              }) => TagsCompanion.insert(
                id: id,
                title: title,
                goal: goal,
                colorARGB: colorARGB,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TagsTable, Tag>(table),
                  $$TagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionRecordTagsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (sessionRecordTagsRefs) db.sessionRecordTags,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sessionRecordTagsRefs)
                    await $_getPrefetchedData<
                      Tag,
                      $TagsTable,
                      SessionRecordTag
                    >(
                      currentTable: table,
                      referencedTable: $$TagsTableReferences
                          ._sessionRecordTagsRefsTable(db),
                      managerFromTypedResult: (p0) => $$TagsTableReferences(
                        db,
                        table,
                        p0,
                      ).sessionRecordTagsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.tag == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TagsTable,
      Tag,
      $$TagsTableFilterComposer,
      $$TagsTableOrderingComposer,
      $$TagsTableAnnotationComposer,
      $$TagsTableCreateCompanionBuilder,
      $$TagsTableUpdateCompanionBuilder,
      (Tag, $$TagsTableReferences),
      Tag,
      PrefetchHooks Function({bool sessionRecordTagsRefs})
    >;
typedef $$SessionRecordsTableCreateCompanionBuilder =
    SessionRecordsCompanion Function({
      Value<int> id,
      required DateTime sessionStart,
      required DateTime sessionEnd,
      Value<String?> note,
    });
typedef $$SessionRecordsTableUpdateCompanionBuilder =
    SessionRecordsCompanion Function({
      Value<int> id,
      Value<DateTime> sessionStart,
      Value<DateTime> sessionEnd,
      Value<String?> note,
    });

final class $$SessionRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $SessionRecordsTable, SessionRecord> {
  $$SessionRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$SessionRecordTagsTable, List<SessionRecordTag>>
  _sessionRecordTagsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.sessionRecordTags,
        aliasName: 'session_records__id__session_record_tags__session_record',
      );

  $$SessionRecordTagsTableProcessedTableManager get sessionRecordTagsRefs {
    final manager = $$SessionRecordTagsTableTableManager(
      $_db,
      $_db.sessionRecordTags,
    ).filter((f) => f.sessionRecord.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _sessionRecordTagsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SessionRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionRecordsTable> {
  $$SessionRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sessionStart => $composableBuilder(
    column: $table.sessionStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sessionEnd => $composableBuilder(
    column: $table.sessionEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sessionRecordTagsRefs(
    Expression<bool> Function($$SessionRecordTagsTableFilterComposer f) f,
  ) {
    final $$SessionRecordTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessionRecordTags,
      getReferencedColumn: (t) => t.sessionRecord,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionRecordTagsTableFilterComposer(
            $db: $db,
            $table: $db.sessionRecordTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SessionRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionRecordsTable> {
  $$SessionRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sessionStart => $composableBuilder(
    column: $table.sessionStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sessionEnd => $composableBuilder(
    column: $table.sessionEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SessionRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionRecordsTable> {
  $$SessionRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get sessionStart => $composableBuilder(
    column: $table.sessionStart,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get sessionEnd => $composableBuilder(
    column: $table.sessionEnd,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  Expression<T> sessionRecordTagsRefs<T extends Object>(
    Expression<T> Function($$SessionRecordTagsTableAnnotationComposer a) f,
  ) {
    final $$SessionRecordTagsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.sessionRecordTags,
          getReferencedColumn: (t) => t.sessionRecord,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SessionRecordTagsTableAnnotationComposer(
                $db: $db,
                $table: $db.sessionRecordTags,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SessionRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionRecordsTable,
          SessionRecord,
          $$SessionRecordsTableFilterComposer,
          $$SessionRecordsTableOrderingComposer,
          $$SessionRecordsTableAnnotationComposer,
          $$SessionRecordsTableCreateCompanionBuilder,
          $$SessionRecordsTableUpdateCompanionBuilder,
          (SessionRecord, $$SessionRecordsTableReferences),
          SessionRecord,
          PrefetchHooks Function({bool sessionRecordTagsRefs})
        > {
  $$SessionRecordsTableTableManager(
    _$AppDatabase db,
    $SessionRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> sessionStart = const Value.absent(),
                Value<DateTime> sessionEnd = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => SessionRecordsCompanion(
                id: id,
                sessionStart: sessionStart,
                sessionEnd: sessionEnd,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime sessionStart,
                required DateTime sessionEnd,
                Value<String?> note = const Value.absent(),
              }) => SessionRecordsCompanion.insert(
                id: id,
                sessionStart: sessionStart,
                sessionEnd: sessionEnd,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SessionRecordsTable, SessionRecord>(table),
                  $$SessionRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionRecordTagsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (sessionRecordTagsRefs) db.sessionRecordTags,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sessionRecordTagsRefs)
                    await $_getPrefetchedData<
                      SessionRecord,
                      $SessionRecordsTable,
                      SessionRecordTag
                    >(
                      currentTable: table,
                      referencedTable: $$SessionRecordsTableReferences
                          ._sessionRecordTagsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SessionRecordsTableReferences(
                            db,
                            table,
                            p0,
                          ).sessionRecordTagsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.sessionRecord == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SessionRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionRecordsTable,
      SessionRecord,
      $$SessionRecordsTableFilterComposer,
      $$SessionRecordsTableOrderingComposer,
      $$SessionRecordsTableAnnotationComposer,
      $$SessionRecordsTableCreateCompanionBuilder,
      $$SessionRecordsTableUpdateCompanionBuilder,
      (SessionRecord, $$SessionRecordsTableReferences),
      SessionRecord,
      PrefetchHooks Function({bool sessionRecordTagsRefs})
    >;
typedef $$SessionRecordTagsTableCreateCompanionBuilder =
    SessionRecordTagsCompanion Function({
      required int sessionRecord,
      required int tag,
      Value<int> rowid,
    });
typedef $$SessionRecordTagsTableUpdateCompanionBuilder =
    SessionRecordTagsCompanion Function({
      Value<int> sessionRecord,
      Value<int> tag,
      Value<int> rowid,
    });

final class $$SessionRecordTagsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SessionRecordTagsTable,
          SessionRecordTag
        > {
  $$SessionRecordTagsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SessionRecordsTable _sessionRecordTable(_$AppDatabase db) => db
      .sessionRecords
      .createAlias('session_record_tags__session_record__session_records__id');

  $$SessionRecordsTableProcessedTableManager get sessionRecord {
    final $_column = $_itemColumn<int>('session_record')!;

    final manager = $$SessionRecordsTableTableManager(
      $_db,
      $_db.sessionRecords,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionRecordTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TagsTable _tagTable(_$AppDatabase db) =>
      db.tags.createAlias('session_record_tags__tag__tags__id');

  $$TagsTableProcessedTableManager get tag {
    final $_column = $_itemColumn<int>('tag')!;

    final manager = $$TagsTableTableManager(
      $_db,
      $_db.tags,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SessionRecordTagsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionRecordTagsTable> {
  $$SessionRecordTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SessionRecordsTableFilterComposer get sessionRecord {
    final $$SessionRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionRecord,
      referencedTable: $db.sessionRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionRecordsTableFilterComposer(
            $db: $db,
            $table: $db.sessionRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableFilterComposer get tag {
    final $$TagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tag,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableFilterComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionRecordTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionRecordTagsTable> {
  $$SessionRecordTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SessionRecordsTableOrderingComposer get sessionRecord {
    final $$SessionRecordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionRecord,
      referencedTable: $db.sessionRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionRecordsTableOrderingComposer(
            $db: $db,
            $table: $db.sessionRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableOrderingComposer get tag {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tag,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableOrderingComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionRecordTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionRecordTagsTable> {
  $$SessionRecordTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SessionRecordsTableAnnotationComposer get sessionRecord {
    final $$SessionRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionRecord,
      referencedTable: $db.sessionRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessionRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableAnnotationComposer get tag {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tag,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableAnnotationComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionRecordTagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionRecordTagsTable,
          SessionRecordTag,
          $$SessionRecordTagsTableFilterComposer,
          $$SessionRecordTagsTableOrderingComposer,
          $$SessionRecordTagsTableAnnotationComposer,
          $$SessionRecordTagsTableCreateCompanionBuilder,
          $$SessionRecordTagsTableUpdateCompanionBuilder,
          (SessionRecordTag, $$SessionRecordTagsTableReferences),
          SessionRecordTag,
          PrefetchHooks Function({bool sessionRecord, bool tag})
        > {
  $$SessionRecordTagsTableTableManager(
    _$AppDatabase db,
    $SessionRecordTagsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionRecordTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionRecordTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionRecordTagsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> sessionRecord = const Value.absent(),
                Value<int> tag = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionRecordTagsCompanion(
                sessionRecord: sessionRecord,
                tag: tag,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int sessionRecord,
                required int tag,
                Value<int> rowid = const Value.absent(),
              }) => SessionRecordTagsCompanion.insert(
                sessionRecord: sessionRecord,
                tag: tag,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SessionRecordTagsTable, SessionRecordTag>(table),
                  $$SessionRecordTagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionRecord = false, tag = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionRecord) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionRecord,
                                referencedTable:
                                    $$SessionRecordTagsTableReferences
                                        ._sessionRecordTable(db),
                                referencedColumn:
                                    $$SessionRecordTagsTableReferences
                                        ._sessionRecordTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (tag) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tag,
                                referencedTable:
                                    $$SessionRecordTagsTableReferences
                                        ._tagTable(db),
                                referencedColumn:
                                    $$SessionRecordTagsTableReferences
                                        ._tagTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SessionRecordTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionRecordTagsTable,
      SessionRecordTag,
      $$SessionRecordTagsTableFilterComposer,
      $$SessionRecordTagsTableOrderingComposer,
      $$SessionRecordTagsTableAnnotationComposer,
      $$SessionRecordTagsTableCreateCompanionBuilder,
      $$SessionRecordTagsTableUpdateCompanionBuilder,
      (SessionRecordTag, $$SessionRecordTagsTableReferences),
      SessionRecordTag,
      PrefetchHooks Function({bool sessionRecord, bool tag})
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      required AppThemeMode themeMode,
      required int themeSeedColorARGB,
      required bool wakelockEnabled,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<AppThemeMode> themeMode,
      Value<int> themeSeedColorARGB,
      Value<bool> wakelockEnabled,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AppThemeMode, AppThemeMode, String>
  get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get themeSeedColorARGB => $composableBuilder(
    column: $table.themeSeedColorARGB,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get wakelockEnabled => $composableBuilder(
    column: $table.wakelockEnabled,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get themeSeedColorARGB => $composableBuilder(
    column: $table.themeSeedColorARGB,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get wakelockEnabled => $composableBuilder(
    column: $table.wakelockEnabled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AppThemeMode, String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<int> get themeSeedColorARGB => $composableBuilder(
    column: $table.themeSeedColorARGB,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get wakelockEnabled => $composableBuilder(
    column: $table.wakelockEnabled,
    builder: (column) => column,
  );
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<AppThemeMode> themeMode = const Value.absent(),
                Value<int> themeSeedColorARGB = const Value.absent(),
                Value<bool> wakelockEnabled = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                themeMode: themeMode,
                themeSeedColorARGB: themeSeedColorARGB,
                wakelockEnabled: wakelockEnabled,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required AppThemeMode themeMode,
                required int themeSeedColorARGB,
                required bool wakelockEnabled,
              }) => AppSettingsCompanion.insert(
                id: id,
                themeMode: themeMode,
                themeSeedColorARGB: themeSeedColorARGB,
                wakelockEnabled: wakelockEnabled,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppSettingsTable, AppSetting>(table),
                  BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
  $$SessionRecordsTableTableManager get sessionRecords =>
      $$SessionRecordsTableTableManager(_db, _db.sessionRecords);
  $$SessionRecordTagsTableTableManager get sessionRecordTags =>
      $$SessionRecordTagsTableTableManager(_db, _db.sessionRecordTags);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
