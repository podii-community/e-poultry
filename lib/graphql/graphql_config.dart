import 'package:flutter/material.dart';
import "package:graphql_flutter/graphql_flutter.dart";

class GraphQLConfiguration {
  static Link? link;
  static HttpLink authentication =
      HttpLink("https://cbsmartfarm.herokuapp.com/api/graphql/auth");

  static HttpLink authorised =
      HttpLink("https://cbsmartfarm.herokuapp.com/api/graphql");

  static void setToken(String token) {
    AuthLink alink = AuthLink(getToken: () async => 'Bearer $token');
    GraphQLConfiguration.link = alink.concat(authorised);
  }

  static void removeToken() {
    GraphQLConfiguration.link = null;
  }

  static Link? getLink() {
    return GraphQLConfiguration.link ?? GraphQLConfiguration.authentication;
  }

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: getLink()!,
      cache: GraphQLCache(),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: GraphQLCache(),
      link: getLink()!,
    );
  }
}
