import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/rentals/data/network/responses/driving_licence_response.dart';
import 'package:host_visitor_connect/features/rentals/data/repos/rental_repository.dart';

class DrivingLicenseBloc extends Cubit<UiState<DrivingLicenceResponse>> {
  final RentalRepository _rentalRepository;

  DrivingLicenseBloc({RentalRepository? rentalRepository})
      : _rentalRepository = rentalRepository ?? RentalRepository(),
        super(Default());

  Future drivingLicence({
    required String licenceNo,
    required String dob,
    required int id,
    required String name,
  }) {
    emit(Progress());
    return _rentalRepository
        .drivingLicence(
          name: name,
          id: id,
          licenceNo: licenceNo,
          dob: dob,
        )
        .then(_onSuccess)
        .handleError(_onError);
  }

  void _onSuccess(DrivingLicenceResponse drivingLicenceResponse) {
    emit(Success(drivingLicenceResponse));
  }

  _onError(exception) {
    emit(Error(exception as Exception));
  }
}
