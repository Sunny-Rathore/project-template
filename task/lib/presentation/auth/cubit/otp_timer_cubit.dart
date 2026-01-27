import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'otp_timer_state.dart';

class OtpTimerCubit extends Cubit<OtpTimerState> {
  static const int _initialDuration = 30;
  Timer? _timer;

  OtpTimerCubit() : super(const OtpTimerInitial(_initialDuration));

  void startTimer() {
    if (_timer?.isActive ?? false) {
      _timer!.cancel();
    }
    emit(const OtpTimerInProgress(_initialDuration));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.duration > 0) {
        emit(OtpTimerInProgress(state.duration - 1));
      } else {
        _timer?.cancel();
        emit(const OtpTimerFinished());
      }
    });
  }

  void resetTimer() {
    _timer?.cancel();
    emit(const OtpTimerInitial(_initialDuration));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
