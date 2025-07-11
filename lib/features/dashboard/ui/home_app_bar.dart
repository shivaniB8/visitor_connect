import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/features/dashboard/bloc/user_details_bloc.dart';
import 'package:host_visitor_connect/features/profile/ui/profile_page.dart';
import 'package:host_visitor_connect/features/profile/ui/profile_provider.dart';

class HomePageAppBar extends StatelessWidget {
  final Function()? onTap;
  final advancedDrawerController;
  const HomePageAppBar({
    super.key,
    this.onTap,
    this.advancedDrawerController,
  });

  @override
  Widget build(BuildContext context) {
    final userDetails = context.read<UserDetailsBloc>().state.getData();

    print(
        '$googlePhotoUrl${getMasterBucketName()}$hostImage${userDetails?.hostLogo}');
    return Scaffold(
      // backgroundColor: primary_color,
      body: Builder(
        builder: (context) {
          return Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3.5,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF1E2B72),
                      Color(0xFF354392),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Image.asset(
                '$images_path/lines.png',
                height: MediaQuery.of(context).size.height * 0.4,
                fit: BoxFit.none,
              ),
              Positioned(
                left: 15,
                top: MediaQuery.of(context).size.height * 0.07,
                right: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: onTap,
                          child: CachedNetworkImage(
                            height: 50,
                            width: 50,
                            fit: BoxFit.none,
                            imageUrl:
                                '$googlePhotoUrl${getMasterBucketName()}$hostImage${userDetails?.hostLogo}',
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Container(
                              padding: const EdgeInsets.all(40),
                              child: const CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6.0),
                                image: DecorationImage(
                                  image: Image.asset(
                                          '$images_path/splash_logo.png')
                                      .image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          capitalizedString(
                              userDetails?.clientName ?? 'Not Available'),
                          style:
                              text_style_title5.copyWith(color: Colors.white),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              goToRoute(
                                const ProfileProvider(
                                  child: ProfilePage(),
                                ),
                              ),
                            );
                          },
                          child: CachedNetworkImage(
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            imageUrl:
                                '$googlePhotoUrl${getBucketName()}$userPhoto${userDetails?.userPhoto}',
                            imageBuilder: (context, imageProvider) => Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Container(
                              padding: const EdgeInsets.all(40),
                              child: const CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                image: DecorationImage(
                                  image: Image.asset('$icons_path/avatar.png')
                                      .image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    const Text(
                      'Welcome',
                      style: text_style_title3,
                    ),
                    Text(
                      capitalizedString(
                        userDetails?.fullName ?? 'Visitor',
                      ),
                      style: text_style_title3.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
