class AppRoutePath {
  final String driveId;

  AppRoutePath.home() : driveId = null;

  AppRoutePath.drive(this.driveId);

  bool get isHomePage => driveId == null;

  bool get isDriveDetailPage => driveId != null;
}
