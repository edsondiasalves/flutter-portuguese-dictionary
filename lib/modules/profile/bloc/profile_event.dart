abstract class ProfileEvent {
  const ProfileEvent();
}

class ProfileInitializeEvent extends ProfileEvent {}

class ProfileLoginEvent extends ProfileEvent {}

class ProfileRegisterEvent extends ProfileEvent {}
