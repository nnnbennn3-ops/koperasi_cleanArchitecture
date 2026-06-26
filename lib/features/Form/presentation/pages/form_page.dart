import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/form_cubit.dart';
import '../cubit/form_state.dart';
import '../../domain/entities/form.dart';

class FormPage extends StatelessWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ------------------ JUDUL ----------------------------
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: Text(
                'Formulir',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),

            // ------------------- LIST -----------------------------
            Expanded(
              child: BlocBuilder<FormCubit, FormulirState>(
                builder: (context, state) {
                  if (state is FormulirLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is FormulirError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: GoogleFonts.beVietnamPro(color: Colors.red),
                      ),
                    );
                  }
                  if (state is FormulirLoaded) {
                    return ListView.separated(
                      itemCount: state.forms.length,
                      separatorBuilder:
                          (_, __) =>
                              Divider(color: Colors.grey.shade200, height: 1),
                      itemBuilder: (_, i) => _formItem(state.forms[i]),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formItem(FormItem form) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.picture_as_pdf, color: Colors.red, size: 24),
      ),
      title: Text(
        form.title,
        style: GoogleFonts.beVietnamPro(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
      subtitle: Text(
        form.updatedAt,
        style: GoogleFonts.beVietnamPro(
          fontSize: 12,
          color: Colors.grey.shade500,
        ),
      ),
      onTap: () {
        // TO DO : buka pdf
      },
    );
  }
}
