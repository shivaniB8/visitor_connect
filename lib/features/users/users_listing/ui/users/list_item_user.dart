import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/features/users/users_listing/ui/users/user.dart';
import 'package:host_visitor_connect/common/custom_widget/widget/calling.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/virtual_numbers_bloc.dart';
import 'package:provider/provider.dart';

class ListItemUser extends StatelessWidget {
  final User? user;

  const ListItemUser({
    super.key,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: Container(
        margin: const EdgeInsets.only(bottom: 0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if ((user?.image.isNullOrEmpty() ?? false))
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 6,
                      child: CircleAvatar(
                        radius: 35,
                        backgroundImage:
                            Image.asset('$icons_path/avatar.png').image,
                      ),
                    ),
                  if (!(user?.image.isNullOrEmpty() ?? false))
                    CachedNetworkImage(
                      imageUrl:
                          '$googlePhotoUrl${getBucketName()}$userPhoto${user?.image}',
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          width: MediaQuery.of(context).size.width / 6,
                          height: 70.0,
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
                width: 15,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            capitalizedString(
                              user?.fullName ?? 'Not Available',
                            ),
                            style: text_style_title13,
                          ),
                        ),
                        CallingWidget(
                            visitorId: user?.id ?? 0,
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
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(text: 'Role', style: text_style_para2),
                          const TextSpan(text: ': ', style: text_style_para2),
                          TextSpan(
                            text: user?.role,
                            style: text_style_title13,
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(text: 'DOB', style: text_style_para2),
                          const TextSpan(text: ': ', style: text_style_para2),
                          TextSpan(
                            text: user?.dateOfBirth,
                            style: text_style_title13,
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              text: 'Designation', style: text_style_para2),
                          const TextSpan(text: ': ', style: text_style_para2),
                          TextSpan(
                            text: user?.designation,
                            style: text_style_title13,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
