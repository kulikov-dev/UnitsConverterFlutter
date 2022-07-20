import 'package:flutter/material.dart';
import 'package:unit/utils/app_localization.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

/// Class helper for sending feedback email
class MailToHelper {
  /// Fill message and call for default email sending app
  static void sendMessage(BuildContext context) async {
    final String url = Mailto(
      to: <String>[
        'one.friend.dev@gmail.com',
      ],
      subject: AppLocalizations.of(context).translate('MailSubject'),
      body: AppLocalizations.of(context).translate('MailBody'),
    ).toString();

    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
