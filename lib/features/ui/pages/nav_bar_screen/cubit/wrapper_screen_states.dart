abstract class WrapperScreenStates {}

class WrapperScreenInitial extends WrapperScreenStates {}

class WrapperScreenIndexChanged extends WrapperScreenStates {
  final int selectedIndex;

  WrapperScreenIndexChanged(this.selectedIndex);
}
