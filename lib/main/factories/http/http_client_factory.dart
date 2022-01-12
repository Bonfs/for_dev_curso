import 'package:http/http.dart' show Client;

import '../../../data/http/http.dart';
import '../../../infra/http/http.dart';

HttpClient makeHttpAdapter() {
  final client = Client();
  return HttpAdapter(client);
}