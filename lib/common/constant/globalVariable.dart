// ignore: file_names
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/aadhar_data_response.dart';

class GlobalVariable {
  static const String fontFamily = "Poppins";
  static List<AadharDataResponse> aadharData = [];
  static String userName = "";
  static String userImage = "";
  static var callBackVisitorsList;
  static var callBackCurrentVisitorsList;
  static var callBackRentedList;

  static var RAZOR_PAY_KEY = "rzp_test_lMZsZ75t7Itqg3";
  static var RAZOR_PAY_SECRET = "2nhIp8PjCOElL2jjRiVgUFpc";
  static int selectedCarRental = 0; //for current 0 for all 1
}
