import 'package:task/features/feature/data/models/real_model.dart';
import 'package:task/features/feature/data/repository/reels_repository.dart';
import 'package:video_player/video_player.dart';

import '../../../core/src/app_export.dart';

part 'reels_state.dart';

class ReelsBloc extends Cubit<ReelsState> {
  final ReelsRepository _reelsRepository;
  ReelsBloc(
    this._reelsRepository,
  ) : super(ReelsIdle());

  static ReelsBloc get(context) => BlocProvider.of<ReelsBloc>(context);

  List<ReelModel> reelsList = [];
  List<VideoPlayerController> videoControllers = [];
  PageController pageController = PageController();

  int currentPage = 1;
  final int pageSize = 6;

  Future<void> getReels(int startIndex) async {
    try {
      final NetworkService<ReelsResponseModel> data =
          await _reelsRepository.getReals(startIndex, pageSize);
      if (data is Succeed<ReelsResponseModel>) {
        reelsList.addAll(data.data.data ?? []);
        var total = data.data.meta?.total!;
        for (var item in reelsList.skip(videoControllers.length)) {
          final controller = VideoPlayerController.networkUrl(Uri.parse(item.video ?? ''));
          await controller.initialize();
          videoControllers.add(controller);
        }
        print('reelsList ${reelsList.length}');
        emit(ReelsSuccess());
      } else if (data is Failure<ReelsResponseModel>) {
        emit(ReelsError(networkExceptions: data.networkExceptions));
      }
    } catch (e) {
      print("Error listener $e");
    }
  }

  Future<void> loadMoreVideos() async {
    emit(ReelsLoadingMore());
    currentPage++;
    await getReels(currentPage);

    for (var item in reelsList.skip(videoControllers.length)) {
      final controller =
          VideoPlayerController.networkUrl(Uri.parse(item.video ?? ''));
      await controller.initialize();
      videoControllers.add(controller);
    }

    emit(AddVideoSuccess());
  }

  void openCloseVideo(VideoPlayerController controller) {
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
    emit(OpenCloseVideoSuccess());
  }
}
