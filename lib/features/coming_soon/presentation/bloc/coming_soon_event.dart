import 'package:equatable/equatable.dart';

abstract class ComingSoonEvent extends Equatable {
  @override List<Object?> get props => [];
}
class LoadUpcoming    extends ComingSoonEvent {}
class RefreshUpcoming extends ComingSoonEvent {}
class LoadMoreUpcoming extends ComingSoonEvent {
  final int page;
  LoadMoreUpcoming(this.page);
  @override List<Object?> get props => [page];
}