import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'string_extensions.dart';

extension NumberExtensions on num {
  // returns compact form of numeric value with currency symbol
  // Compact Form: 8000000 -> 8L

  String getGender() {
    if (this == 1) {
      return 'Male';
    } else if (this == 2) {
      return 'Female';
    } else if (this == 3) {
      return 'Other';
    } else if (this == 0) {
      return '';
    } else {
      return 'Unknown';
    }
  }

  String paymentMode() {
    if (this == 1) {
      return 'Razorpay';
    } else if (this == 2) {
      return 'Paytm';
    } else if (this == 3) {
      return 'Stripe';
    } else if (this == 0) {
      return 'Not Found';
    } else {
      return 'Unknown';
    }
  }

  String problemIn() {
    if (this == 1) {
      return 'Web';
    } else if (this == 2) {
      return 'Android';
    } else if (this == 3) {
      return 'Ios';
    } else if (this == 0) {
      return 'All';
    } else {
      return 'Unknown';
    }
  }

  String getReadableCurrencyValue() {
    return NumberFormat.currency(locale: 'en_IN', symbol: '')
        .format(this)
        .trim()
        .trimDecimalTrailingZeroes();
  }

  String getTransactionType() {
    if (this == 1) {
      return 'Debit';
    } else if (this == 2) {
      return 'Credit';
    } else if (this == 0) {
      return '';
    } else {
      return 'Unknown';
    }
  }

  String getVoterType() {
    if (this == 1) {
      return 'Voter';
    } else if (this == 2) {
      return 'Karyakarta';
    } else if (this == 3) {
      return 'User';
    } else if (this == 0) {
      return '';
    } else {
      return 'Unknown';
    }
  }
}

String compactCurrency(int num) {
  if (num == 0) return '';
  final NumberFormat compactFormat = NumberFormat.compact(
    locale: 'en_IN',
  );
  String compactNumber = compactFormat.format(num);
  return compactNumber;
}

double size(BuildContext context) {
  final size = (((MediaQuery.of(context).size.height) +
              (MediaQuery.of(context).size.width)) /
          100) *
      0.2;
  return size;
}
