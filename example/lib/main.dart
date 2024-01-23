import 'package:example/api_client.dart';
import 'package:example/models/example_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void registerModels() {
  GetIt.I.registerFactoryParam<ExampleModel, Map<String, dynamic>, String?>(
    (param1, param2) => ExampleModel.fromJson(param1),
  );
}

void main() {
  registerModels();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ApiClient apiClient = ApiClient(baseUrl: "https://panel.wirtualnykelner.pl");
  String example = "";
  @override
  void initState() {
    exampleMethod();
    super.initState();
  }

  Future<void> exampleMethod() async {
    var responseModel = await apiClient.exampleMethod();
    print(responseModel.accessToken);
    setState(() {
      example = responseModel.accessToken ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              example,
            ),
          ],
        ),
      ),
    );
  }
}
