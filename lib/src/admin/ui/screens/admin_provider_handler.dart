import 'package:countmein/domain/entities/cmi_provider.dart';
import 'package:flutter/material.dart';

class AdminProviderHandlerScreen extends StatelessWidget {
  static const String routeName = '/adminProviderHandler';

  final CMIProvider provider;

  const AdminProviderHandlerScreen({Key? key, required this.provider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          InfoText(
            label: 'Nome Provider',
            value: provider.name,
          ),
          InfoText(
            label: 'Amministratore',
            value: provider.adminFullName,
          ),
          InfoText(
            label: 'Email Amministratore',
            value: provider.adminEmail,
          ),
          InfoText(
            label: 'Restrizione email',
            value: provider.domainRequirement ?? '-',
          ),
          ElevatedButton(
            onPressed: () {

            },
            child: Text('Accetta richiesta'),
          ),
        ],
      ),
    );
  }
}

class InfoText extends StatelessWidget {
  final String label;
  final String value;

  const InfoText({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
}
