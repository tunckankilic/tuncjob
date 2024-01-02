import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tuncjob/models/user_model.dart';
import 'package:tuncjob/repositories/database/database_storage.dart';
import 'package:tuncjob/repositories/storage/storage_repository.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final DatabaseStorage _databaseStorage;
  final StorageRepository _storageRepository;
  OnboardingBloc(
      {required DatabaseStorage databaseStorage,
      required StorageRepository storageRepository})
      : _databaseStorage = databaseStorage,
        _storageRepository = storageRepository,
        super(OnboardingLoading()) {
    on<StartOnboarding>(_onStartOnboarding);
    on<UpdateUser>(_onUpdateUser);
    on<UpdateUserImages>(_onUpdateUserImages);
  }

  void _onStartOnboarding(
      StartOnboarding event, Emitter<OnboardingState> emit) async {
    User user = const User(
      email: "",
      mobileNumber: "",
      id: "",
      name: "",
      age: 0,
      imageUrls: [],
      interests: [],
      bio: "",
      jobTitle: "",
      linkedIn: "",
      gitHub: "",
      gender: "",
    );
    String documentId = await _databaseStorage.createUser(user);
    emit(
      OnboardingLoaded(
        user: user.copyWith(id: documentId),
      ),
    );
  }

  void _onUpdateUser(
    UpdateUser event,
    Emitter<OnboardingState> emit,
  ) {
    if (state is OnboardingLoaded) {
      _databaseStorage.updateUser(event.user);
      emit(OnboardingLoaded(user: event.user));
    }
  }

  void _onUpdateUserImages(
    UpdateUserImages event,
    Emitter<OnboardingState> emit,
  ) async {
    if (state is OnboardingLoaded) {
      User user = (state as OnboardingLoaded).user;
      await _storageRepository.uploadImage(event.image, user);

      _databaseStorage.getUser(user.id).listen((user) {
        add(UpdateUser(user: user));
      });
    }
  }
}
