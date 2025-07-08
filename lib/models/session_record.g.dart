// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSessionRecordCollection on Isar {
  IsarCollection<SessionRecord> get sessionRecords => this.collection();
}

const SessionRecordSchema = CollectionSchema(
  name: r'SessionRecord',
  id: -4767949293416338608,
  properties: {
    r'note': PropertySchema(
      id: 0,
      name: r'note',
      type: IsarType.string,
    ),
    r'sessionEnd': PropertySchema(
      id: 1,
      name: r'sessionEnd',
      type: IsarType.dateTime,
    ),
    r'sessionStart': PropertySchema(
      id: 2,
      name: r'sessionStart',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _sessionRecordEstimateSize,
  serialize: _sessionRecordSerialize,
  deserialize: _sessionRecordDeserialize,
  deserializeProp: _sessionRecordDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'category': LinkSchema(
      id: 6351822216100486572,
      name: r'category',
      target: r'Category',
      single: true,
    ),
    r'tags': LinkSchema(
      id: -8854503451637913225,
      name: r'tags',
      target: r'Tag',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _sessionRecordGetId,
  getLinks: _sessionRecordGetLinks,
  attach: _sessionRecordAttach,
  version: '3.1.0+1',
);

int _sessionRecordEstimateSize(
  SessionRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.note;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _sessionRecordSerialize(
  SessionRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.note);
  writer.writeDateTime(offsets[1], object.sessionEnd);
  writer.writeDateTime(offsets[2], object.sessionStart);
}

SessionRecord _sessionRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SessionRecord();
  object.id = id;
  object.note = reader.readStringOrNull(offsets[0]);
  object.sessionEnd = reader.readDateTime(offsets[1]);
  object.sessionStart = reader.readDateTime(offsets[2]);
  return object;
}

P _sessionRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _sessionRecordGetId(SessionRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _sessionRecordGetLinks(SessionRecord object) {
  return [object.category, object.tags];
}

void _sessionRecordAttach(
    IsarCollection<dynamic> col, Id id, SessionRecord object) {
  object.id = id;
  object.category.attach(col, col.isar.collection<Category>(), r'category', id);
  object.tags.attach(col, col.isar.collection<Tag>(), r'tags', id);
}

extension SessionRecordQueryWhereSort
    on QueryBuilder<SessionRecord, SessionRecord, QWhere> {
  QueryBuilder<SessionRecord, SessionRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SessionRecordQueryWhere
    on QueryBuilder<SessionRecord, SessionRecord, QWhereClause> {
  QueryBuilder<SessionRecord, SessionRecord, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SessionRecordQueryFilter
    on QueryBuilder<SessionRecord, SessionRecord, QFilterCondition> {
  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition>
      noteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'note',
      ));
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition>
      noteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'note',
      ));
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition> noteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition>
      noteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition>
      noteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition> noteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'note',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition>
      noteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition>
      noteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition>
      noteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition> noteMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'note',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition>
      noteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition>
      noteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition>
      sessionEndEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sessionEnd',
        value: value,
      ));
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition>
      sessionEndGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sessionEnd',
        value: value,
      ));
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition>
      sessionEndLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sessionEnd',
        value: value,
      ));
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition>
      sessionEndBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sessionEnd',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition>
      sessionStartEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sessionStart',
        value: value,
      ));
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition>
      sessionStartGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sessionStart',
        value: value,
      ));
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition>
      sessionStartLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sessionStart',
        value: value,
      ));
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition>
      sessionStartBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sessionStart',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SessionRecordQueryObject
    on QueryBuilder<SessionRecord, SessionRecord, QFilterCondition> {}

extension SessionRecordQueryLinks
    on QueryBuilder<SessionRecord, SessionRecord, QFilterCondition> {
  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition> category(
      FilterQuery<Category> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'category');
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition>
      categoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'category', 0, true, 0, true);
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition> tags(
      FilterQuery<Tag> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'tags');
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition>
      tagsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'tags', length, true, length, true);
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition>
      tagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'tags', 0, true, 0, true);
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition>
      tagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'tags', 0, false, 999999, true);
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition>
      tagsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'tags', 0, true, length, include);
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition>
      tagsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'tags', length, include, 999999, true);
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterFilterCondition>
      tagsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'tags', lower, includeLower, upper, includeUpper);
    });
  }
}

extension SessionRecordQuerySortBy
    on QueryBuilder<SessionRecord, SessionRecord, QSortBy> {
  QueryBuilder<SessionRecord, SessionRecord, QAfterSortBy> sortByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterSortBy> sortByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterSortBy> sortBySessionEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionEnd', Sort.asc);
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterSortBy>
      sortBySessionEndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionEnd', Sort.desc);
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterSortBy>
      sortBySessionStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionStart', Sort.asc);
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterSortBy>
      sortBySessionStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionStart', Sort.desc);
    });
  }
}

extension SessionRecordQuerySortThenBy
    on QueryBuilder<SessionRecord, SessionRecord, QSortThenBy> {
  QueryBuilder<SessionRecord, SessionRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterSortBy> thenByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterSortBy> thenByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterSortBy> thenBySessionEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionEnd', Sort.asc);
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterSortBy>
      thenBySessionEndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionEnd', Sort.desc);
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterSortBy>
      thenBySessionStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionStart', Sort.asc);
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QAfterSortBy>
      thenBySessionStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionStart', Sort.desc);
    });
  }
}

extension SessionRecordQueryWhereDistinct
    on QueryBuilder<SessionRecord, SessionRecord, QDistinct> {
  QueryBuilder<SessionRecord, SessionRecord, QDistinct> distinctByNote(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'note', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QDistinct> distinctBySessionEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sessionEnd');
    });
  }

  QueryBuilder<SessionRecord, SessionRecord, QDistinct>
      distinctBySessionStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sessionStart');
    });
  }
}

extension SessionRecordQueryProperty
    on QueryBuilder<SessionRecord, SessionRecord, QQueryProperty> {
  QueryBuilder<SessionRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SessionRecord, String?, QQueryOperations> noteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'note');
    });
  }

  QueryBuilder<SessionRecord, DateTime, QQueryOperations> sessionEndProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sessionEnd');
    });
  }

  QueryBuilder<SessionRecord, DateTime, QQueryOperations>
      sessionStartProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sessionStart');
    });
  }
}
