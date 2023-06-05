import 'package:graphql_flutter/graphql_flutter.dart';

class ErrorModel {
  final String error;

  ErrorModel.fromString(String error_) : error = error_;

  ErrorModel.fromGraphError(List<GraphQLError> errors)
      : error = errors
            .map((e) => e.message)
            .toString()
            .replaceAll("(", "")
            .replaceAll(")", "")
            .split("_")
            .map((word) => word[0].toUpperCase() + word.substring(1))
            .join(" ");
}
