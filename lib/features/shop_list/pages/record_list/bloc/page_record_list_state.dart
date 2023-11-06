part of 'page_record_list_bloc.dart';

@immutable
sealed class PageRecordListState {}

final class PageRecordListInitial extends PageRecordListState {}

final class PageRecordListLoadingState extends PageRecordListState {}

final class PageRecordListLoadedState extends PageRecordListState {
  PageRecordListLoadedState(this.listRecordList);
  final List<RecordList> listRecordList;
}
