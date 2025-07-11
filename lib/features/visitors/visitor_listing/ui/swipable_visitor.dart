import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/check_out_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/outgoing_call_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/network/responses/visitor_details_response.dart';

import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/list_item_visitor.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/check_out_model.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/visitor.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/swiperPluginCode/lib/src/swiper.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/visitor_details.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/visitors_item_list.dart';
import 'package:provider/provider.dart';

class SwiperBuilder extends StatefulWidget {
  final bool? isFromCurrentVisitors;
  // final List<VisitorDetailsResponse>? visitors;
  final Room? room;
  // final String? roomNo;
  final FiltersModel? filtersModel;
  final String? businessType;
  const SwiperBuilder({
    Key? key,
    // this.visitors,
    // this.roomNo,
    this.room,
    this.filtersModel,
    this.isFromCurrentVisitors,
    this.businessType,
  }) : super(key: key);

  @override
  State<SwiperBuilder> createState() => _SwiperBuilderState();
}

class _SwiperBuilderState extends State<SwiperBuilder> {
  @override
  Widget build(BuildContext context) {
    return Swiper(
      curve: Curves.ease,
      axisDirection: AxisDirection.right,
      itemWidth: appSize(context: context, unit: 18),
      itemHeight: appSize(context: context, unit: 10),
      loop: (widget.room?.visitors?.length ?? 0) > 1,
      scrollDirection: Axis.horizontal,
      itemCount: widget.room?.visitors?.length ?? 0,
      layout: SwiperLayout.STACK,
      itemBuilder: (context, index) {
        final visitorResponse = widget.room?.visitors?[index];
        final visitor = convertVisitorDetailsResponseToVisitor(visitorResponse);
        return GestureDetector(
          onTap: () {
            log(visitorResponse.toString());
            if ((widget.room?.visitors?.length ?? 0) != 1) {
              Navigator.push(
                context,
                goToRoute(
                  MultiProvider(
                    providers: [
                      BlocProvider.value(
                        value: context.read<CheckOutBloc>(),
                      ),
                      ChangeNotifierProvider.value(
                        value: context.read<CheckOutVisitor>(),
                      ),
                      Provider(
                        create: (_) => GlobalKey<FormBuilderState>(),
                      ),
                    ],
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          goToRoute(
                            VisitorDetails(
                              businessType: widget.businessType,
                              isFromCurrentVisitors:
                                  widget.isFromCurrentVisitors,
                              visitor: visitor,
                            ),
                          ),
                        );
                      },
                      child: MultiProvider(
                        providers: [
                          BlocProvider.value(
                              value: context.read<OutgoingCallBloc>()),
                        ],
                        child: VisitorsItemList(
                          businessType: widget.businessType,
                          visitorsLength: widget.room?.visitors?.length,
                          isFromCurrentVisitors: widget.isFromCurrentVisitors,
                          showCheckoutButton: true,
                          room: widget.room,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              Navigator.push(
                context,
                goToRoute(
                  VisitorDetails(
                    businessType: widget.businessType,
                    visitor: visitor,
                    isFromCurrentVisitors: widget.isFromCurrentVisitors,
                  ),
                ),
              );
            }
          },
          child: MultiProvider(
            providers: [
              BlocProvider.value(value: context.read<OutgoingCallBloc>()),
              ChangeNotifierProvider.value(
                value: context.read<CheckOutVisitor>(),
              ),
            ],
            child: ListItemVisitor(
              businessType: widget.businessType,
              isFromCurrentVisitors: widget.isFromCurrentVisitors,
              isFromMainList: true,
              showCheckoutButton: true,
              visitorLength: widget.room?.visitors?.length,
              visitor: visitor,
            ),
          ),
        );
      },
    );
  }
}

Visitor? convertVisitorDetailsResponseToVisitor(
    VisitorDetailsResponse? response) {
  if (response == null) return null;
  return Visitor(
      id: response.id,
      state: response.state,
      city: response.city,
      pincode: response.pincode,
      area: response.area,
      roomNo: response.roomNo,
      fullName: response.fullName,
      firstName: response.firstName,
      lastName: response.lastName,
      middleName: response.middleName,
      visitorFk: response.visitorFk,
      fkTitle: response.fkTitle,
      title: response.title,
      bloodGrp: response.bloodGrp,
      bloodGrpFk: response.bloodGrpFk,
      criminalRecord: response.criminalRocord,
      clientName: response.clientName,
      age: response.age,
      gender: response.gender,
      mobileNo: response.mobileNo,
      email: response.email,
      visitorType: response.visitorType,
      country: response.country,
      image: response.image,
      mobileCountyCode: response.mobileCountyCode,
      registrationDate: response.registrationDate,
      expiryDate: response.expiryDate,
      aadharNo: response.aadharNo,
      visitingReason: response.visitingReason,
      visaNumber: response.visaNumber,
      visitorExitDate: response.visitorExitDate,
      passportNo: response.passportNo,
      qrImage: response.qrImage,
      aadharImage: response.aadharImage,
      address: response.address,
      entryDate: response.entryDate,
      lastUpdatedBy: response.lastUpdatedBy,
      updatedAt: response.updatedAt,
      visitingReasonFk: response.visitingReasonFk,
      visitingTill: response.visitingTill,
      reasonValue: response.reasonValue,
      profileImage: response.profileImage,
      aadharVerifiedStatus: response.aadharVerifiedStatus,
      passportVerifiedStatus: response.passportVerifiedStatus,
      shortName: response.shortName,
      visaPhoto: response.visaPhoto,
      passportBackPhoto: response.passportBackPhoto,
      birthDate: response.birthDate,
      visaExpiryDate: response.visaExpiryDate,
      passportFrontPhoto: response.passportFrontPhoto);
}
