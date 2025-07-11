import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/app_confirmation_screen.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/add_form_field.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_error.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_field_label.dart';
import 'package:host_visitor_connect/common/custom_widget/form_dropdown_widget.dart';

import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';

import 'package:host_visitor_connect/common/res/paths.dart';

import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/upload_image.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';

import 'package:host_visitor_connect/features/report/report_list/bloc/report_reasons_bloc.dart';
import 'package:host_visitor_connect/features/report/report_list/bloc/report_visitor_bloc.dart';
import 'package:host_visitor_connect/features/report/report_list/ui/report_visitor_builder.dart';

import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/visitor.dart';
import 'package:image_picker/image_picker.dart';

import 'model/report_visitor.dart';

class ReportVisitorScreen extends StatefulWidget {
  final Visitor? visitor;

  const ReportVisitorScreen({
    super.key,
    this.visitor,
  });

  @override
  State<ReportVisitorScreen> createState() => _ReportVisitorScreenState();
}

class _ReportVisitorScreenState extends State<ReportVisitorScreen> {
  KeyValueResponse? selectedReportReason;
  bool? reasonIsNull = false;
  XFile? reportPhoto;

  @override
  void initState() {
    context.read<ReportReasonsBloc>().getReasonsList();

    context.read<ReportVisitor>().visitorId = widget.visitor?.visitorFk;
    super.initState();
  }

  bool dropdownValidationLogic() {
    if (context.read<ReportVisitor>().reason == null ||
        context.read<ReportVisitor>().reason == '') {
      reasonIsNull = true;
    } else {
      reasonIsNull = false;
    }

    setState(() {});
    if (reasonIsNull ?? false) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomImageAppBar(
        title: 'Report Visitor',
        context: context,
        showEditIcon: false,
        showSettings: false,
      ),
      body: IgnorePointer(
        ignoring: false,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 25.0,
            left: 20,
            right: 20,
            bottom: 15,
          ),
          child: FormBuilder(
            key: context.read<GlobalKey<FormBuilderState>>(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FormFieldLabel(
                    label: 'Reason to Report',
                    isRequired: true,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ReportReasonBuilder(
                    reasons: context
                        .watch<ReportReasonsBloc>()
                        .state
                        .getData()
                        ?.data,
                    reasonIsNull: reasonIsNull ?? false,
                    isSelectedReasonOther: () {
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const FormFieldLabel(
                    label: 'Mention in brief',
                    isRequired: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AddFormField(
                    padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                    // controller: detailsController,
                    isEnable:
                        context.read<ReportVisitorBloc>().state is Progress
                            ? false
                            : true,
                    maxLines: 4,
                    minLines: 3,
                    hintText: 'Type the reason for report',
                    validator: (value) {
                      if (value.isNullOrEmpty()) {
                        return 'Please enter Reason';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      context.read<ReportVisitor>().briefReason = value;
                    },
                  ),
                  // AddFormField(
                  //   // padding:
                  //   //     const EdgeInsets.only(top: 100, left: 10, right: 10),
                  //   isEnable:
                  //       context.read<ReportVisitorBloc>().state is Progress
                  //           ? false
                  //           : true,
                  //   // maxLines: 4,
                  //   // minLines: 3,
                  //   // Added this line to center align the text
                  //   hintText: 'Type the reason for report',
                  //   validator: (value) {
                  //     if (value.isNullOrEmpty()) {
                  //       return 'Please enter Reason';
                  //     } else {
                  //       return null;
                  //     }
                  //   },
                  //   onChanged: (value) {
                  //     context.read<ReportVisitor>().briefReason = value;
                  //   },
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: UploadImage(
                      isEnable:
                          context.watch<ReportReasonsBloc>().state is Progress
                              ? false
                              : true,
                      onImageSelected: (image) {
                        setState(() {
                          reportPhoto = image;
                        });
                        Navigator.pop(context);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (reportPhoto?.path.isNotEmpty ?? false)
                            SizedBox(
                              height: 230.h,
                              width: double.infinity,
                              child: (reportPhoto?.name.contains(".png") ??
                                          false) ||
                                      (reportPhoto?.name.contains(".jpg") ??
                                          false) ||
                                      (reportPhoto?.name.contains(".jpeg") ??
                                          false)
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(6.0),
                                      child: Image.file(
                                        File(reportPhoto?.path ?? ''),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          if (reportPhoto == null)
                            CachedNetworkImage(
                              width: double.infinity,
                              height: 230.0.h,
                              fit: BoxFit.cover,
                              imageUrl: '',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: double.infinity,
                                height: 230.0.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.0),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                width: double.infinity,
                                height: 230.0.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.0),
                                  color: Colors.grey[350],
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 50.0.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Upload Violation Photo',
                                style: AppStyle.titleSmall(context)
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Image.asset(
                                '$icons_path/upload.png',
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ReportVisitorBuilder(
                      onReportVisitorPressed: () {
                        dropdownValidationLogic();
                        if (FormErrorBuilder.validateFormAndShowErrors(
                            context)) {
                          if (!dropdownValidationLogic()) {
                            context.read<ReportVisitorBloc>().reportVisitor(
                                  reportPhoto: reportPhoto ?? XFile(''),
                                  reportVisitorMap:
                                      context.read<ReportVisitor>().toJson,
                                );
                          }
                        }
                      },
                      onSuccess: () {
                        Navigator.push(
                          context,
                          goToRoute(const ConfirmAppScreen(
                            isFromReportScreen: true,
                            img: '$icons_path/confirm.png',
                            title: 'Confirmation',
                            subtitle: "Visitor Reported successfully",
                          )),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReportReasonBuilder extends StatelessWidget {
  final Function()? onUpdateVoterPressed;
  final List<KeyValueResponse>? reasons;
  final Function()? onSuccess;
  final bool isUpdate;
  final bool reasonIsNull;
  final Function()? isSelectedReasonOther;

  const ReportReasonBuilder({
    super.key,
    this.onUpdateVoterPressed,
    this.onSuccess,
    this.isUpdate = false,
    required this.reasonIsNull,
    this.isSelectedReasonOther,
    this.reasons,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: context.watch<ReportVisitor>().reason is Progress,
      child: FormDropDownWidget(
        isNull: reasonIsNull,
        isRequired: true,
        removeValue: () {
          context.read<ReportVisitor>().reason = '';
          context.read<ReportVisitor>().reasonFk = 0;
        },
        errorMessage: "Please select Report Reason",
        dropdownFirstItemName: 'Select Report Reason',
        titles: reasons ?? [],
        title: '',
        onTap: (data) {
          if (!(data.label.isNullOrEmpty())) {
            context.read<ReportVisitor>().reason = data.label;
            context.read<ReportVisitor>().reasonFk = data.value;
            isSelectedReasonOther?.call();
          }
        },
        isItEnabled:
            context.watch<ReportReasonsBloc>().state is Progress ? false : true,
      ),
    );
  }
}
