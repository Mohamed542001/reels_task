

import 'package:task/features/feature/cubit/reels_cubit.dart';
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
                child:  const ReelsScreen());
          default:
            return NoRouteScreen(routeName: settings.name!);
        }
      },
    );
  }
}
