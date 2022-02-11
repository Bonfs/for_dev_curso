import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:for_dev_curso/domain/entities/entities.dart';
import 'package:for_dev_curso/domain/usecases/load_current_account.dart';
import 'package:for_dev_curso/presentation/presenters/presenters.dart';
import './getx_splash_presenter_test.mocks.dart';

@GenerateMocks([], customMocks: [MockSpec<LoadCurrentAccount>(as: #LoadCurrentAccountSpy)])
void main() {
  late String token;
  late LoadCurrentAccountSpy loadCurrentAccount;
  late GetXSplashPresenter sut;

  PostExpectation mockLoadCurrentAccountCall() => when(loadCurrentAccount.load());

  void mockLoadCurrentAccount({AccountEntity? account}) {
    mockLoadCurrentAccountCall().thenAnswer((_) async => account);
  }

  void mockLoadCurrentAccountError() {
    mockLoadCurrentAccountCall().thenThrow(Exception());
  }

  setUp(() {
    token = faker.guid.guid();
    loadCurrentAccount = LoadCurrentAccountSpy();
    sut = GetXSplashPresenter(loadCurrentAccount: loadCurrentAccount);
    mockLoadCurrentAccount(account: AccountEntity(token));
  });

  test('Should call LoadCurrentAccount', () async {
    await sut.checkAccount();

    verify(loadCurrentAccount.load()).called(1);
  });

  test('Should go to survey page on success', () async {
    sut.navigateToStream?.listen(expectAsync1((page) => expect(page, '/surveys')));

    await sut.checkAccount();
  });

  test('Should go to login page on null result', () async {
    mockLoadCurrentAccount(account: null);

    sut.navigateToStream?.listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount();
  });

  test('Should go to login page on error', () async {
    mockLoadCurrentAccountError();

    sut.navigateToStream?.listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount();
  });
}