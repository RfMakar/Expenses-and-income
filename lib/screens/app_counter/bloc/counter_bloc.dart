import 'package:bloc/bloc.dart';
import 'package:budget/screens/app_counter/counter.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial()) {
    on<CounterLoadingEvent>((event, emit) async {
      emit(CounterLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      emit(CounterLoadState(counter));
    });
    on<CounterIncEvent>((event, emit) {
      counter.inc();
      emit(CounterIncDecState(counter));
    });
    on<CounterDecEvent>((event, emit) {
      if (counter.value <= 0) return;
      counter.dec();
      emit(CounterIncDecState(counter));
    });
  }

  final counter = Counter(0);
}
