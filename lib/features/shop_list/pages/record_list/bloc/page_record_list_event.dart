part of 'page_record_list_bloc.dart';

@immutable
sealed class PageRecordListEvent {}

class PageRecordListLoadingEvent extends PageRecordListEvent {}

class PageRecordListLoadedEvent extends PageRecordListEvent {}

class PageRecordListOnTapEvent extends PageRecordListEvent {
  PageRecordListOnTapEvent(this.recordList, this.select);
  final RecordList recordList;
  final bool select;
}
