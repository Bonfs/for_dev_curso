import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:for_dev_curso/infra/cache/cache.dart';
import './local_storage_adapter_test.mocks.dart';

@GenerateMocks([], customMocks: [MockSpec<FlutterSecureStorage>(as: #FlutterSecureStorageSpy)])
void main() {
  late FlutterSecureStorageSpy secureStorage;
  late LocalStorageAdapter sut;
  late String key, value;

  setUp(() {
    secureStorage = FlutterSecureStorageSpy();
    sut = LocalStorageAdapter(secureStorage: secureStorage);
    key = faker.lorem.word();
    value = faker.guid.guid();    
  });

  group('saveSecure', () {
    void mockSaveSecureError() {
    when(secureStorage.write(key: anyNamed('key'), value: anyNamed('value')))
      .thenThrow(Exception());
    }
    
    test('Should call save secure with correct values', () async {
      await sut.saveSecure(key: key, value: value);

      verify(secureStorage.write(key: key, value: value));
    });
    
    test('Should throw if save secure throws', () async {
      mockSaveSecureError();
      final future = sut.saveSecure(key: key, value: value);

      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });

  group('fetchSecure', () {
    void mockSaveSecureError() {
    when(secureStorage.write(key: anyNamed('key'), value: anyNamed('value')))
      .thenThrow(Exception());
    }
    
    test('Should call fetch secure with correct value', () async {
      when(secureStorage.read(key: key)).thenAnswer((_) async => 'any_value');
      
      await sut.fetchSecure(key);

      verify(secureStorage.read(key: key));
    });
  });
}