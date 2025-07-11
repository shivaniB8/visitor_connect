extension FutureExtensions on Future {
  Future<void> handleError(Function handleError) async {
    return catchError((error) {
      if (error is! Exception) {
        // Throw the error so that it will be tracked on
        // firebase crashlytics through runZonedGuarded in main common
        throw error;
      } else {
        handleError.call(error);
      }
    });
  }
}
