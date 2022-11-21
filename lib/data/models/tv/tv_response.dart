import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:equatable/equatable.dart';

class TvResponse extends Equatable {
  final List<TvModel> TvList;

  TvResponse({required this.TvList});

  factory TvResponse.fromJson(Map<String, dynamic> json) => TvResponse(
        TvList: List<TvModel>.from((json["results"] as List)
            .map((x) => TvModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(TvList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [TvList];
}
