import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_typography.dart';
import '../../core/localization/app_locale.dart';
import '../../core/utils/url_helper.dart';
import '../../widgets/cards/glass_card.dart';
import '../../widgets/common/clean_button.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isSubmitting = false;
  bool _isSubmitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit(AppStrings strings) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final senderName = _nameController.text.trim();
    final senderEmail = _emailController.text.trim();
    final subjectTopic = _subjectController.text.trim();
    final messageBody = _messageController.text.trim();

    final emailSubject = subjectTopic.isNotEmpty
        ? '[Portofolio] $subjectTopic - $senderName'
        : '[Portofolio] Pesan Baru dari $senderName';

    final emailContent = '''
Halo Nazarul Qudri, S.Tr.T.,

Pesan baru dari pengunjung portofolio Anda:

• Nama Pengirim: $senderName
• Email Pengirim: $senderEmail
• Topik Proyek / Keperluan: $subjectTopic

Detail Pesan:
--------------------------------------------------
$messageBody
--------------------------------------------------
''';

    await UrlHelper.sendEmail(
      AppConstants.email,
      subject: emailSubject,
      body: emailContent,
    );

    if (mounted) {
      setState(() {
        _isSubmitting = false;
        _isSubmitted = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Membuka aplikasi email untuk mengirim ke ${AppConstants.email}...',
                  style: AppTypography.bodyMedium.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(20),
          duration: const Duration(seconds: 4),
        ),
      );

      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: LocaleController.instance,
      builder: (context, _) {
        final strings = AppStrings(LocaleController.instance.currentLanguage);

        return GlassCard(
          borderRadius: 24,
          blur: 20,
          padding: const EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.softCyan,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.edit_note_rounded,
                        color: AppColors.primary,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          strings.isId
                              ? 'Kirim Pesan Langsung'
                              : 'Send a Direct Message',
                          style: AppTypography.headingSmall.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          strings.isId
                              ? 'Biasanya merespons dalam waktu 24 jam'
                              : 'Typically responds within 24 hours',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Name Field
                _buildFieldLabel(strings.yourName),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: strings.isId
                        ? 'cth. Muhammad Rizki'
                        : 'e.g. Alex Johnson',
                    prefixIcon:
                        const Icon(Icons.person_outline_rounded, size: 20),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return strings.nameValidation;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),

                // Email Field
                _buildFieldLabel(strings.emailAddress),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'alex@company.com',
                    prefixIcon: Icon(Icons.email_outlined, size: 20),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return strings.emailValidation;
                    }
                    if (!val.contains('@') || !val.contains('.')) {
                      return strings.emailValidation;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),

                // Subject / Project Type Field
                _buildFieldLabel(strings.projectTopic),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _subjectController,
                  decoration: InputDecoration(
                    hintText: strings.isId
                        ? 'cth. Aplikasi Mobile Flutter / Sistem IoT'
                        : 'e.g. Flutter Mobile App / IoT Architecture',
                    prefixIcon: const Icon(Icons.topic_outlined, size: 20),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return strings.topicValidation;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),

                // Message Field
                _buildFieldLabel(strings.yourMessage),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _messageController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: strings.isId
                        ? 'Jelaskan tujuan proyek, perkiraan jadwal, dan visi Anda...'
                        : 'Tell me about your project goals, timeline, and vision...',
                    alignLabelWithHint: true,
                  ),
                  validator: (val) {
                    if (val == null || val.trim().length < 10) {
                      return strings.messageValidation;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 28),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: _isSubmitting
                      ? Center(
                          child: Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.all(10),
                            child: const CircularProgressIndicator(
                              strokeWidth: 3,
                              color: AppColors.primary,
                            ),
                          ),
                        )
                      : CleanButton(
                          text: _isSubmitted
                              ? strings.sendAnother
                              : strings.sendMessage,
                          icon: Icons.send_rounded,
                          isTrailingIcon: true,
                          variant: CleanButtonVariant.primary,
                          height: 52,
                          onPressed: () => _handleSubmit(strings),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: AppTypography.badge.copyWith(
        fontSize: 11,
        color: AppColors.textPrimary,
        letterSpacing: 0.8,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

