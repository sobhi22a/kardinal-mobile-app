import 'package:e_commerce_app/features/auth/domain/usecases/check_auth_usecase.dart';
import 'package:e_commerce_app/features/auth/domain/usecases/current_user_usecase.dart';
import 'package:e_commerce_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:e_commerce_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final CheckAuthUseCase checkAuthUseCase;
  final CurrentUserUsecase currentUserUsecase;

  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.checkAuthUseCase,
    required this.currentUserUsecase,
  }) : super(const AuthInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LogoutRequested>(_onLogoutRequested);
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<CurrentUserRequested>(_onCurrentUserRequested);
  }

  Future<void> _onCurrentUserRequested(CurrentUserRequested event, Emitter<AuthState> emit) async {
    final user = await currentUserUsecase();
    if (user == null) {
      emit(const AuthUnauthenticated());
    } else {
      emit(AuthAuthenticated(user));
    }
  }


  Future<void> _onLoginSubmitted(LoginSubmitted event,  Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final user = await loginUseCase(userName: event.userName, password: event.password);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(const AuthUnauthenticated());
    }
  }



  Future<void> _onLogoutRequested(
      LogoutRequested event,
      Emitter<AuthState> emit,
      ) async {
    await logoutUseCase();
    emit(const AuthUnauthenticated());
  }


  Future<void> _onAuthCheckRequested(AuthCheckRequested event, Emitter<AuthState> emit) async {
    final isLoggedIn = await checkAuthUseCase();
    if (!isLoggedIn) {
      emit(const AuthUnauthenticated());
      return;
    }

    final user = await currentUserUsecase();
    if (user == null) {
      emit(const AuthUnauthenticated());
      return;
    }

    emit(AuthAuthenticated(user));
  }
}