import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_error.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/upload_image.dart';
import 'package:host_visitor_connect/features/dashboard/bloc/user_document_bloc.dart';
import 'package:host_visitor_connect/features/dashboard/ui/user_documents_builder.dart';
import 'package:image_picker/image_picker.dart';

class UserDocumentsScreen extends StatefulWidget {
  final bool? isHomePassword;

  const UserDocumentsScreen({
    this.isHomePassword,
    super.key,
  });

  @override
  State<UserDocumentsScreen> createState() => _UserDocumentsScreenState();
}

class _UserDocumentsScreenState extends State<UserDocumentsScreen> {
  String? errorMsg;
  XFile? aadharFront;
  XFile? aadharBack;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: context.watch<UserDocumentBloc>().state is Progress,
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFEBEDF3),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),

                //..
                child: Padding(
                  padding: EdgeInsets.all(8),

                  //..
                  child: SizedBox(
                    height: 35,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'User Documents',
                          style: AppStyle.bodyMedium(context)
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 10,
                    ),
                    child: SingleChildScrollView(
                      child: FormBuilder(
                        key: context.read<GlobalKey<FormBuilderState>>(),
                        child: Column(
                          children: [
                            UploadImage(
                              isEnable: true,
                              onImageSelected: (image) {
                                setState(() {
                                  aadharFront = image;
                                  errorMsg = '';
                                });
                                Navigator.pop(context);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: appSize(
                                                context: context, unit: 10) /
                                            20),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blueAccent.withOpacity(0.2),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Aadhar Front Side Photo',
                                          style: AppStyle.bodyMedium(context)
                                              .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: primary_color),
                                        ),
                                        Text(
                                          '*', // Asterisk indicating mandatory field
                                          style: AppStyle.errorStyle(context)
                                              .copyWith(fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  if (aadharFront?.path.isNotEmpty ?? false)
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5,
                                      width: MediaQuery.of(context).size.width,
                                      child: (aadharFront?.name
                                                      .contains(".png") ??
                                                  false) ||
                                              (aadharFront?.name
                                                      .contains(".jpg") ??
                                                  false) ||
                                              (aadharFront?.name
                                                      .contains(".jpeg") ??
                                                  false)
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                              child: Image.file(
                                                File(aadharFront?.path ?? ''),
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : const SizedBox(
                                              height: 100,
                                            ),
                                    ),
                                  if (errorMsg != null && errorMsg!.isNotEmpty)
                                    Text(errorMsg ?? '',
                                        style: AppStyle.errorStyle(context)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            UploadImage(
                              isEnable: true,
                              onImageSelected: (image) {
                                setState(() {
                                  aadharBack = image;
                                });
                                Navigator.pop(context);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: appSize(
                                                context: context, unit: 10) /
                                            20),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blueAccent.withOpacity(0.2),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Aadhar Back Side Photo',
                                        style: AppStyle.bodyMedium(context)
                                            .copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: primary_color),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  if (aadharBack?.path.isNotEmpty ?? false)
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5,
                                      width: MediaQuery.of(context).size.width,
                                      child: (aadharBack?.name
                                                      .contains(".png") ??
                                                  false) ||
                                              (aadharBack?.name
                                                      .contains(".jpg") ??
                                                  false) ||
                                              (aadharBack?.name
                                                      .contains(".jpeg") ??
                                                  false)
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                              child: Image.file(
                                                File(aadharBack?.path ?? ''),
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: UserDocumentsBuilder(
                                    onSuccess: () {
                                      Navigator.pop(context);
                                    },
                                    onSubmitPressed: () {
                                      if (FormErrorBuilder
                                          .validateFormAndShowErrors(context)) {
                                        if (aadharFront?.path.isNotEmpty ??
                                            false) {
                                          context
                                              .read<UserDocumentBloc>()
                                              .userDocuments(
                                                aadharBack: aadharBack,
                                                aadharFront: aadharFront,
                                              );
                                        } else {
                                          setState(() {
                                            errorMsg =
                                                "Aadhar Front Side Photo is empty";
                                          });
                                        }
                                      }
                                    },
                                    onError: (error) {
                                      setState(() {
                                        errorMsg = error;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: (widget.isHomePassword ?? false)
                                      ? 0
                                      : 20.w,
                                ),
                                if (!(widget.isHomePassword ?? false))
                                  Expanded(
                                    // Expanded width when button is shown
                                    child: DotsProgressButton(
                                      isRectangularBorder: true,
                                      text: 'Cancel',
                                      buttonBackgroundColor: Colors.grey,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                              ],
                            ),
                            if (context
                                    .read<UserDocumentBloc>()
                                    .state
                                    .getData()
                                    ?.success ==
                                false)
                              SizedBox(
                                height: 8.h,
                              ),
                            if (context
                                    .read<UserDocumentBloc>()
                                    .state
                                    .getData()
                                    ?.success ==
                                false)
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical:
                                        appSize(context: context, unit: 10) /
                                            20),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.2),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Center(
                                  child: Text(errorMsg ?? '',
                                      style: AppStyle.errorStyle(context)),
                                ),
                              ),
                            SizedBox(
                              height: 8.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
