import 'package:budget/screens/app_counter/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenCounter extends StatelessWidget {
  const ScreenCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (context) => CounterBloc(),
      child: Builder(builder: (context) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleCounter(),
              MyButton(),
            ],
          ),
        );
      }),
    );
  }
}

class TitleCounter extends StatelessWidget {
  const TitleCounter({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CounterBloc>(context);

    return BlocBuilder<CounterBloc, CounterState>(
      bloc: bloc..add(CounterLoadingEvent()),
      builder: (context, state) {
        if (state is CounterLoadingState) {
          return const CircularProgressIndicator();
        }
        if (state is CounterLoadState) {
          return Text('${state.counter.value}');
        }
        if (state is CounterIncDecState) {
          return Text('${state.counter.value}');
        }
        return const Text('dsd');
      },
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CounterBloc>(context);
    return Column(
      children: [
        IconButton(
          onPressed: () {
            bloc.add(CounterIncEvent());
          },
          icon: const Icon(Icons.add),
        ),
        IconButton(
          onPressed: () {
            bloc.add(CounterDecEvent());
          },
          icon: const Icon(Icons.remove),
        ),
      ],
    );
  }
}
