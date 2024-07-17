import 'package:flutter/cupertino.dart';
import 'package:task/features/feature/cubit/reels_cubit.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/src/app_export.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key,});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  late ReelsBloc cubit;

  @override
  void initState() {
    super.initState();
    cubit = ReelsBloc.get(context);
    cubit.getReels(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reels App',
          style: AppTextStyles.textStyle(color: Colors.white, size: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        height: double.infinity,
        color: Colors.black,
        child: BlocBuilder<ReelsBloc, ReelsState>(
          builder: (context, state) {
            if (cubit.videoControllers.isEmpty) {
              return const Center(
                  child: CupertinoActivityIndicator(
                color: AppColors.white,
              ));
            } else {
              return Column(
                children: [
                  Expanded(
                    // height: 250,
                    child: PageView.builder(
                      controller: cubit.pageController,
                      scrollDirection: Axis.vertical,
                      itemCount: cubit.videoControllers.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final controller = cubit.videoControllers[index];
                        return controller.value.isInitialized
                            ? GestureDetector(
                            onTap: () {
                              cubit.openCloseVideo(controller);
                            },
                            child: VideoPlayer(controller))
                            : const Center(
                            child: CupertinoActivityIndicator());
                      },
                      onPageChanged: (index) {
                        for (var controller in cubit.videoControllers) {
                          controller.pause();
                        }
                        cubit.videoControllers[index].play();
                        if (index == cubit.videoControllers.length - 1) {
                          cubit.loadMoreVideos();
                        }
                      },
                    ),
                  ),
                  if ((state is ReelsLoadingMore)||(cubit.videoControllers.length!=cubit.reelsList.length))...[
                    SizedBox(
                      height: 5.h,
                    ),
                    const CupertinoActivityIndicator(
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                  ]
                ],
              );
            }
          },
        ),
      ),
    );
  }
}


