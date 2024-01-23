import 'package:equatable/equatable.dart';

class ExampleModel extends Equatable {
  const ExampleModel({
    this.tokenType,
    this.expiresIn,
    this.accessToken,
    this.refreshToken,
    this.error,
    this.details,
    this.locale,
  });

  final String? tokenType;
  final int? expiresIn;
  final String? accessToken;
  final String? refreshToken;
  final String? error;
  final String? details;
  final String? locale;

  factory ExampleModel.fromJson(Map<String, dynamic> json) => ExampleModel(
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        accessToken: json["access_token"],
        details: json["details"],
        refreshToken: json["refresh_token"],
        error: json["error"],
        locale: json["locale"],
      );

  Map<String, dynamic> toJson() => {
        "token_type": tokenType,
        "expires_in": expiresIn,
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "locale": locale,
        "error": error,
        "details": details,
      };

  @override
  List<Object?> get props => [accessToken];
}
