import 'package:host_visitor_connect/features/rentals/data/network/api_services/rental_api_service.dart';
import 'package:host_visitor_connect/features/rentals/data/network/responses/driving_licence_response.dart';

class RentalRepository {
  final RentalApiService _rentalApiService;

  RentalRepository({RentalApiService? rentalApiService})
      : _rentalApiService = rentalApiService ?? RentalApiService();

  Future<DrivingLicenceResponse> drivingLicence({
    required String licenceNo,
    required String dob,
    required int id,
    required String name,
  }) async {
    return _rentalApiService.drivingLicense(
      id: id,
      name: name,
      licenceNo: licenceNo,
      dateOfBirth: dob,
    );
  }
}
