import 'package:task/features/feature/data/models/real_model.dart';

import '../../../../core/src/app_export.dart';
import '../feature_data_source/reels_data_source.dart';

class ReelsRepository {
  final ReelsDataSource _reelsDataSource;

  ReelsRepository(this._reelsDataSource);


  Future<NetworkService<List<RealModel>>> getReals(int page, int perPage) async {
    try {
      List<dynamic> response = await _reelsDataSource.getReals(page,perPage);
      List<RealModel> reelsData =
      response.map((data) => RealModel.fromJson(data)).toList();
      print("success");
      return NetworkService.succeed(reelsData);
    } catch (error) {
      print("error");
      return NetworkService.failure(NetworkExceptions.getDioException(error));
    }
  }
}
