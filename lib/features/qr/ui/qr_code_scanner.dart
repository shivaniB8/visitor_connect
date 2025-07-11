// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/button.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/common/error_slate.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/qr/bloc/face_match_bloc.dart';
import 'package:host_visitor_connect/features/qr/bloc/qr_scanner_bloc.dart';
import 'package:host_visitor_connect/features/qr/ui/qr_provider.dart';
import 'package:host_visitor_connect/features/qr/ui/qr_reported_visitor.dart';
import 'package:host_visitor_connect/features/qr/ui/qr_scannerd_visitor.dart';
import 'package:host_visitor_connect/features/rentals/ui/driving_licence_form.dart';
import 'package:host_visitor_connect/features/rentals/ui/driving_licence_provider.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/blood_grp_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/visitor_document_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/aadhar_photo_screen.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/outgoing_call_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan/scan.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({Key? key, required this.businessType}) : super(key: key);
  final int businessType;

  @override
  State<StatefulWidget> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  Barcode? result;
  final picker = ImagePicker();
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String unknownPlatformVersion = 'Unknown';
  bool? canShowQRScanner;

  @override
  void initState() {
    super.initState();
    // getCameraPermission();
    initPlatformState();
    // getCameraPermission();
  }

  void getCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      final result = await Permission.camera.request();
      if (result.isGranted) {
        setState(() {
          canShowQRScanner = true;
        });
      } else {
        await Permission.camera.request();
      }
    } else {
      setState(() {
        canShowQRScanner = true;
      });
    }
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await Scan.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      unknownPlatformVersion = platformVersion;
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    // if (Platform.isAndroid) {
    controller?.pauseCamera();
    // }
    // controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomImageAppBar(
        showSettings: false,
        showEditIcon: false,
        title: 'Scan QR',
        context: context,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: _buildQrView(context),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await controller?.toggleFlash();
                          setState(() {});
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: primary_color,
                          ),
                          child: FutureBuilder(
                            future: controller?.getFlashStatus(),
                            builder: (context, snapshot) {
                              return snapshot.data ?? false
                                  ? const Icon(
                                      Icons.flash_on,
                                      size: 30,
                                      color: Colors.white,
                                    )
                                  : const Icon(
                                      Icons.flash_off,
                                      size: 30,
                                      color: Colors.white,
                                    );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await controller?.flipCamera();
                          setState(() {});
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: primary_color,
                          ),
                          child: FutureBuilder(
                            future: controller?.getCameraInfo(),
                            builder: (context, snapshot) {
                              if (snapshot.data != null) {
                                return snapshot.data == CameraFacing.front
                                    ? const Icon(
                                        Icons.cameraswitch,
                                        size: 30,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        Icons.cameraswitch_outlined,
                                        size: 30,
                                        color: Colors.white,
                                      );
                              } else {
                                return const Text('loading');
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: sizeHeight(context) / 17,
                    width: MediaQuery.of(context).size.width - 80,
                    child: Button(
                      text: 'Capture',
                      isRectangularBorder: true,
                      onPressed: () async {
                        setState(() {
                          controller?.resumeCamera();
                        });
                        // final image = await picker.pickImage(source: ImageSource.gallery);
                        // qrScanFunction(code: image?.path, capture: true);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? appSize(context: context, unit: 5)
        : appSize(context: context, unit: 8);
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        overlayColor: Colors.black.withOpacity(0.9),
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        // cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen(
      (scanData) async {
        controller.pauseCamera();
        result = scanData;
        qrScanFunction(code: result?.code, capture: false);
      },
    );
  }

  Future<void> qrScanFunction({String? code, bool? capture}) async {
    if (code?.isNotEmpty ?? false) {
      showLoader(context); // Show loader before starting processing

      final String? decodedQr =
          capture == true ? await Scan.parse(code ?? '') : code;

      if ((decodedQr?.isNotEmpty ?? false) || decodedQr != null) {
        int? id = int.tryParse(decodedQr?.split('-').first ?? '0-1');
        String? aadhar = decodedQr?.split('-').last;
        controller?.pauseCamera();
        controller?.dispose();

        await context.read<QrScannerBloc>().getQrScannerData(
              visitorId: id ?? 0,
              aadhar: aadhar ?? '',
              businessType: widget.businessType,
            );
      }

      if (decodedQr != null &&
          (context.read<QrScannerBloc>().state.getData()?.status == 200)) {
        hideLoader(context); // Hide loader after processing is complete
        Navigator.of(context).pop();
        if (context
                    .read<QrScannerBloc>()
                    .state
                    .getData()
                    ?.sendDrivingLicenseStatus ==
                1 &&
            widget.businessType == 2) {
          print("visitor Type");
          print(context.read<QrScannerBloc>().state.getData()?.data?.id);
          Navigator.push(
            context,
            goToRoute(
              DrivingLicenseProviders(
                child: BlocProvider.value(
                  value: context.read<QrScannerBloc>(),
                  child: DrivingLicenseForm(
                    id: context.read<QrScannerBloc>().state.getData()?.data?.id,
                    businessType: widget.businessType,
                    isFromQR: true,
                    visitor:
                        context.read<QrScannerBloc>().state.getData()?.data,
                  ),
                ),
              ),
            ),
          );
          if (context
                  .read<QrScannerBloc>()
                  .state
                  .getData()
                  ?.data
                  ?.visitorType ==
              2) {
            Navigator.pushReplacement(
                context,
                goToRoute(
                  MultiProvider(
                    providers: [
                      Provider<GlobalKey<FormBuilderState>>(
                        create: (_) => GlobalKey<FormBuilderState>(),
                      ),

                      BlocProvider(
                        create: (_) => VisitorDocumentBloc(),
                      ),
                      BlocProvider(
                        create: (_) => QrScannerBloc(),
                      ),
                      // Add other providers if needed
                    ],
                    child: AadharPhotoScreen(
                      businessType: widget.businessType,
                      isFromScan: true,
                      isForeigner: true,
                      visitor:
                          context.read<QrScannerBloc>().state.getData()?.data,
                      visitorId: context
                          .read<QrScannerBloc>()
                          .state
                          .getData()
                          ?.data
                          ?.id,
                    ), // Replace with the actual screen you want to navigate to
                  ),
                ));
          }
        } else if (context
                .read<QrScannerBloc>()
                .state
                .getData()
                ?.sendDrivingLicenseStatus ==
            0) {
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
                  BlocProvider(
                    create: (context) => FaceMatchBloc(),
                  ),
                ],
                child: QrScannedVisitor(
                  licenceData: context
                      .read<QrScannerBloc>()
                      .state
                      .getData()
                      ?.drivingLicenseData,
                  businessType: widget.businessType,
                  visitor: context.read<QrScannerBloc>().state.getData()?.data,
                ),
              ),
            ),
          );
        }
      } else if ((context.read<QrScannerBloc>().state.getData()?.status ==
          404)) {
        hideLoader(context); // Hide loader if processing is complete
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
        hideLoader(context); // Hide loader if processing is complete
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
      } else if (context.read<QrScannerBloc>().state.getData()?.status == 208) {
        hideLoader(context); // Hide loader if processing is complete
        Navigator.push(
          context,
          goToRoute(
            QrScannerProvider(
              child: QrReportedVisitor(
                businessType: widget.businessType,
                visitor: context.read<QrScannerBloc>().state.getData()?.data,
              ),
            ),
          ),
        );
      } else {
        hideLoader(context); // Hide loader if processing is complete
        Navigator.push(
          context,
          goToRoute(
            const VoterListingErrorSlate(),
          ),
        );
      }
    }
  }

  void showLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: LoadingWidget(
            color: Colors.white,
          ),
        );
      },
    );
  }

  void hideLoader(BuildContext context) {
    Navigator.of(context).pop(); // Pop the dialog to hide the loader
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
