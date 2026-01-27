import 'package:equatable/equatable.dart';

abstract class OtpTimerState extends Equatable {
  final int duration;
  const OtpTimerState(this.duration);

  @override
  List<Object> get props => [duration];
}

class OtpTimerInitial extends OtpTimerState {
  const OtpTimerInitial(super.duration);
}

class OtpTimerInProgress extends OtpTimerState {
  const OtpTimerInProgress(super.duration);
}

class OtpTimerFinished extends OtpTimerState {
  const OtpTimerFinished() : super(0);
}
