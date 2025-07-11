import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/error_slate.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/features/qr/bloc/qr_scanner_bloc.dart';
import 'package:host_visitor_connect/features/qr/data/network/responses/qr_scanner_data_response.dart';
import 'package:host_visitor_connect/features/qr/ui/qr_scannerd_visitor.dart';
import 'package:host_visitor_connect/features/rentals/ui/driving_licence_form.dart';
import 'package:host_visitor_connect/features/rentals/ui/driving_licence_provider.dart';

import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/blood_grp_bloc.dart';

import 'package:host_visitor_connect/features/visitors/add_visitor/ui/aadhar_photo_provider.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/aadhar_photo_screen.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/outgoing_call_bloc.dart';
import 'package:provider/provider.dart';

class CallQRApiBuilder extends StatelessWidget {
  final Function()? onPressed;
  final int businessType;
  final QrScannerDataResponse? qrScannerDataResponse;

  const CallQRApiBuilder({
    Key? key,
    this.onPressed,
    // this.reportData,
    this.qrScannerDataResponse,
    required this.businessType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.read<QrScannerBloc>(),
      listener: (context, UiState state) {
        if (state is Success &&
            context.read<QrScannerBloc>().state.getData()?.status == 200) {
          if (context
                  .read<QrScannerBloc>()
                  .state
                  .getData()
                  ?.sendDrivingLicenseStatus ==
              1) {
            Navigator.push(
              context,
              goToRoute(
                DrivingLicenseProviders(
                  child: BlocProvider.value(
                    value: context.read<QrScannerBloc>(),
                    child: DrivingLicenseForm(
                      id: context
                          .read<QrScannerBloc>()
                          .state
                          .getData()
                          ?.data
                          ?.id,
                      businessType: businessType,
                      isFromQR: true,
                      visitor:
                          context.read<QrScannerBloc>().state.getData()?.data,
                    ),
                  ),
                ),
              ),
            );
            if (businessType == 2) {
              print("QrScannerBloc data");
              print(context.read<QrScannerBloc>().state.getData()?.data);
              Navigator.push(
                context,
                goToRoute(
                  AadharPhotoProvider(
                    child: AadharPhotoScreen(
                      businessType: 2,
                      isForeigner: true,
                      isFromScan: true,
                      visitor:
                          context.read<QrScannerBloc>().state.getData()?.data,
                      visitorId: context
                          .read<QrScannerBloc>()
                          .state
                          .getData()
                          ?.data
                          ?.id,
                    ),
                  ),
                ),
              );
            }
          } else {
            Navigator.push(
              context,
              goToRoute(
                MultiProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => OutgoingCallBloc(),
                    ),
                    BlocProvider(
                      create: (context) => BloodGrpBloc(),
                    ),
                  ],
                  child: QrScannedVisitor(
                    businessType: businessType,
                    visitor:
                        context.read<QrScannerBloc>().state.getData()?.data,
                  ),
                ),
              ),
            );
          }
        } else if ((context.read<QrScannerBloc>().state.getData()?.status ==
            404)) {
          Navigator.push(
            context,
            goToRoute(
              VoterListingErrorSlate(
                label: context.read<QrScannerBloc>().state.getData()?.message,
                subTitle:
                    'Visitors QR is expired, You will need to generate new QR',
              ),
            ),
          );
        } else if ((context.read<QrScannerBloc>().state.getData()?.status ==
            400)) {
          Navigator.push(
            context,
            goToRoute(
              VoterListingErrorSlate(
                takeToWallet: true,
                label: context.read<QrScannerBloc>().state.getData()?.message,
                subTitle: 'Please add funds in your account',
              ),
            ),
          );
        } else if (context.read<QrScannerBloc>().state.getData()?.status ==
            500) {
          Navigator.push(
            context,
            goToRoute(
              const VoterListingErrorSlate(),
            ),
          );
        }
        if (state is Error) {
          CommonErrorHandler(
            context,
            exception: state.exception,
          ).showToast();
        }
      },
      builder: (_, UiState state) {
        if (state is Progress) {
          return const DotsProgressButton(
            isRectangularBorder: true,
            text: 'Continue',
            isProgress: true,
          );
        }
        return DotsProgressButton(
          isRectangularBorder: true,
          text: 'Continue',
          isProgress: false,
          onPressed: onPressed,
        );
      },
    );
  }
}
