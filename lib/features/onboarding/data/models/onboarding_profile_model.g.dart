// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_profile_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetOnboardingProfileModelCollection on Isar {
  IsarCollection<OnboardingProfileModel> get onboardingProfileModels =>
      this.collection();
}

const OnboardingProfileModelSchema = CollectionSchema(
  name: r'OnboardingProfileModel',
  id: 4180934718870332834,
  properties: {
    r'challengeIds': PropertySchema(
      id: 0,
      name: r'challengeIds',
      type: IsarType.stringList,
    ),
    r'completedAt': PropertySchema(
      id: 1,
      name: r'completedAt',
      type: IsarType.dateTime,
    ),
    r'isComplete': PropertySchema(
      id: 2,
      name: r'isComplete',
      type: IsarType.bool,
    )
  },
  estimateSize: _onboardingProfileModelEstimateSize,
  serialize: _onboardingProfileModelSerialize,
  deserialize: _onboardingProfileModelDeserialize,
  deserializeProp: _onboardingProfileModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _onboardingProfileModelGetId,
  getLinks: _onboardingProfileModelGetLinks,
  attach: _onboardingProfileModelAttach,
  version: '3.1.0+1',
);

int _onboardingProfileModelEstimateSize(
  OnboardingProfileModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.challengeIds.length * 3;
  {
    for (var i = 0; i < object.challengeIds.length; i++) {
      final value = object.challengeIds[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _onboardingProfileModelSerialize(
  OnboardingProfileModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.challengeIds);
  writer.writeDateTime(offsets[1], object.completedAt);
  writer.writeBool(offsets[2], object.isComplete);
}

OnboardingProfileModel _onboardingProfileModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = OnboardingProfileModel();
  object.challengeIds = reader.readStringList(offsets[0]) ?? [];
  object.completedAt = reader.readDateTimeOrNull(offsets[1]);
  object.id = id;
  object.isComplete = reader.readBool(offsets[2]);
  return object;
}

P _onboardingProfileModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ?? []) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _onboardingProfileModelGetId(OnboardingProfileModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _onboardingProfileModelGetLinks(
    OnboardingProfileModel object) {
  return [];
}

void _onboardingProfileModelAttach(
    IsarCollection<dynamic> col, Id id, OnboardingProfileModel object) {
  object.id = id;
}

extension OnboardingProfileModelQueryWhereSort
    on QueryBuilder<OnboardingProfileModel, OnboardingProfileModel, QWhere> {
  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension OnboardingProfileModelQueryWhere on QueryBuilder<
    OnboardingProfileModel, OnboardingProfileModel, QWhereClause> {
  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterWhereClause> idBetween(
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

extension OnboardingProfileModelQueryFilter on QueryBuilder<
    OnboardingProfileModel, OnboardingProfileModel, QFilterCondition> {
  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterFilterCondition> challengeIdsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'challengeIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterFilterCondition> challengeIdsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'challengeIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterFilterCondition> challengeIdsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'challengeIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterFilterCondition> challengeIdsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'challengeIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterFilterCondition> challengeIdsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'challengeIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterFilterCondition> challengeIdsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'challengeIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
          QAfterFilterCondition>
      challengeIdsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'challengeIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
          QAfterFilterCondition>
      challengeIdsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'challengeIds',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterFilterCondition> challengeIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'challengeIds',
        value: '',
      ));
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterFilterCondition> challengeIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'challengeIds',
        value: '',
      ));
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterFilterCondition> challengeIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'challengeIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterFilterCondition> challengeIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'challengeIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterFilterCondition> challengeIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'challengeIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterFilterCondition> challengeIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'challengeIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterFilterCondition> challengeIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'challengeIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterFilterCondition> challengeIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'challengeIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterFilterCondition> completedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'completedAt',
      ));
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterFilterCondition> completedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'completedAt',
      ));
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterFilterCondition> completedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterFilterCondition> completedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterFilterCondition> completedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterFilterCondition> completedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel,
      QAfterFilterCondition> isCompleteEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isComplete',
        value: value,
      ));
    });
  }
}

extension OnboardingProfileModelQueryObject on QueryBuilder<
    OnboardingProfileModel, OnboardingProfileModel, QFilterCondition> {}

extension OnboardingProfileModelQueryLinks on QueryBuilder<
    OnboardingProfileModel, OnboardingProfileModel, QFilterCondition> {}

extension OnboardingProfileModelQuerySortBy
    on QueryBuilder<OnboardingProfileModel, OnboardingProfileModel, QSortBy> {
  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel, QAfterSortBy>
      sortByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel, QAfterSortBy>
      sortByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel, QAfterSortBy>
      sortByIsComplete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isComplete', Sort.asc);
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel, QAfterSortBy>
      sortByIsCompleteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isComplete', Sort.desc);
    });
  }
}

extension OnboardingProfileModelQuerySortThenBy on QueryBuilder<
    OnboardingProfileModel, OnboardingProfileModel, QSortThenBy> {
  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel, QAfterSortBy>
      thenByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel, QAfterSortBy>
      thenByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel, QAfterSortBy>
      thenByIsComplete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isComplete', Sort.asc);
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel, QAfterSortBy>
      thenByIsCompleteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isComplete', Sort.desc);
    });
  }
}

extension OnboardingProfileModelQueryWhereDistinct
    on QueryBuilder<OnboardingProfileModel, OnboardingProfileModel, QDistinct> {
  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel, QDistinct>
      distinctByChallengeIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'challengeIds');
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel, QDistinct>
      distinctByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedAt');
    });
  }

  QueryBuilder<OnboardingProfileModel, OnboardingProfileModel, QDistinct>
      distinctByIsComplete() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isComplete');
    });
  }
}

extension OnboardingProfileModelQueryProperty on QueryBuilder<
    OnboardingProfileModel, OnboardingProfileModel, QQueryProperty> {
  QueryBuilder<OnboardingProfileModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<OnboardingProfileModel, List<String>, QQueryOperations>
      challengeIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'challengeIds');
    });
  }

  QueryBuilder<OnboardingProfileModel, DateTime?, QQueryOperations>
      completedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedAt');
    });
  }

  QueryBuilder<OnboardingProfileModel, bool, QQueryOperations>
      isCompleteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isComplete');
    });
  }
}
