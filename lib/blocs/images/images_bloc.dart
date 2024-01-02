import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tuncjob/repositories/database/database_storage.dart';

part 'images_event.dart';
part 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  final DatabaseStorage _databaseStorage;
  StreamSubscription? _databaseSubscription;
  ImagesBloc({required DatabaseStorage databaseStorage})
      : _databaseStorage = databaseStorage,
        super(ImagesLoading()) {
    on<LoadImages>(_onLoadImages);
    on<UpdateImages>(_onUpdateImages);
  }

  void _onLoadImages(LoadImages event, Emitter<ImagesState> emit) {
    _databaseSubscription?.cancel();
    _databaseStorage.getUser().listen((event) {
      add(
        UpdateImages(event.imageUrls),
      );
    });
  }

  void _onUpdateImages(UpdateImages event, Emitter<ImagesState> emit) {
    emit(ImagesLoaded(imageUrls: event.imageUrls));
  }

  @override
  Future<void> close() {
    _databaseSubscription?.cancel();
    return super.close();
  }
}
