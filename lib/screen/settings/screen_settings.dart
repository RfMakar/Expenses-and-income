import 'package:budget/screen/settings/provider_screen_settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderScreenSettings(),
      builder: (context, child) => Consumer<ProviderScreenSettings>(
        builder: (context, provider, _) {
          return ListView();
        },
      ),
    );
  }
}
