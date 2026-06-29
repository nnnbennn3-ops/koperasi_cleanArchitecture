import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture/core/widgets/app_input_widgets.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _oldPassController = TextEditingController();
  final _newPassController = TextEditingController();
  final _confirmPassController = TextEditingController();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _oldPassController.dispose();
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    context.read<SettingsCubit>().doChangePassword(
      oldPassword: _oldPassController.text,
      newPassword: _newPassController.text,
      confirmPassword: _confirmPassController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SafeArea(
        child: BlocListener<SettingsCubit, SettingsState>(
          listener: (context, state) {
            if (state is SettingsUpdateSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green.shade700,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              Navigator.pop(context);
            }
            if (state is SettingsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red.shade700,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                appPasswordField(
                  label: 'Password Lama',
                  controller: _oldPassController,
                  obscure: _obscureOld,
                  onToggle: () => setState(() => _obscureOld = !_obscureOld),
                ),
                const SizedBox(height: 16),

                appPasswordField(
                  label: 'Password Baru',
                  controller: _newPassController,
                  obscure: _obscureNew,
                  onToggle: () => setState(() => _obscureNew = !_obscureNew),
                ),
                const SizedBox(height: 16),

                appPasswordField(
                  label: 'Konfirmasi Password Baru',
                  controller: _confirmPassController,
                  obscure: _obscureConfirm,
                  onToggle:
                      () => setState(() => _obscureConfirm = !_obscureConfirm),
                ),

                const Spacer(),

                BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    return appPrimaryButton(
                      label: 'Ganti Password',
                      onPressed: _onSubmit,
                      isLoading: state is SettingsUpdateLoading,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
