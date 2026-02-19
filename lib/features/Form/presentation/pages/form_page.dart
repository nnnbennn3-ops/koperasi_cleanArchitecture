import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/form_cubit.dart';
import '../cubit/form_state.dart';

class FormPage extends StatelessWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F5F7),
      appBar: AppBar(
        title: const Text("Formulir"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: BlocBuilder<FormCubit, FormStatus>(
        builder: (context, state) {
          if (state is FormLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FormLoaded) {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: state.forms.length,
              separatorBuilder:
                  (_, __) => Divider(color: Colors.grey.shade200, height: 1),
              itemBuilder: (context, index) {
                final form = state.forms[index];

                return ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.picture_as_pdf, color: Colors.red),
                  ),
                  title: Text(
                    form.title,
                    style: GoogleFonts.beVietnamPro(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    form.updatedAt,
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  onTap: () {
                    // nanti bisa buka PDF / detail
                  },
                );
              },
            );
          }

          if (state is FormError) {
            return Center(
              child: Text(
                state.message,
                style: GoogleFonts.beVietnamPro(color: Colors.red),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
