// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_goal.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTagGoalCollection on Isar {
  IsarCollection<TagGoal> get tagGoals => this.collection();
}

const TagGoalSchema = CollectionSchema(
  name: r'TagGoal',
  id: 1212920536401099733,
  properties: {
    r'lastIgnored': PropertySchema(
      id: 0,
      name: r'lastIgnored',
      type: IsarType.dateTime,
    ),
    r'targetMinutes': PropertySchema(
      id: 1,
      name: r'targetMinutes',
      type: IsarType.long,
    ),
    r'title': PropertySchema(
      id: 2,
      name: r'title',
      type: IsarType.string,
    ),
    r'weekdays': PropertySchema(
      id: 3,
      name: r'weekdays',
      type: IsarType.longList,
    )
  },
  estimateSize: _tagGoalEstimateSize,
  serialize: _tagGoalSerialize,
  deserialize: _tagGoalDeserialize,
  deserializeProp: _tagGoalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'tag': LinkSchema(
      id: -7502460622216178771,
      name: r'tag',
      target: r'Tag',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _tagGoalGetId,
  getLinks: _tagGoalGetLinks,
  attach: _tagGoalAttach,
  version: '3.1.8',
);

int _tagGoalEstimateSize(
  TagGoal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.weekdays.length * 8;
  return bytesCount;
}

void _tagGoalSerialize(
  TagGoal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.lastIgnored);
  writer.writeLong(offsets[1], object.targetMinutes);
  writer.writeString(offsets[2], object.title);
  writer.writeLongList(offsets[3], object.weekdays);
}

TagGoal _tagGoalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TagGoal();
  object.id = id;
  object.lastIgnored = reader.readDateTime(offsets[0]);
  object.targetMinutes = reader.readLong(offsets[1]);
  object.title = reader.readString(offsets[2]);
  object.weekdays = reader.readLongList(offsets[3]) ?? [];
  return object;
}

P _tagGoalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLongList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _tagGoalGetId(TagGoal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _tagGoalGetLinks(TagGoal object) {
  return [object.tag];
}

void _tagGoalAttach(IsarCollection<dynamic> col, Id id, TagGoal object) {
  object.id = id;
  object.tag.attach(col, col.isar.collection<Tag>(), r'tag', id);
}

extension TagGoalQueryWhereSort on QueryBuilder<TagGoal, TagGoal, QWhere> {
  QueryBuilder<TagGoal, TagGoal, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TagGoalQueryWhere on QueryBuilder<TagGoal, TagGoal, QWhereClause> {
  QueryBuilder<TagGoal, TagGoal, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<TagGoal, TagGoal, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterWhereClause> idBetween(
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

extension TagGoalQueryFilter
    on QueryBuilder<TagGoal, TagGoal, QFilterCondition> {
  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> idBetween(
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

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> lastIgnoredEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastIgnored',
        value: value,
      ));
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> lastIgnoredGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastIgnored',
        value: value,
      ));
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> lastIgnoredLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastIgnored',
        value: value,
      ));
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> lastIgnoredBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastIgnored',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> targetMinutesEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition>
      targetMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> targetMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> targetMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> weekdaysElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weekdays',
        value: value,
      ));
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition>
      weekdaysElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weekdays',
        value: value,
      ));
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> weekdaysElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weekdays',
        value: value,
      ));
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> weekdaysElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weekdays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> weekdaysLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weekdays',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> weekdaysIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weekdays',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> weekdaysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weekdays',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> weekdaysLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weekdays',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition>
      weekdaysLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weekdays',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> weekdaysLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weekdays',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension TagGoalQueryObject
    on QueryBuilder<TagGoal, TagGoal, QFilterCondition> {}

extension TagGoalQueryLinks
    on QueryBuilder<TagGoal, TagGoal, QFilterCondition> {
  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> tag(
      FilterQuery<Tag> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'tag');
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterFilterCondition> tagIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'tag', 0, true, 0, true);
    });
  }
}

extension TagGoalQuerySortBy on QueryBuilder<TagGoal, TagGoal, QSortBy> {
  QueryBuilder<TagGoal, TagGoal, QAfterSortBy> sortByLastIgnored() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastIgnored', Sort.asc);
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterSortBy> sortByLastIgnoredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastIgnored', Sort.desc);
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterSortBy> sortByTargetMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetMinutes', Sort.asc);
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterSortBy> sortByTargetMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetMinutes', Sort.desc);
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension TagGoalQuerySortThenBy
    on QueryBuilder<TagGoal, TagGoal, QSortThenBy> {
  QueryBuilder<TagGoal, TagGoal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterSortBy> thenByLastIgnored() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastIgnored', Sort.asc);
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterSortBy> thenByLastIgnoredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastIgnored', Sort.desc);
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterSortBy> thenByTargetMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetMinutes', Sort.asc);
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterSortBy> thenByTargetMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetMinutes', Sort.desc);
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<TagGoal, TagGoal, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension TagGoalQueryWhereDistinct
    on QueryBuilder<TagGoal, TagGoal, QDistinct> {
  QueryBuilder<TagGoal, TagGoal, QDistinct> distinctByLastIgnored() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastIgnored');
    });
  }

  QueryBuilder<TagGoal, TagGoal, QDistinct> distinctByTargetMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetMinutes');
    });
  }

  QueryBuilder<TagGoal, TagGoal, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TagGoal, TagGoal, QDistinct> distinctByWeekdays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weekdays');
    });
  }
}

extension TagGoalQueryProperty
    on QueryBuilder<TagGoal, TagGoal, QQueryProperty> {
  QueryBuilder<TagGoal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TagGoal, DateTime, QQueryOperations> lastIgnoredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastIgnored');
    });
  }

  QueryBuilder<TagGoal, int, QQueryOperations> targetMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetMinutes');
    });
  }

  QueryBuilder<TagGoal, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<TagGoal, List<int>, QQueryOperations> weekdaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weekdays');
    });
  }
}
