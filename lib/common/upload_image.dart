import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  final Function(XFile)? onImageSelected;
  final Widget? child;
  final bool? isEnable;

  const UploadImage({
    super.key,
    this.child,
    this.onImageSelected,
    this.isEnable,
  });

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  late XFile? profilePhoto;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: widget.child,
      onTap: () async {
        if (widget.isEnable ?? false) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            enableDrag: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    UploadImageBottomSheet(selectedImage: (photo) {
                      profilePhoto = photo;
                      widget.onImageSelected?.call(photo);
                    }),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 20.0,
                            right: 20,
                            top: appSize(context: context, unit: 10) / 20,
                            bottom: appSize(context: context, unit: 10) / 8),
                        child: DotsProgressButton(
                          text: "Cancel",
                          isRectangularBorder: true,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}

class UploadImageBottomSheet extends StatefulWidget {
  final Function(XFile)? selectedImage;

  const UploadImageBottomSheet({
    super.key,
    this.selectedImage,
  });

  @override
  State<UploadImageBottomSheet> createState() => _UploadImageBottomSheetState();
}

class _UploadImageBottomSheetState extends State<UploadImageBottomSheet> {
  late XFile profilePhoto = XFile('');
  final ImagePicker _picker = ImagePicker();

  Future<void> _onSelectFileButtonPressed(
    ImageSource source, {
    BuildContext? context,
  }) async {
    if (source == ImageSource.camera) {
      try {
        final XFile? pickedFile =
            await _picker.pickImage(source: source, imageQuality: 50);
        setState(
          () {
            if (pickedFile != null) {
              profilePhoto = pickedFile;
              widget.selectedImage?.call(profilePhoto);
            }
          },
        );
      } catch (_) {}
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg'],
      );
      if (result != null) {
        final List<XFile> pickedFile =
            result.paths.map((path) => XFile(path!)).toList();
        setState(
          () {
            profilePhoto = pickedFile[0];
            widget.selectedImage?.call(profilePhoto);
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: appSize(context: context, unit: 10) / 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "$icons_path/camera.png",
                    height: sizeHeight(context) / 20,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Camera',
                    style: AppStyle.bodySmall(context).copyWith(
                      color: profileTextColor,
                    ),
                  ),
                ],
              ),
              onTap: () {
                _onSelectFileButtonPressed(
                  ImageSource.camera,
                  context: context,
                );
              },
            ),
            // const VerticalDivider(
            //   thickness: 2,
            // ),
            // InkWell(
            //   child: SizedBox(
            //     width: 130,
            //     height: 70,
            //     child: Column(
            //       children: [
            //         const Icon(
            //           Icons.photo_rounded,
            //           size: 50,
            //           color: Colors.blue,
            //         ),
            //         // Text(
            //         //   'Gallery',
            //         //   style: text_style_title11.copyWith(
            //         //     color: Colors.blue,
            //         //     fontWeight: FontWeight.w400,
            //         //   ),
            //         // ),
            //       ],
            //     ),
            //   ),
            //   onTap: () {
            //     _onSelectFileButtonPressed(
            //       ImageSource.gallery,
            //       context: context,
            //     );
            //   },
            // ),InkWell(
            //   child: SizedBox(
            //     width: 130,
            //     height: 70,
            //     child: Column(
            //       children: [
            //         const Icon(
            //           Icons.photo_rounded,
            //           size: 50,
            //           color: Colors.blue,
            //         ),
            //         // Text(
            //         //   'Gallery',
            //         //   style: text_style_title11.copyWith(
            //         //     color: Colors.blue,
            //         //     fontWeight: FontWeight.w400,
            //         //   ),
            //         // ),
            //       ],
            //     ),
            //   ),
            //   onTap: () {
            //     _onSelectFileButtonPressed(
            //       ImageSource.gallery,
            //       context: context,
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

class CancelBottomSheet1 extends StatelessWidget {
  const CancelBottomSheet1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: Platform.isIOS ? 20 : 10, left: 15, right: 15),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                'Cancel',
                style: text_style_title7.copyWith(
                  color: buttonColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UploadMultiImage extends StatefulWidget {
  final Function(List<XFile>)? onImagesSelected;
  final Widget? child;
  final bool? isEnable;
  final bool? showGallery;

  const UploadMultiImage({
    super.key,
    this.child,
    this.onImagesSelected,
    this.isEnable,
    this.showGallery,
  });

  @override
  State<UploadMultiImage> createState() => _UploadMultiImageState();
}

class _UploadMultiImageState extends State<UploadMultiImage> {
  List<XFile>? profilePhotos;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: widget.child,
      onTap: () async {
        if (widget.isEnable ?? false) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            enableDrag: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Wrap(
                  children: [
                    UploadMultiImageBottomSheet(
                      selectedImages: (photo) {
                        profilePhotos?.addAll(photo);
                        widget.onImagesSelected?.call(photo);
                      },
                      showGallery: widget.showGallery,
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    const CancelBottomSheet1()
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}

class UploadMultiImageBottomSheet extends StatefulWidget {
  final Function(List<XFile>)? selectedImages;
  final bool? showGallery;

  const UploadMultiImageBottomSheet({
    super.key,
    this.selectedImages,
    this.showGallery,
  });

  @override
  State<UploadMultiImageBottomSheet> createState() =>
      _UploadMultiImageBottomSheetState();
}

class _UploadMultiImageBottomSheetState
    extends State<UploadMultiImageBottomSheet> {
  late List<XFile> profilePhoto = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _onSelectFileButtonPressed(
    ImageSource source, {
    required BuildContext context,
  }) async {
    if (source == ImageSource.camera) {
      try {
        final List<XFile> pickedFiles = await _picker.pickMultiImage(
          imageQuality: 50,
        );
        setState(
          () {
            if (pickedFiles.isNotEmpty) {
              profilePhoto = pickedFiles;
              widget.selectedImages?.call(profilePhoto);
            }
          },
        );
      } catch (_) {}
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowCompression: true,
        allowedExtensions: ['jpg', 'png', 'jpeg'],
      );
      if (result != null) {
        final List<XFile> pickedFile =
            result.paths.map((path) => XFile(path!)).toList();

        setState(
          () {
            profilePhoto = pickedFile;
            widget.selectedImages?.call(profilePhoto);
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              child: SizedBox(
                height: 70,
                width: 130,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.photo_camera_rounded,
                      size: 40,
                      color: buttonColor,
                    ),
                    Text(
                      'Camera',
                      style: text_style_title11.copyWith(
                        color: buttonColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                _onSelectFileButtonPressed(
                  ImageSource.camera,
                  context: context,
                );
              },
            ),
            const VerticalDivider(
              thickness: 2,
            ),
            if (widget.showGallery ?? false)
              InkWell(
                child: SizedBox(
                  width: 130,
                  height: 70,
                  child: Column(
                    children: [
                      const Icon(
                        Icons.photo_rounded,
                        size: 40,
                        color: buttonColor,
                      ),
                      Text(
                        'Gallery',
                        style: text_style_title11.copyWith(
                          color: buttonColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  _onSelectFileButtonPressed(
                    ImageSource.gallery,
                    context: context,
                  );
                },
              ),
            // InkWell(
            //   child: SizedBox(
            //     width: 130,
            //     height: 70,
            //     child: Column(
            //       children: [
            //         const Icon(
            //           Icons.photo_rounded,
            //           size: 50,
            //           color: Colors.blue,
            //         ),
            //         Text(
            //           'Gallery',
            //           style: text_style_title11.copyWith(
            //             color: Colors.blue,
            //             fontWeight: FontWeight.w400,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            //   onTap: () {
            //     _onSelectFileButtonPressed(
            //       ImageSource.gallery,
            //       context: context,
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
