import 'package:flutter/material.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class FilesCacheManager {
  static const key = 'cacheFiles';
  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 30),
      maxNrOfCacheObjects: 400,
    ),
  );
}

String? getBucketName() {
  return SharedPrefs.getString(keyBucketName);
}

String? getMasterBucketName() {
  return SharedPrefs.getString(keyMasterBucket);
}

const apiAuthenticationToken = "API_AUTH_TOKEN";
const keyPhoneNo = "KEY_PHONE_NO";
const keyClientId = "CLIENT_ID";
const keyUserData = "USER_DATA";
const keyDummyPhone = "DUMMY_PHONE";
const keyBucketName = "BUCKET_NAME";
const keyUserId = "USER_ID";
const keyClientLogo = "CLIENT_LOGO";
const keyMasterBucket = "MASTER_BUCKET";
const keyHostFk = "HOST_FK";
const keyBranchList = "BRANCH_LIST";
const keyBranch = "KEY_BRANCH";
const keyOnboarding = "KEY_ONBOARDING";
