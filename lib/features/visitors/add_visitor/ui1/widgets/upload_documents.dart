import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/upload_image.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class UploadVisitorDocuments extends StatefulWidget {
  final XFile? passportPhoto;
  final XFile? passportPhoto2;
  final XFile? visaPhoto;
  final String? passportFront;
  final String? passportBack;
  final String? visaPhotoApi;
  final bool passportPhotoMsg;
  final bool visaPhotoMsg;
  final Function(XFile?, bool) onPassportPhotoChanged;
  final Function(XFile?, bool) onPassport2PhotoChanged;
  final Function(XFile?, bool) onVisaPhotoChanged;
  final bool? isEnable;

  const UploadVisitorDocuments({
    Key? key,
    required this.passportPhoto,
    required this.isEnable,
    required this.passportPhoto2,
    required this.visaPhoto,
    required this.passportPhotoMsg,
    required this.visaPhotoMsg,
    required this.onPassportPhotoChanged,
    required this.onPassport2PhotoChanged,
    required this.onVisaPhotoChanged,
    this.passportFront,
    this.passportBack,
    this.visaPhotoApi,
  }) : super(key: key);

  @override
  State<UploadVisitorDocuments> createState() => _UploadVisitorDocumentsState();
}

class _UploadVisitorDocumentsState extends State<UploadVisitorDocuments> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: UploadImage(
            isEnable: widget.isEnable,
            onImageSelected: (image) {
              widget.onPassportPhotoChanged(image, false);
              Navigator.pop(context);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.passportPhoto?.path.isNotEmpty ?? false)
                  SizedBox(
                    width: sizeHeight(context) / 8,
                    height: sizeHeight(context) / 8,
                    child: (widget.passportPhoto?.name.contains(".png") ??
                                false) ||
                            (widget.passportPhoto?.name.contains(".jpg") ??
                                false) ||
                            (widget.passportPhoto?.name.contains(".jpeg") ??
                                false)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(6.0),
                            child: Image.file(
                              File(
                                widget.passportPhoto?.path ?? '',
                              ),
                              fit: BoxFit.cover,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                if (widget.passportPhoto == null)
                  CachedNetworkImage(
                    fadeInDuration: const Duration(seconds: 0),
                    fadeOutDuration: const Duration(seconds: 0),
                    placeholderFadeInDuration: const Duration(seconds: 0),
                    width: appSize(context: context, unit: 10) / 2.5,
                    height: appSize(context: context, unit: 10) / 2.5,
                    fit: BoxFit.cover,
                    imageUrl:
                        '$googlePhotoUrl${getBucketName()}$visitorDocuments${widget.passportFront}',
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: background_dark_grey,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color: background_dark_grey,
                        ),
                        padding: EdgeInsets.all(
                            appSize(context: context, unit: 10) / 10),
                        width: appSize(context: context, unit: 10) / 8.5,
                        height: appSize(context: context, unit: 10) / 8.5,
                        child: const CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Container(
                      padding: const EdgeInsets.all(28.0),
                      width: sizeHeight(context) / 8,
                      height: sizeHeight(context) / 8,
                      decoration: BoxDecoration(
                        color: lightBlueColor,
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3),
                        ),
                      ),
                      child: Image.asset(
                        '$icons_path/gallery.png',
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    text: '',
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Passport\n First Page',
                        style: AppStyle.bodyMedium(context),
                      ),
                      TextSpan(
                          text: ' *',
                          style: AppStyle.bodyMedium(context)
                              .copyWith(color: Colors.red)),
                    ],
                  ),
                ),
                if (widget.passportPhotoMsg)
                  Text(
                    'Please upload Passport Photo',
                    style: AppStyle.errorStyle(context),
                  ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: UploadImage(
            isEnable: widget.isEnable,
            onImageSelected: (image) {
              widget.onPassport2PhotoChanged(image, false);
              Navigator.pop(context);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.passportPhoto2?.path.isNotEmpty ?? false)
                  SizedBox(
                    width: sizeHeight(context) / 8,
                    height: sizeHeight(context) / 8,
                    child: (widget.passportPhoto2?.name.contains(".png") ??
                                false) ||
                            (widget.passportPhoto2?.name.contains(".jpg") ??
                                false) ||
                            (widget.passportPhoto2?.name.contains(".jpeg") ??
                                false)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(6.0),
                            child: Image.file(
                              File(
                                widget.passportPhoto2?.path ?? '',
                              ),
                              fit: BoxFit.cover,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                if (widget.passportPhoto2 == null)
                  CachedNetworkImage(
                    fadeInDuration: const Duration(seconds: 0),
                    fadeOutDuration: const Duration(seconds: 0),
                    placeholderFadeInDuration: const Duration(seconds: 0),
                    width: appSize(context: context, unit: 10) / 2.5,
                    height: appSize(context: context, unit: 10) / 2.5,
                    fit: BoxFit.cover,
                    imageUrl:
                        '$googlePhotoUrl${getBucketName()}$visitorDocuments${widget.passportBack}',
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: background_dark_grey,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color: background_dark_grey,
                        ),
                        padding: EdgeInsets.all(
                            appSize(context: context, unit: 10) / 10),
                        width: appSize(context: context, unit: 10) / 8.5,
                        height: appSize(context: context, unit: 10) / 8.5,
                        child: const CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Container(
                      padding: const EdgeInsets.all(28.0),
                      width: sizeHeight(context) / 8,
                      height: sizeHeight(context) / 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: lightBlueColor,
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3),
                        ),
                      ),
                      child: Image.asset(
                        '$icons_path/gallery.png',
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Passport\n Last Page',
                  textAlign: TextAlign.center,
                  style: AppStyle.bodyMedium(context),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: UploadImage(
            isEnable: widget.isEnable,
            onImageSelected: (image) {
              widget.onVisaPhotoChanged(image, false);
              Navigator.pop(context);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.visaPhoto?.path.isNotEmpty ?? false)
                  SizedBox(
                    width: sizeHeight(context) / 8,
                    height: sizeHeight(context) / 8,
                    child: (widget.visaPhoto?.name.contains(".png") ?? false) ||
                            (widget.visaPhoto?.name.contains(".jpg") ??
                                false) ||
                            (widget.visaPhoto?.name.contains(".jpeg") ?? false)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(6.0),
                            child: Image.file(
                              File(
                                widget.visaPhoto?.path ?? '',
                              ),
                              fit: BoxFit.cover,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                if (widget.visaPhoto == null)
                  CachedNetworkImage(
                    fadeInDuration: const Duration(seconds: 0),
                    fadeOutDuration: const Duration(seconds: 0),
                    placeholderFadeInDuration: const Duration(seconds: 0),
                    width: appSize(context: context, unit: 10) / 2.5,
                    height: appSize(context: context, unit: 10) / 2.5,
                    fit: BoxFit.cover,
                    imageUrl:
                        '$googlePhotoUrl${getBucketName()}$visitorDocuments${widget.visaPhotoApi}',
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: background_dark_grey,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color: background_dark_grey,
                        ),
                        padding: EdgeInsets.all(
                            appSize(context: context, unit: 10) / 10),
                        width: appSize(context: context, unit: 10) / 8.5,
                        height: appSize(context: context, unit: 10) / 8.5,
                        child: const CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Container(
                      padding: const EdgeInsets.all(28.0),
                      width: sizeHeight(context) / 8,
                      height: sizeHeight(context) / 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: lightBlueColor,
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3),
                        ),
                      ),
                      child: Image.asset(
                        '$icons_path/gallery.png',
                        color: Colors.black.withOpacity(0.7),
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
                      'Visa',
                      style: AppStyle.bodyMedium(context),
                    ),
                    Text(
                      ' *',
                      style: AppStyle.bodyMedium(context)
                          .copyWith(color: Colors.red),
                    ),
                  ],
                ),
                if (widget.visaPhotoMsg)
                  Text(
                    'Please upload Visa Photo',
                    style: AppStyle.errorStyle(context),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
