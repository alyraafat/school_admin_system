abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppLoadingState extends AppStates {}

class AppChangeFieldState extends AppStates {}

class AppChangeDateState extends AppStates {}

//Get User:
class AppGetUserLoadingState extends AppStates {}

class AppGetUserSuccessState extends AppStates {}

class AppGetUserErrorState extends AppStates {
  String error;
  AppGetUserErrorState(this.error);
}

// Update User:
class AppUpdateUserLoadingState extends AppStates {}

class AppUpdateUserSuccessState extends AppStates {}

class AppUpdateUserErrorState extends AppStates {
  String error;
  AppUpdateUserErrorState(this.error);
}

// Get Admin:
class AppGetAdminLoadingState extends AppStates {}

class AppGetAdminSuccessState extends AppStates {}

class AppGetAdminErrorState extends AppStates {
  String error;
  AppGetAdminErrorState(this.error);
}

// Get one school:
class AppGetOneSchoolLoadingState extends AppStates {}

class AppGetOneSchoolSuccessState extends AppStates {}

class AppGetOneSchoolErrorState extends AppStates {
  String error;
  AppGetOneSchoolErrorState(this.error);
}


// Check Data in database:
class AppCheckDataInDatabaseLoadingState extends AppStates {}

class AppCheckDataInDatabaseSuccessState extends AppStates {}

class AppCheckDataInDatabaseErrorState extends AppStates
{
  final String error;
  AppCheckDataInDatabaseErrorState(this.error);
}

// Create BookingTimeModel:
class AppCreateBookingTimeLoadingState extends AppStates {}

class AppCreateBookingTimeSuccessState extends AppStates {}

class AppCreateBookingTimeErrorState extends AppStates
{
  final String error;
  AppCreateBookingTimeErrorState(this.error);
}

// Get BookingTimeModel:
class AppGetBookingTimeLoadingState extends AppStates {}

class AppGetBookingTimeSuccessState extends AppStates {}

class AppGetBookingTimeErrorState extends AppStates
{
  final String error;
  AppGetBookingTimeErrorState(this.error);
}

//Update BookingTimeModel:
class AppUpdateBookingTimeLoadingState extends AppStates {}

class AppUpdateBookingTimeSuccessState extends AppStates {}

class AppUpdateBookingTimeErrorState extends AppStates
{
  final String error;
  AppUpdateBookingTimeErrorState(this.error);
}

// Change Row color:

class AppChangeRowColorState extends AppStates {}
