import '../../domain/usecases/usecases.dart';
import '../http/http.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  Future<void> auth(AuthenticationParams params) async {
    final body = RemoteAuthenticationParams.fromModel(params).toJson();
    await httpClient.request(
      url: url, 
      method: 'post', 
      body: body,
    );
  }

  RemoteAuthentication({
    required this.httpClient,
    required this.url
  });
}

class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({
    required this.email, 
    required this.password
  });

  factory RemoteAuthenticationParams.fromModel(AuthenticationParams params) =>
    RemoteAuthenticationParams(email: params.email, password: params.password);

  Map toJson() => { 'email': email, 'password': password };
}