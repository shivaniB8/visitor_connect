import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:host_visitor_connect/common/constant/globalVariable.dart';
import 'package:host_visitor_connect/common/custom_widget/app_action_dilog.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/add_form_field.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_error.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/dashboard/bloc/user_details_bloc.dart';
import 'package:host_visitor_connect/features/dashboard/ui/home_page.dart';
import 'package:host_visitor_connect/features/login/blocs/login_with_password_bloc.dart';
import 'package:host_visitor_connect/common/extensions/local_data_extension.dart';
import 'package:host_visitor_connect/features/login/data/network/response/login_branch_response.dart';
import 'package:host_visitor_connect/features/login/data/network/response/login_data_response.dart';
import 'package:host_visitor_connect/features/login/ui/forgotPaswordWidget.dart';
import 'package:host_visitor_connect/features/login/ui/image_widget.dart';
import 'package:host_visitor_connect/landingScreen/Widget/background.dart';
import 'package:host_visitor_connect/landingScreen/Widget/footerImage.dart';
import 'package:host_visitor_connect/landingScreen/Widget/headerImage.dart';
import 'package:provider/provider.dart';
import '../../../common/blocs/state_events/ui_state.dart';
import '../../../common/custom_widget/widget/wrong_location.dart';
import '../../../generated/l10n.dart';
import 'login_branch_builder.dart';
import 'model/user_branch.dart';

class LoginBranchScreen extends StatefulWidget {
  final String? phoneNumber;
  final List<LoginDataResponse>? hostList;
  const LoginBranchScreen({
    super.key,
    this.phoneNumber,
    this.hostList,
  });

  @override
  State<LoginBranchScreen> createState() => _LoginBranchScreenState();
}

class _LoginBranchScreenState extends State<LoginBranchScreen> {
  late TextEditingController _textFieldController;
  String? _password;
  String phoneNo = '';
  bool obscureText = true;
  String? errorMsg = '';
  String errorMsgClient = '';
  bool? showDropDownError;
  KeyValueResponse? branch;
  LoginBranchResponse? branchValue;
  bool branchIsNull = false;
  List<KeyValueResponse>? branchList;
  Position? currentLocation;
  bool? loading;

  bool? showError = false;
  LoginDataResponse? _selectedItem;

  @override
  void initState() {
    // getBranchList();

    _textFieldController = TextEditingController();
    _textFieldController = TextEditingController();
    if (widget.hostList != null && widget.hostList!.length == 1) {
      _selectedItem = widget.hostList!.first;

      GlobalVariable.userName = _selectedItem?.ad9 ?? '';
      GlobalVariable.userImage = _selectedItem?.ad22 ?? '';
      getBranchList();

      setState(() {
        var branches = _selectedItem?.branches;
        String encodedMap = json.encode(branches);
        SharedPrefs.setString(keyBranchList, encodedMap);
      });

      // Add the branchId check here
      if (widget.hostList!.isEmpty) {
        print("no near branch");
        return;
      }
    }

    super.initState();
  }

  Future<void> printStoredNearestBranch() async {
    // Retrieve the JSON string of the nearest branch from SharedPrefs
    String? nearestBranchJson = SharedPrefs.getString('nearestBranch');

    // Check if a value is stored
    if (nearestBranchJson != null && nearestBranchJson.isNotEmpty) {
      print('Stored Nearest Branch JSON: $nearestBranchJson');

      // Optionally, you can decode the JSON to a Map or an object if you need to access specific fields
      Map<String, dynamic> nearestBranchMap = json.decode(nearestBranchJson);
      print('Decoded Nearest Branch: $nearestBranchMap');

      // If you have a KeyValueResponse model, you can convert it back to an object
      KeyValueResponse nearestBranch =
          KeyValueResponse.fromJson(nearestBranchMap);
      print('Nearest Branch Name: ${nearestBranch.label}');
      print('Nearest Branch Name: ${nearestBranch.branchAddress}');
    } else {
      print('No nearest branch stored in SharedPrefs.');
    }
  }

  getBranchList() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }
    setState(() {
      loading = true;
    });

    await getBranch().then((value) {
      // String encodedMap = json.encode(value);

      branchList = value;
      print(branchList);
      if (branchList != null && (branchList?.isNotEmpty ?? false)) {
        // Set the value of branchList to SharedPrefs
        SharedPrefs.setInt(
          keyBranch,
          branchList?[0].value ?? 0,
        );
        int? storedBranchId = SharedPrefs.getInt(keyBranch);

        // Assuming value holds the branch ID
      } else {
        showError = true;
      }
    });
    setState(() {
      loading = false;
    });
    printStoredNearestBranch();
    print("coming5 ----------------------------->");
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  bool dropdownValidationLogic() {
    if (context.read<UserBranch>().branchId == null ||
        context.read<UserBranch>().branchId == 0) {
      branchIsNull = true;
    } else {
      branchIsNull = false;
    }
    setState(() {});
    if (branchIsNull) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // canPop: loading == true ? false : true,
      child: Initializer(
        init: (context) {
          if ((branchList?.isEmpty ?? false || branchList == null) &&
              loading == false) {
            afterBuild(
              () async {
                try {
                  _showLocationPopup(context);
                } catch (_) {}
              },
            );
          }
        },
        child: Material(
          color: text_color.withOpacity(0.1),
          child: Stack(
            children: [
              BackGroundWidget(backgroundColor: text_color.withOpacity(0.4)),
              Container(
                margin: EdgeInsets.only(top: sizeHeight(context) / 12),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28)),
                  child: IgnorePointer(
                    ignoring: loading ?? false,
                    child: Scaffold(
                      backgroundColor: text_color.withOpacity(0.5),
                      body: Stack(
                        children: [
                          FormBuilder(
                            key: context.read<GlobalKey<FormBuilderState>>(),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: sizeHeight(context) / 100,
                                  ),
                                  const HeaderImage(),
                                  LoginImage(
                                    profileImage: GlobalVariable.userImage,
                                  ),
                                  SizedBox(
                                    height: sizeHeight(context) / 120,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                capitalizedString(
                                                    GlobalVariable.userName),
                                                style: AppStyle.bodySmall(
                                                        context)
                                                    .copyWith(
                                                        color:
                                                            primary_text_color,
                                                        fontWeight:
                                                            FontWeight.w400),
                                              ),
                                            ),
                                            // Flexible(
                                            //   child: Text(
                                            //     capitalizedString(
                                            //       branchList?.first.label ??
                                            //           'No Branch',
                                            //     ),
                                            //     style: AppStyle.bodySmall(context)
                                            //         .copyWith(
                                            //             color: primary_text_color,
                                            //             fontWeight:
                                            //                 FontWeight.w400),
                                            //   ),
                                            // ),
                                            // Container(
                                            //   margin:
                                            //       const EdgeInsets.only(left: 8),
                                            //   decoration: BoxDecoration(
                                            //       border: Border.all(
                                            //           width: 1.5,
                                            //           color: primary_text_color),
                                            //       borderRadius:
                                            //           BorderRadius.circular(50)),
                                            //   child: InkWell(
                                            //     borderRadius:
                                            //         BorderRadius.circular(50),
                                            //     highlightColor: primary_text_color
                                            //         .withOpacity(0.4),
                                            //     hoverColor: primary_text_color
                                            //         .withOpacity(0.4),
                                            //     onTap: () {
                                            //       SharedPrefs.clearUserData();
                                            //       Navigator.of(context).pop();
                                            //     },
                                            //     child: Padding(
                                            //       padding: EdgeInsets.symmetric(
                                            //           horizontal:
                                            //               sizeHeight(context) / 70,
                                            //           vertical:
                                            //               sizeHeight(context) /
                                            //                   120),
                                            //       child: Text(
                                            //         "Change",
                                            //         textAlign: TextAlign.center,
                                            //         style: AppStyle.bodySmall(
                                            //                 context)
                                            //             .copyWith(
                                            //                 fontWeight:
                                            //                     FontWeight.w600,
                                            //                 color:
                                            //                     primary_text_color),
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: sizeHeight(context) / 120,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Center(
                                  //   child: padding(
                                  //     Text(
                                  //       textAlign: TextAlign.center,
                                  //       'You can login into the system if your location matches with branch location',
                                  //       style: AppStyle.bodySmall(context)
                                  //           .copyWith(color: Colors.red),
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: sizeHeight(context) / 50,
                                  ),
                                  Row(
                                    children: [
                                      padding(
                                        Text(
                                          'Log In',
                                          style: AppStyle.headlineLarge(context)
                                              .copyWith(
                                                  color: primary_text_color,
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: sizeHeight(context) / 70,
                                  ),
                                  padding(
                                    AddFormField(
                                      maxLines: 1,
                                      onlyLoginPage: true,
                                      isReadOnly: true,
                                      hintText: widget.phoneNumber,
                                      label: '',
                                      cursorColor: primary_text_color,
                                      suffixIcon: pencilIconWidget(),
                                    ),
                                  ),
                                  multiBranch(),

                                  SizedBox(
                                    height: sizeHeight(context) / 50,
                                  ),
                                  padding(
                                    AddFormField(
                                      cursorColor: primary_text_color,
                                      onlyLoginPage: true,
                                      obscureText: obscureText,
                                      controller: _textFieldController,
                                      isRequired: true,
                                      hintText: S
                                          .of(context)
                                          .loginPage_label_enterPassword,
                                      keyboardType: TextInputType.text,
                                      maxLines: 1,
                                      suffixIcon: hideIconWidget(),
                                      onChanged: (password) {
                                        _password = password;
                                      },
                                      isEnable: (context
                                              .watch<LoginWithPasswordBloc>()
                                              .state is Progress)
                                          ? false
                                          : true,
                                      validator: (password) {
                                        if (password.isNullOrEmpty()) {
                                          return 'Please enter Password';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: sizeHeight(context) / 60,
                                  ),
                                  padding(
                                    ForgotPasswordWidget(
                                      phoneNumber: widget.phoneNumber,
                                      isEnable: false,
                                    ),
                                  ),
                                  SizedBox(
                                    height: sizeHeight(context) / 30,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    width: MediaQuery.of(context).size.width,
                                    child: LoginBranchBuilder(
                                      hostId: _selectedItem?.ad1,
                                      onLoginPressed: () {
                                        print("branchId");
                                        print(SharedPrefs.getInt(keyBranch));
                                        // SharedPrefs.setInt(keyBranch,
                                        //     branchList?.first.value ?? 0);
                                        dropdownValidationLogic();
                                        // if (_selectedItem?.ad1 == null) {
                                        //   setState(() {
                                        //     showDropDownError = true;
                                        //   });
                                        // } else
                                        if (FormErrorBuilder
                                            .validateFormAndShowErrors(
                                                context)) {
                                          context
                                              .read<LoginWithPasswordBloc>()
                                              .loginWithPassword(
                                                hostId: _selectedItem?.ad1,
                                                phoneNo:
                                                    widget.phoneNumber ?? '',
                                                branchId: SharedPrefs.getInt(
                                                        keyBranch) ??
                                                    0,
                                                password: _password ?? '',
                                              );
                                          if (branchList?.isNotEmpty ?? true) {
                                          } else {
                                            if (!(dropdownValidationLogic())) {
                                              context
                                                  .read<LoginWithPasswordBloc>()
                                                  .loginWithPassword(
                                                    hostId: _selectedItem?.ad1,
                                                    phoneNo:
                                                        widget.phoneNumber ??
                                                            '',
                                                    branchId:
                                                        SharedPrefs.getInt(
                                                                keyBranch) ??
                                                            0,
                                                    password: _password ?? '',
                                                  );
                                            }
                                          }
                                        }
                                      },
                                      onSuccess: () async {
                                        await context
                                            .read<UserDetailsBloc>()
                                            .userDetails();
                                        Navigator.pushAndRemoveUntil(
                                          // ignore: use_build_context_synchronously
                                          context,
                                          goToRoute(const HomePage(
                                            isFirst: true,
                                          )),
                                          (route) {
                                            return false;
                                          },
                                        );
                                      },
                                      password: _password,
                                      phoneNo: widget.phoneNumber,
                                    ),
                                  ),
                                  SizedBox(
                                    height: sizeHeight(context) / 20,
                                  ),
                                  const Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 0, left: 20, right: 20),
                                      child: FooterImage(
                                        image:
                                            "$images_path/goaElectronic1.png",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (loading ?? false)
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: sizeWidth(context) * 0.5,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            const LoadingWidget(),
                            SizedBox(
                              height: sizeHeight(context) / 50,
                            ),
                            Material(
                              color: Colors.transparent,
                              child: Text(
                                "Fetching Branch Details",
                                textAlign: TextAlign.center,
                                style: AppStyle.bodyLarge(context).copyWith(
                                    color: visitorNameColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget multiBranch() {
    return widget.hostList != null && widget.hostList!.length > 1
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: sizeHeight(context) / 50,
              ),
              padding(
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors
                              .transparent, // Set the background color of the container to transparent
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<LoginDataResponse>(
                              iconEnabledColor: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              dropdownColor: Colors.black,
                              value: _selectedItem,
                              hint: Text(
                                'Select Host',
                                style: AppStyle.bodyMedium(context).copyWith(
                                  color: primary_text_color,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              items: widget.hostList
                                  ?.map((LoginDataResponse item) {
                                return DropdownMenuItem<LoginDataResponse>(
                                  value: item,
                                  child: Text(
                                    capitalizedString(item.ad3 ?? ''),
                                    style:
                                        AppStyle.bodyMedium(context).copyWith(
                                      color: primary_text_color,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (LoginDataResponse? newValue) async {
                                setState(() {
                                  _selectedItem = newValue;

                                  print(newValue?.ad1);

                                  GlobalVariable.userName = newValue?.ad9 ?? '';
                                  GlobalVariable.userImage =
                                      newValue?.ad22 ?? '';

                                  var branches = newValue?.branches;
                                  String encodedMap = json.encode(branches);
                                  SharedPrefs.setString(
                                      keyBranchList, encodedMap);
                                });
                                await getBranchList();
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //       left: 8.0, right: 5, top: 5),
              //   child: Text(
              //     'Please Select Host',
              //     style: AppStyle.errorStyle(context),
              //   ),
              // ),
            ],
          )
        : Container(); // Return an empty Container or any other widget when the condition is not met
  }

  void _showLocationPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return PopScope(
          canPop: false,
          child: Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEBEDF3),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'Not Allowed',
                      style: AppStyle.bodyMedium(context),
                    ),
                  ),
                ),
                const WrongLocationWidget()
              ],
            ),
          ),
        );
      },
    ).then(
      (value) => Navigator.pop(context),
    );
  }

  Widget hideIconWidget() {
    return InkWell(
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
      onTap: () {
        setState(() {
          obscureText = !obscureText;
        });
      },
      child: obscureText
          ? Icon(
              Icons.visibility_off,
              color: primary_text_color,
              size: 20.sp,
            )
          : Icon(
              Icons.visibility,
              color: primary_text_color,
              size: 20.sp,
            ),
    );
  }

  Widget pencilIconWidget() {
    return InkWell(
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
      onTap: () => Navigator.pop(context),
      child: Icon(
        Icons.edit,
        color: primary_text_color,
        size: 20.sp,
      ),
    );
  }

  Padding padding(Widget child) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20), child: child);
  }
}
//
// class BranchBuilder extends StatelessWidget {
//   final bool? isFromListing;
//   final Function()? onUpdateVoterPressed;
//   final List<KeyValueResponse>? branchs;
//   final Function()? onSuccess;
//   final bool isUpdate;
//   final bool branchIsNull;
//
//   const BranchBuilder({
//     super.key,
//     this.onUpdateVoterPressed,
//     this.onSuccess,
//     this.isUpdate = false,
//     required this.branchIsNull,
//     this.branchs,
//     this.isFromListing,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return IgnorePointer(
//       ignoring: context.watch<LoginWithPasswordBloc>().state is Progress,
//       child: LoginFormDropDownWidget(
//         isFromBranch: true,
//         isNull: branchIsNull,
//         isRequired: true,
//         removeValue: () {
//           context.read<UserBranch>().branchId = 0;
//           context.read<UserBranch>().branchName = '';
//         },
//         errorMessage: "Please select Branch",
//         dropdownFirstItemName: 'Select Branch',
//         titles: branchs ?? [],
//         title: branchs?.first,
//         onTap: (data) {
//           if (data.value != null) {
//             SharedPrefs.setInt(keyBranch, data.value ?? 0);
//             context.read<UserBranch>().branchId = data.value;
//             context.read<UserBranch>().branchName = data.label;
//           }
//         },
//         isItEnabled: isFromListing ?? false
//             ? context.watch<LoginWithPasswordBloc>().state is Progress
//                 ? false
//                 : true
//             : context.watch<LoginWithPasswordBloc>().state is Progress
//                 ? false
//                 : true,
//       ),
//     );
//   }
// }
