import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:host_visitor_connect/features/profile/bloc/update_profile_bloc.dart';
import 'package:host_visitor_connect/features/profile/ui/model/update_profile.dart';
import 'package:provider/provider.dart';

class EditProfileProvider extends StatelessWidget {
  final Widget child;
  final Function(BuildContext)? init;
  final GlobalKey<FormBuilderState>? formKey;
  final UpdateProfile? updateProfile;
  final UpdateProfileBloc? updateProfileBloc;

  const EditProfileProvider({
    Key? key,
    required this.child,
    this.init,
    this.formKey,
    this.updateProfile,
    this.updateProfileBloc,
  }) : super(key: key);

  GlobalKey<FormBuilderState> _getFormKey(BuildContext context) {
    return formKey ?? GlobalKey<FormBuilderState>();
  }


  UpdateProfile _getUpdateProfile(BuildContext context) {
    return updateProfile ?? UpdateProfile();
  }

  UpdateProfileBloc _getUpdateProfileBloc(BuildContext context) {
    return updateProfileBloc ?? UpdateProfileBloc();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GlobalKey<FormBuilderState>>(create: _getFormKey),
        Provider(create: _getUpdateProfile),
        BlocProvider(create: _getUpdateProfileBloc),
      ],
      child: Initializer(
        init: init,
        child: child,
      ),
    );
  }
}
