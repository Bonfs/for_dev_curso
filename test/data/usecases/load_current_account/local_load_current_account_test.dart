import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:for_dev_curso/data/usecases/usecases.dart';
import 'package:for_dev_curso/data/cache/cache.dart';
import 'package:for_dev_curso/domain/entities/entities.dart';
import 'package:for_dev_curso/domain/helpers/helpers.dart';
import './local_load_current_account_test.mocks.dart';

@GenerateMocks([], customMocks: [MockSpec<FetchSecureCacheStorage>(as: #FetchSecureCacheStorageSpy)])
void main() {
  late LocalLoadCurrentAccount sut;
  late FetchSecureCacheStorageSpy fetchSecureCacheStorage;
  late String token;

  PostExpectation mockFetchSecureCall() => when(fetchSecureCacheStorage.fetchSecure(any));

  void mockFetchSecure() {
    mockFetchSecureCall()
      .thenAnswer((_) async => token);
  }

  void mockFetchSecureError() {
    mockFetchSecureCall()
      .thenThrow(Exception());
  }

  setUp(() {
    fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    sut = LocalLoadCurrentAccount(fetchSecureCacheStorage: fetchSecureCacheStorage);
    token = faker.guid.guid();
    mockFetchSecure();
  });
  
  test('Should call FetchSecureCacheStorage with correct value', () async {
    await sut.load();

    verify(fetchSecureCacheStorage.fetchSecure('token'));
  });

  test('Should return an AccountEntity', () async {
    final account = await sut.load();

    expect(account, AccountEntity(token));
  });

  test('Should throw UnexpectedError if FetchSecureCacheStorage throws', () async {
    mockFetchSecureError();

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}