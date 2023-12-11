import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tuncjob/models/models.dart';

part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  SwipeBloc() : super(SwipeLoading());

  @override
  Stream<SwipeState> mapEventToState(SwipeEvent event) async* {
    if (event is LoadUsersEvent) {
      yield* _mapLoadUsersToState(event);
    } else if (event is SwipeRightEvent) {
      yield* _mapSwipeRightToState(event, state);
    } else if (event is SwipeLeftEvent) {
      yield* _mapSwipeLeftToState(event, state);
    }
  }

  Stream<SwipeState> _mapLoadUsersToState(LoadUsersEvent event) async* {
    yield SwipeLoaded(users: event.users);
  }

  Stream<SwipeState> _mapSwipeRightToState(
      SwipeRightEvent event, SwipeState state) async* {
    if (state is SwipeLoaded) {
      try {
        yield SwipeLoaded(
          users: List.from(state.users)..remove(event.user),
        );
      } catch (_) {}
    }
  }

  Stream<SwipeState> _mapSwipeLeftToState(
      SwipeLeftEvent event, SwipeState state) async* {
    if (state is SwipeLoaded) {
      try {
        yield SwipeLoaded(
          users: List.from(state.users)..remove(event.user),
        );
      } catch (_) {}
    }
  }
}
