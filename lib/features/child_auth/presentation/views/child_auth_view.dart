import 'package:codekids/features/child_auth/presentation/views/widgets/child_auth_body.dart';
import 'package:flutter/material.dart';

class ChildAuthView extends StatelessWidget {
  const ChildAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ChildAuthViewBody(),
    );
  }
}
