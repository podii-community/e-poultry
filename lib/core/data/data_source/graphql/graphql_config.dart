import 'package:epoultry/core/utils/core_constants.dart';
import 'package:flutter/material.dart';
import "package:graphql_flutter/graphql_flutter.dart";

class GraphQLConfiguration {
  static Link? link;
  static HttpLink authentication =
      HttpLink(CoreConstants.authHttpLink);

  static HttpLink authorised =
      HttpLink(CoreConstants.authorisedHttpLink);

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
      defaultPolicies: DefaultPolicies(
        // make watched mutations behave like watched queries.
        watchMutation: Policies(
          fetch: FetchPolicy.networkOnly,
          error: ErrorPolicy.none,
          cacheReread: CacheRereadPolicy.mergeOptimistic,
        ),
        watchQuery: Policies(
          fetch: FetchPolicy.networkOnly,
          error: ErrorPolicy.none,
          cacheReread: CacheRereadPolicy.mergeOptimistic,
        ),
      ),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: GraphQLCache(),
      link: getLink()!,
      defaultPolicies: DefaultPolicies(
        // make watched mutations behave like watched queries.
        watchMutation: Policies(
          fetch: FetchPolicy.networkOnly,
          error: ErrorPolicy.none,
          cacheReread: CacheRereadPolicy.mergeOptimistic,
        ),
        watchQuery: Policies(
          fetch: FetchPolicy.networkOnly,
          error: ErrorPolicy.none,
          cacheReread: CacheRereadPolicy.mergeOptimistic,
        ),
      ),
    );
  }
}
