import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/location.dart';
import 'package:host_visitor_connect/features/users/users_listing/ui/users/user.dart';
import 'package:host_visitor_connect/common/custom_widget/widget/calling.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/virtual_numbers_bloc.dart';
import 'package:provider/provider.dart';

class UserDetailsBody extends StatefulWidget {
  final User? user;

  const UserDetailsBody({
    super.key,
    this.user,
  });

  @override
  State<UserDetailsBody> createState() => _UserDetailsBodyState();
}

class _UserDetailsBodyState extends State<UserDetailsBody> {
  Position? currentPosition;
  @override
  void initState() {
    getCurrentLocation(location: (location) {
      currentPosition = location;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if ((widget.user?.image.isNullOrEmpty() ?? false))
              SizedBox(
                width: MediaQuery.of(context).size.width / 6,
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: Image.asset('$icons_path/avatar.png').image,
                ),
              ),
            if (!(widget.user?.image.isNullOrEmpty() ?? false))
              CachedNetworkImage(
                imageUrl:
                    '$googlePhotoUrl${getBucketName()}$userPhoto${widget.user?.image}',
                imageBuilder: (context, imageProvider) {
                  return Container(
                    width: 90,
                    height: 90.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                placeholder: (context, url) => SizedBox(
                  width: MediaQuery.of(context).size.width / 6,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => SizedBox(
                  width: MediaQuery.of(context).size.width / 6,
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage:
                        Image.asset('$icons_path/avatar.png').image,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Name',
          style: text_style_para1,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          capitalizedString(
            widget.user?.fullName ?? 'Not Available',
          ),
          style: text_style_title11,
        ),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Mobile No',
          style: text_style_para1,
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Text(
              !(widget.user?.mobileNo.isNullOrEmpty() ?? false)
                  ? widget.user?.mobileNo?.replaceRange(2, 8, "******") ??
                      'Not Available'
                  : 'Not Available',
              style: text_style_title11.copyWith(color: text_color),
            ),
            const Spacer(),
            CallingWidget(
                visitorId: widget.user?.id ?? 0,
                settingId: context
                        .read<VirtualNumbersBloc>()
                        .state
                        .getData()
                        ?.records
                        ?.first
                        .settingId ??
                    0)
          ],
        ),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Email',
          style: text_style_para1,
        ),
        const SizedBox(
          height: 5,
        ),
        if (!(widget.user?.email?.isNullOrEmpty() ?? false))
          Text(
            widget.user?.email?.replaceRange(
                    1, widget.user?.email?.indexOf('@'), "*****") ??
                'Not Available',
            style: text_style_title11.copyWith(color: text_color),
          ),
        if (widget.user?.email?.isEmpty ?? false)
          Text(
            'Not Available',
            style: text_style_title11.copyWith(
              color: text_color,
            ),
          ),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'User is From',
          style: text_style_para1,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          capitalizedString(
            widget.user?.address ?? 'Not Available'.trimRight(),
          ),
          style: text_style_title11.copyWith(color: text_color),
        ),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Date Of Birth',
          style: text_style_para1,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          widget.user?.dateOfBirth ?? 'Not Available',
          style: text_style_title11.copyWith(color: text_color),
        ),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Role',
          style: text_style_para1,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          widget.user?.role ?? 'Not Available',
          style: text_style_title11.copyWith(color: text_color),
        ),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Designation',
          style: text_style_para1,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          widget.user?.designation ?? 'Not Available',
          style: text_style_title11.copyWith(color: text_color),
        ),
        const Divider(),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Last Update date : ${timeStampToDateTime(widget.user?.updatedAt)}',
          style: text_style_para1,
        ),
        const Divider(),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Last Updated by : ${capitalizedString(widget.user?.lastUpdatedBy ?? 'Not Available')}',
          style: text_style_para1,
        ),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
