part of 'counter_bloc.dart';

@immutable
sealed class CounterState {}

final class CounterInitial extends CounterState {}

class CounterLoadingState extends CounterState {}

class CounterLoadState extends CounterState {
  CounterLoadState(this.counter);
  final Counter counter;
}

class CounterIncDecState extends CounterState {
  CounterIncDecState(this.counter);
  final Counter counter;
}
