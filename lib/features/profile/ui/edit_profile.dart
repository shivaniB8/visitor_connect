import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/blocs/validator_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/add_form_field.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_error.dart';
import 'package:host_visitor_connect/common/custom_widget/title_full_name.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/common/upload_image.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';

import 'package:host_visitor_connect/features/dashboard/data/network/responses/user_details_response.dart';
import 'package:host_visitor_connect/features/profile/bloc/update_profile_bloc.dart';
import 'package:host_visitor_connect/features/profile/ui/model/update_profile.dart';

import 'package:host_visitor_connect/features/profile/ui/update_profile_builder.dart';

import 'package:image_picker/image_picker.dart';
import '../../../common/data/network/responses/key_value_response.dart';

class EditProfile extends StatefulWidget {
  final List<KeyValueResponse>? titles;
  final UserDetailsResponse? userDetails;

  const EditProfile({
    super.key,
    this.titles,
    this.userDetails,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  XFile? profilePhoto;
  final focusNodeFullName = FocusNode();
  final focusNodeEmail = FocusNode();

  bool hasFocus = false;
  bool isTitleNull = false;
  bool firstNameNotValid = false;

  bool shouldGoBack = false;

  bool checkFirstNameIsNull() {
    if (context.read<UpdateProfile>().fullName.isNullOrEmpty()) {
      firstNameNotValid = true;
    } else {
      firstNameNotValid = false;
    }

    setState(() {});

    if (isTitleNull || firstNameNotValid) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<UpdateProfile>().title = widget.userDetails?.title;
    context.read<UpdateProfile>().fkTitle = widget.userDetails?.fkTitle;
    context.read<UpdateProfile>().fullName = capitalizedString([
      widget.userDetails?.firstName,
      widget.userDetails?.middleName,
      widget.userDetails?.lastName,
    ].where((part) => part != null && part.isNotEmpty).join(' '));
    context.read<UpdateProfile>().email = widget.userDetails?.email;
    context.read<UpdateProfile>().address = widget.userDetails?.address;

    focusNodeFullName.addListener(() {
      setState(() {
        hasFocus = focusNodeFullName.hasFocus;
      });
    });

    focusNodeEmail.addListener(() {
      setState(() {
        hasFocus = focusNodeEmail.hasFocus;
      });
    });
  }

  Future<bool> _onBackPressed() async {
    if (context.read<UpdateProfileBloc>().state is Progress) {
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  void dispose() {
    focusNodeFullName.dispose();
    focusNodeEmail.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: IgnorePointer(
        ignoring: shouldGoBack,
        // ignoring: context.watch<UpdateProfileBloc>().state is Progress,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomImageAppBar(
            title: 'Edit Profile',
            context: context,
            showSettings: false,
            showEditIcon: false,
          ),
          body: Padding(
            padding: EdgeInsets.only(
              top: sizeHeight(context) / 30,
              left: 15,
              right: 15,
              bottom: sizeHeight(context) / 30,
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: FormBuilder(
                      key: context.read<GlobalKey<FormBuilderState>>(),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            uploadImage(),
                            SizedBox(
                              height: sizeHeight(context) / 30,
                            ),
                            BlocProvider(
                              create: (context) => ValidatorOnChanged(),
                              child: BlocBuilder<ValidatorOnChanged, String>(
                                builder: (context, state) {
                                  return TitleAndFirstNameWidget(
                                    isItEnabled: context
                                            .watch<UpdateProfileBloc>()
                                            .state is Progress
                                        ? false
                                        : true,
                                    isEnable: context
                                            .watch<UpdateProfileBloc>()
                                            .state is Progress
                                        ? false
                                        : true,
                                    state: state,
                                    onChanged: (name) {
                                      String? fullName;
                                      if (name.isNotEmpty) {
                                        fullName = name.trimLeft();
                                        fullName = name.trimRight();
                                      }
                                      context
                                          .read<ValidatorOnChanged>()
                                          .validateFullName(
                                            fullName ?? '',
                                          );

                                      context.read<UpdateProfile>().fullName =
                                          fullName; // First name
                                    },
                                    validator: (value) {
                                      if (value.isNullOrEmpty()) {
                                        firstNameNotValid = true;
                                        setState(() {});
                                      }
                                      if (!(value.isNullOrEmpty())) {
                                        int spaceCount =
                                            value!.split(' ').length - 1;
                                        if (spaceCount == 0) {
                                          firstNameNotValid = true;
                                          setState(() {});
                                        } else if (spaceCount >= 1 &&
                                            spaceCount <= 3) {
                                          firstNameNotValid = false;
                                        } else if (spaceCount > 3) {
                                          firstNameNotValid = true;
                                          setState(() {});
                                        }
                                      }
                                      return null;
                                    },
                                    focusNode: focusNodeFullName,
                                    isTitleNull: isTitleNull,
                                    isFirstNameNotValid: firstNameNotValid,
                                    onTap: (data) {
                                      context.read<UpdateProfile>().fkTitle =
                                          data.value;
                                      context.read<UpdateProfile>().title =
                                          data.label;
                                    },
                                    isUpdate: true,
                                    initialValue: capitalizedString((context
                                            .read<UpdateProfile>()
                                            .fullName ??
                                        '')),
                                    titles: widget.titles,
                                    title:
                                        context.read<UpdateProfile>().fkTitle,
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: sizeHeight(context) / 40,
                            ),
                            AddFormField(
                              label: 'Mobile Number',
                              isRequired: true,
                              countryCode: '91',
                              isMobileNumber: true,
                              isEnable: false,
                              errorMsg: "",
                              initialValue:
                                  widget.userDetails?.mobileNumber ?? '',
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                            SizedBox(
                              height: sizeHeight(context) / 100,
                            ),
                            BlocProvider(
                              create: (context) => ValidatorOnChanged(),
                              child: BlocBuilder<ValidatorOnChanged, String>(
                                  builder: (context, state) {
                                return AddFormField(
                                  isEnable: context
                                          .read<UpdateProfileBloc>()
                                          .state is Progress
                                      ? false
                                      : true,
                                  keyboardType: TextInputType.emailAddress,
                                  initialValue: widget.userDetails?.email,
                                  maxLength: 50,
                                  errorMsg: state,
                                  focusNode: focusNodeEmail,
                                  hintText: 'Enter your Email',
                                  label: 'Email Id',
                                  onChanged: (email) {
                                    context
                                        .read<ValidatorOnChanged>()
                                        .validateEmail(email);

                                    context.read<UpdateProfile>().email = email;
                                  },
                                  validator: (value) {
                                    if (value?.isNotEmpty ?? false) {
                                      if (!RegExp(
                                              "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                          .hasMatch(value ?? '')) {
                                        return 'Please enter valid Email Id';
                                      }
                                    }
                                    return null;
                                  },
                                );
                              }),
                            ),
                            SizedBox(
                              height: sizeHeight(context) / 140,
                            ),
                            AddFormField(
                              hintText: 'Current Address',
                              initialValue: capitalizedString(
                                widget.userDetails?.address ?? '',
                              ),
                              label: 'Current Address',
                              isEnable: context.read<UpdateProfileBloc>().state
                                      is Progress
                                  ? false
                                  : true,
                              onChanged: (address) {
                                context.read<UpdateProfile>().address = address;
                              },
                            ),
                            SizedBox(
                              height: sizeHeight(context) / 20,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: UpdateProfileBuilder(
                                onUpdateUserDetailsPressed: () {
                                  checkFirstNameIsNull();
                                  if (FormErrorBuilder
                                      .validateFormAndShowErrors(context)) {
                                    context.read<UpdateProfile>().userId =
                                        SharedPrefs.getInt(keyUserId);
                                    FocusScope.of(context).unfocus();
                                    if (!checkFirstNameIsNull()) {
                                      context
                                          .read<UpdateProfileBloc>()
                                          .updateUserDetails(
                                            profilePhoto:
                                                profilePhoto ?? XFile(''),
                                            userUpdatedData: context
                                                .read<UpdateProfile>()
                                                .toApiModel()
                                                .toJson(),
                                          );
                                    }
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget uploadImage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (profilePhoto?.path.isNotEmpty ?? false)
          Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: background_dark_grey),
            height: appSize(context: context, unit: 10) / 2.5,
            width: appSize(context: context, unit: 10) / 2.5,
            child: ClipOval(
              child: (profilePhoto?.name.contains(".png") ?? false) ||
                      (profilePhoto?.name.contains(".jpg") ?? false) ||
                      (profilePhoto?.name.contains(".jpeg") ?? false)
                  ? Image.file(
                      File(
                        profilePhoto?.path ?? '',
                      ),
                      fit: BoxFit.cover,
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        if (profilePhoto == null)
          CachedNetworkImage(
            fadeInDuration: const Duration(seconds: 0),
            fadeOutDuration: const Duration(seconds: 0),
            placeholderFadeInDuration: const Duration(seconds: 0),
            width: appSize(context: context, unit: 10) / 2.5,
            height: appSize(context: context, unit: 10) / 2.5,
            fit: BoxFit.cover,
            imageUrl:
                '$googlePhotoUrl${getBucketName()}$userPhoto${widget.userDetails?.userPhoto}',
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: background_dark_grey,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: background_dark_grey,
                ),
                padding:
                    EdgeInsets.all(appSize(context: context, unit: 10) / 10),
                width: appSize(context: context, unit: 10) / 8.5,
                height: appSize(context: context, unit: 10) / 8.5,
                child: const CircularProgressIndicator()),
            errorWidget: (context, url, error) => CircleAvatar(
              radius: 50,
              backgroundColor: background_dark_grey,
              child: Image.asset(
                fit: BoxFit.contain,
                '$icons_path/gallery.png',
                width: appSize(context: context, unit: 10) / 6.0,
                height: appSize(context: context, unit: 10) / 6.0,
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: UploadImage(
            isEnable: context.watch<UpdateProfileBloc>().state is Progress
                ? false
                : true,
            onImageSelected: (image) {
              setState(() {
                profilePhoto = image;
              });
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: Center(
                  child: Text(
                    'Upload Photo',
                    style: AppStyle.bodyLarge(context).copyWith(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
