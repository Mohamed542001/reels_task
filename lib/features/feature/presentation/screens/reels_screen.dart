import 'package:task/features/feature/cubit/reels_cubit.dart';
import 'package:task/features/feature/data/models/video_model.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/src/app_export.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key, required this.videoList});
  final List<VideoModel> videoList;

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  late ReelsBloc cubit;

  @override
  void initState() {
    super.initState();
    cubit = ReelsBloc.get(context);
    cubit.getReals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Video PageView',
          style: AppTextStyles.textStyle(color: Colors.white, size: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        height: double.infinity,
        color: Colors.black,
        child: BlocBuilder<ReelsBloc, ReelsState>(
          builder: (context, state) {
            if (state is ReelsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ReelsSuccess || state is AddVideoSuccess||state is OpenCloseVideoSuccess) {
              return SizedBox(
                height: 250,
                child: PageView.builder(
                  controller: cubit.pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: cubit.reelsList.length,
                  itemBuilder: (context, index) {
                    final controller = cubit.videoControllers[index];
                    return controller.value.isInitialized
                        ? GestureDetector(
                        onTap: () {
                          cubit.openCloseVideo(controller);
                          print(cubit.reelsList[index].video);
                        },
                        child: VideoPlayer(controller))
                        : const Center(child: CircularProgressIndicator());
                  },
                  onPageChanged: (index) {
                    for (var controller in cubit.videoControllers) {
                      controller.pause();
                    }
                    cubit.videoControllers[index].play();
                  },
                ),
              );
            } else {
              return const Center(child: Text('Error loading videos'));
            }
          },
        ),
      ),
    );
  }
}
