import 'package:example/models/example_model.dart';
import 'package:rest_api/rest_api.dart';

class ApiClient extends RestApi {
  static const String exampleEndpoint = "/api/auth_guest";
  ApiClient({required super.baseUrl});

  Future<ExampleModel> exampleMethod() async {
    var userModel = await post<ExampleModel>(
      exampleEndpoint,
    );
    return userModel;
  }

  @override
  Map<String, String> defaultErrorJson() {
    return {"error": "error text"};
  }

  @override
  void setToken(String token) {}
}
