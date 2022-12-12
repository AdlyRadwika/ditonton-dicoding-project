// ignore_for_file: prefer_typing_uninitialized_variables

part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class GetTvDetailEvent extends TvDetailEvent {
  final idTv;

  const GetTvDetailEvent(this.idTv);
}
