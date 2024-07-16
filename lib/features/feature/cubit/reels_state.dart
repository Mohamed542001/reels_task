part of 'reels_cubit.dart';

class ReelsState {}

class ReelsIdle extends ReelsState {}

class ReelsLoading extends ReelsState {}

class ReelsSuccess extends ReelsState {}
class ReelsLoadingMore extends ReelsState {}
class AddVideoLoading extends ReelsState {}
class AddVideoSuccess extends ReelsState {}
class OpenCloseVideoSuccess extends ReelsState {}

class ReelsError extends ReelsState {
  final NetworkExceptions networkExceptions;
  ReelsError({
    required this.networkExceptions,
  });
}
