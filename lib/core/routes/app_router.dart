

import 'package:task/features/feature/cubit/reels_cubit.dart';
import 'package:task/features/feature/data/models/video_model.dart';
import 'package:task/features/feature/presentation/screens/reels_screen.dart';

import '../common/widgets/no_route.dart';
import '../src/app_export.dart';

part 'app_routes.dart';

class AppRouter {
  static Route? generateRoutes(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        switch (settings.name) {
          case AppRoutes.initScreen:
            return BlocProvider(
                create: (context)=>getIt<ReelsBloc>(),
                child:  ReelsScreen(videoList: [
                  VideoModel(url: 'https://www.youtube.com/watch?v=OeM_9AtaID8', cachePath: 'cachePath1'),
                  VideoModel(url: 'https://www.youtube.com/watch?v=aBymNziLez4', cachePath: 'cachePath2'),
                ],));
          default:
            return NoRouteScreen(routeName: settings.name!);
        }
      },
    );
  }
}
