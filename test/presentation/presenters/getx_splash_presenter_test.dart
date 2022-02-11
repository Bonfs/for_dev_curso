import 'package:faker/faker.dart';
import 'package:for_dev_curso/domain/entities/entities.dart';
import 'package:for_dev_curso/domain/usecases/load_current_account.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:for_dev_curso/ui/pages/splash/splash.dart';
import './getx_splash_presenter_test.mocks.dart';

class GetXSplashPresenter implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;
  final _navigateTo = RxString('');

  GetXSplashPresenter({ required this.loadCurrentAccount });

  @override
  Stream<String>? get navigateToStream => _navigateTo.stream;

  @override
  Future<void> checkAccount() async {
    await loadCurrentAccount.load();
  }
}

@GenerateMocks([], customMocks: [MockSpec<LoadCurrentAccount>(as: #LoadCurrentAccountSpy)])
void main() {
  late String token;
  late LoadCurrentAccountSpy loadCurrentAccount;
  late GetXSplashPresenter sut;

  PostExpectation mockLoadCurrentAccountCall() => when(loadCurrentAccount.load());

  void mockLoadCurrentAccount() {
    mockLoadCurrentAccountCall().thenAnswer((_) async => AccountEntity(token));
  }

  setUp(() {
    token = faker.guid.guid();
    loadCurrentAccount = LoadCurrentAccountSpy();
    sut = GetXSplashPresenter(loadCurrentAccount: loadCurrentAccount);
    mockLoadCurrentAccount();
  });

  test('Should call LoadCurrentAccount', () async {
    await sut.checkAccount();

    verify(loadCurrentAccount.load()).called(1);
  });
}