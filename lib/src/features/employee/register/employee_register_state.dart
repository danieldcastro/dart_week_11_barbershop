enum EmployeeRegisterStateStatus { initial, success, error }

class EmployeeRegisterState {
  EmployeeRegisterState(
      {required this.status,
      required this.registerADM,
      required this.workDays,
      required this.workHours});

  EmployeeRegisterState.initial()
      : this(
          registerADM: false,
          status: EmployeeRegisterStateStatus.initial,
          workDays: [],
          workHours: [],
        );

  final EmployeeRegisterStateStatus status;
  final bool registerADM;
  final List<String> workDays;
  final List<int> workHours;
  EmployeeRegisterState copyWith(
      {EmployeeRegisterStateStatus? status,
      bool? registerADM,
      List<String>? workDays,
      List<int>? workHours}) {
    return EmployeeRegisterState(
        status: status ?? this.status,
        registerADM: registerADM ?? this.registerADM,
        workDays: workDays ?? this.workDays,
        workHours: workHours ?? this.workHours);
  }
}
