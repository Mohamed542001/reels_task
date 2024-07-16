import 'package:task/features/feature/data/models/real_model.dart';
import 'package:task/features/feature/data/repository/reels_repository.dart';
import 'package:video_player/video_player.dart';

import '../../../core/src/app_export.dart';
import '../data/models/video_model.dart';

part 'reels_state.dart';

class ReelsBloc extends Cubit<ReelsState> {
  final ReelsRepository _reelsRepository;
  ReelsBloc(
    this._reelsRepository,
  ) : super(ReelsIdle());

  static ReelsBloc get(context) => BlocProvider.of<ReelsBloc>(context);


  List<RealModel> reelsList = [];



  Future<void> getReals() async {
    emit(ReelsLoading());
    final NetworkService<List<RealModel>> data =
    await _reelsRepository.getReals();
    switch (data) {
      case Succeed<List<RealModel>>(
      data: List<RealModel> reelsData
      ):
        reelsList.clear();
        reelsList = reelsData;
        print("list length ${reelsList.length}");
        await initVideos(reelsList);
        emit(ReelsSuccess());
      case Failure<List<RealModel>>(
      networkExceptions: NetworkExceptions error
      ):
        emit(ReelsError(networkExceptions: error));
    }
  }


  List<VideoPlayerController> videoControllers = [];
  PageController pageController = PageController();
  initVideos(List<RealModel> reels){
    print(reelsList.length);
    for (var item in reels) {
      videoControllers.add(VideoPlayerController.networkUrl(Uri.parse(item.video??''))
        ..initialize().then((_) {
          emit(AddVideoSuccess());
        }));
    }
  }


  void openCloseVideo(VideoPlayerController controller){
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
    emit(OpenCloseVideoSuccess());
  }
}
