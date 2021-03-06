part of 'sync_cubit.dart';

@immutable
abstract class SyncState extends Equatable {
  @override
  List<Object> get props => [];
}

class SyncIdle extends SyncState {}

class SyncInProgress extends SyncState {}
