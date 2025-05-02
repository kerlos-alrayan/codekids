import 'package:codekids/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_router.dart';
import '../manger/sign_up_steps_cubit/sign_up_steps_cubit.dart';

class SignUpSteps extends StatefulWidget {
  final int totalSteps;

  const SignUpSteps({super.key, required this.totalSteps});

  @override
  State<SignUpSteps> createState() => _SignUpStepsState();
}

class _SignUpStepsState extends State<SignUpSteps> {
  final _formKey = GlobalKey<FormState>();
  final Map<int, TextEditingController> _controllers = {};

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepCubit, int>(
      builder: (context, currentStep) {
        double progress = currentStep / widget.totalSteps;
        final controller = _controllers.putIfAbsent(currentStep, () => TextEditingController());

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        onPressed: () {
                          context.read<StepCubit>().previousStep();
                        },
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 10,
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4E7EFF)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: _buildStepContent(currentStep, controller),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          if (currentStep < widget.totalSteps) {
                            context.read<StepCubit>().nextStep(widget.totalSteps);
                          } else {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Success"),
                                content: const Text("All steps completed."),
                                actions: [
                                  TextButton(
                                    onPressed: () => GoRouter.of(context).pushReplacement(AppRouter.kBottomNavBar),
                                    child: const Text("OK"),
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4E74F9),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        currentStep < widget.totalSteps ? "Next" : "Finish",
                        style: Styles.textStyle16.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStepContent(int currentStep, TextEditingController controller) {
    switch (currentStep) {
      case 1:
        return _buildTextField(
          controller: controller,
          label: "What is your full name?",
          hint: "Full Name",
          keyboardType: TextInputType.name,
        );
      case 2:
        return _buildTextField(
          controller: controller,
          label: "How old are you?",
          hint: "Age",
          keyboardType: TextInputType.number,
        );
      case 3:
        return _buildTextField(
          controller: controller,
          label: "LinkedIn",
          hint: "LinkedIn profile link",
          keyboardType: TextInputType.url,
        );
      case 4:
        return _buildTextField(
          controller: controller,
          label: "Phone",
          hint: "Phone number",
          keyboardType: TextInputType.phone,
        );
      case 5:
        return _buildTextField(
          controller: controller,
          label: "E-mail",
          hint: "Your email address",
          keyboardType: TextInputType.emailAddress,
        );
      case 6:
        return _buildTextField(
          controller: controller,
          label: "In which university did you study and what is your specialty?",
          hint: "University and specialty",
          keyboardType: TextInputType.text,
          maxLines: 3,
        );
      case 7:
        return _buildTextField(
          controller: controller,
          label: "What is your field of specialization and how many years of experience do you have?",
          hint: "Field and years of experience",
          keyboardType: TextInputType.text,
          maxLines: 3,
        );
      case 8:
        return _buildTextField(
          controller: controller,
          label: "What places did you work in and do you have experience certificates?",
          hint: "Workplaces and certificates",
          keyboardType: TextInputType.text,
          maxLines: 3,
        );
      default:
        return const Text("Invalid step");
    }
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "This field is required";
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
