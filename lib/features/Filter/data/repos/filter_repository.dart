import 'package:host_visitor_connect/common/data/network/responses/key_value_list_response.dart';
import 'package:host_visitor_connect/features/Filter/data/network/api_service/filter_api_service.dart';

class FilterRepository {
  final GetFiltersApiServices _getFiltersApiServices;

  FilterRepository({GetFiltersApiServices? getFiltersApiServices})
      : _getFiltersApiServices =
            getFiltersApiServices ?? GetFiltersApiServices();

  Future<KeyValueListResponse> getStatesFilter() async {
    return _getFiltersApiServices.getStates();
  }

  Future<KeyValueListResponse> getCityFilter({required int? stateValue}) async {
    return _getFiltersApiServices.getCity(stateValue: stateValue);
  }

  Future<KeyValueListResponse> getAreaFilter({required int? cityValue}) async {
    return _getFiltersApiServices.getArea(cityValue: cityValue);
  }
}
