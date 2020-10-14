import 'package:flutter/material.dart';

import 'app_route_path.dart';

class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    // Handle '/'
    if (uri.pathSegments.isEmpty) {
      return AppRoutePath.home();
    }

    // Handle '/drives/:id'
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] != 'drives') return AppRoutePath.home();

      final driveId = uri.pathSegments[1];
      return AppRoutePath.drive(driveId);
    }

    // Handle unknown routes
    return AppRoutePath.home();
  }

  @override
  RouteInformation restoreRouteInformation(AppRoutePath path) {
    if (path.isHomePage) {
      return RouteInformation(location: '/');
    } else if (path.isDriveDetailPage) {
      return RouteInformation(location: '/drives/${path.driveId}');
    }

    return null;
  }
}
