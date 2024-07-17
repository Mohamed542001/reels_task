import 'package:task/features/feature/data/models/real_model.dart';

import '../../../../core/src/app_export.dart';
import '../feature_data_source/reels_data_source.dart';

class ReelsRepository {
  final ReelsDataSource _reelsDataSource;

  ReelsRepository(this._reelsDataSource);


  Future<NetworkService<ReelsResponseModel>> getReals(int page, int perPage) async {
    try {
      var response = await _reelsDataSource.getReals(page,perPage);
      ReelsResponseModel reelsData = ReelsResponseModel.fromJson(response);
      print("success");
      return NetworkService.succeed(reelsData);
    } catch (error) {
      print("error");
      return NetworkService.failure(NetworkExceptions.getDioException(error));
    }
  }
}
