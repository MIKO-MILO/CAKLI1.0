import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/login_models.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header oranye dengan logo
          const LoginHeader(),

          // Body form dengan scroll
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tab Log in / Sign up
                        const AuthTabSelector(),
                        const SizedBox(height: 28),

                        // Alert banner (muncul jika ada pesan)
                        const AlertBanner(),

                        // Input email
                        const EmailInputField(),
                        const SizedBox(height: 20),

                        // Input password
                        const PasswordInputField(),
                        const SizedBox(height: 28),

                        // Tombol Continue
                        const ContinueButton(),
                        const SizedBox(height: 24),

                        // Pembatas "Or"
                        const OrDivider(),
                        const SizedBox(height: 24),

                        // Login dengan Apple
                        const AppleLoginButton(),
                        const SizedBox(height: 14),

                        // Login dengan Google
                        const GoogleLoginButton(),
                        const SizedBox(height: 32),

                        // Link Sign Up
                        const Center(child: SignUpLink()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// KOMPONEN: Header oranye + logo
// ─────────────────────────────────────────────────────────────────────────────

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFCC4E0A),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 28,
        bottom: 36,
        left: 24,
        right: 24,
      ),
      child: Column(
        children: [
          // Logo PNG — taruh file di assets/images/logo.png
          Image.asset(
            'assets/images/logo.png',
            height: 72,
            width: 72,
            errorBuilder: (_, _, _) => Container(
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
              ),
              child: const Icon(
                Icons.electric_rickshaw,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'CakLi',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'Becak Listrik',
            style: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.85),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// KOMPONEN: Tab "Log in" / "Sign up"
// ─────────────────────────────────────────────────────────────────────────────

class AuthTabSelector extends GetView<LoginController> {
  const AuthTabSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          _TabItem(
            label: 'Log in',
            isSelected: controller.selectedTab.value == 0,
            onTap: () {
              controller.selectedTab.value = 0;
              controller.dismissAlert();
            },
          ),
          _TabItem(
            label: 'Sign up',
            isSelected: controller.selectedTab.value == 1,
            onTap: () {
              controller.selectedTab.value = 1;
              controller.dismissAlert();
              // TODO: Get.toNamed(Routes.REGISTER);
            },
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? const Color(0xFFCC4E0A) : Colors.transparent,
              width: 2.5,
            ),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            color: isSelected ? const Color(0xFFCC4E0A) : Colors.grey,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// KOMPONEN: Alert Banner
// ─────────────────────────────────────────────────────────────────────────────

class AlertBanner extends GetView<LoginController> {
  const AlertBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final alert = controller.alertMessage.value;
      if (alert == null) return const SizedBox.shrink();
      return _AnimatedAlert(alert: alert, onDismiss: controller.dismissAlert);
    });
  }
}

class _AnimatedAlert extends StatefulWidget {
  final AlertData alert;
  final VoidCallback onDismiss;

  const _AnimatedAlert({required this.alert, required this.onDismiss});

  @override
  State<_AnimatedAlert> createState() => _AnimatedAlertState();
}

class _AnimatedAlertState extends State<_AnimatedAlert>
    with SingleTickerProviderStateMixin {
  late AnimationController _anim;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fade = CurvedAnimation(parent: _anim, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _anim, curve: Curves.easeOut));
    _anim.forward();
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  void _dismiss() async {
    await _anim.reverse();
    widget.onDismiss();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: widget.alert.backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: widget.alert.borderColor, width: 1.5),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(widget.alert.icon, color: widget.alert.textColor, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.alert.title,
                      style: GoogleFonts.poppins(
                        color: widget.alert.textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.alert.message,
                      style: GoogleFonts.poppins(
                        color: widget.alert.textColor.withOpacity(0.85),
                        fontSize: 12.5,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: _dismiss,
                child: Icon(
                  Icons.close,
                  size: 18,
                  color: widget.alert.textColor.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// KOMPONEN: Input Email
// ─────────────────────────────────────────────────────────────────────────────

class EmailInputField extends GetView<LoginController> {
  const EmailInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Email',
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onChanged: (_) => controller.dismissAlert(),
          style: GoogleFonts.poppins(fontSize: 15),
          decoration: InputDecoration(
            hintText: 'contoh@email.com',
            hintStyle: GoogleFonts.poppins(color: Colors.grey.shade400),
            prefixIcon: const Icon(
              Icons.email_outlined,
              color: Colors.grey,
              size: 20,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFCC4E0A), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email tidak boleh kosong';
            }
            final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
            if (!emailRegex.hasMatch(value)) return 'Format email tidak valid';
            return null;
          },
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// KOMPONEN: Input Password
// ─────────────────────────────────────────────────────────────────────────────

class PasswordInputField extends GetView<LoginController> {
  const PasswordInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final isObscured = true.obs;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Password',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Obx(
          () => TextFormField(
            controller: controller.passwordController,
            obscureText: isObscured.value,
            textInputAction: TextInputAction.done,
            onChanged: (_) => controller.dismissAlert(),
            style: GoogleFonts.poppins(fontSize: 15),
            decoration: InputDecoration(
              hintText: 'Masukkan password kamu',
              hintStyle: GoogleFonts.poppins(color: Colors.grey.shade400),
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: Colors.grey,
                size: 20,
              ),
              suffixIcon: IconButton(
                onPressed: () => isObscured.value = !isObscured.value,
                icon: Icon(
                  isObscured.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFCC4E0A),
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFD32F2F),
                  width: 2,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFD32F2F),
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password tidak boleh kosong';
              }
              if (value.length < 6) return 'Password minimal 6 karakter';
              return null;
            },
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => controller.showForgotPasswordDialog(context),
            child: Text(
              'Forgot password?',
              style: GoogleFonts.poppins(
                color: const Color(0xFFCC4E0A),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// KOMPONEN: Tombol Continue
// ─────────────────────────────────────────────────────────────────────────────

class ContinueButton extends GetView<LoginController> {
  const ContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: controller.isLoading.value ? null : controller.login,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFCC4E0A),
            disabledBackgroundColor: const Color(0xFFCC4E0A).withOpacity(0.6),
            foregroundColor: Colors.white,
            elevation: 2,
            shadowColor: const Color(0xFFCC4E0A).withOpacity(0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: controller.isLoading.value
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : Text(
                  'Continue',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// KOMPONEN: Divider "Or"
// ─────────────────────────────────────────────────────────────────────────────

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Or',
            style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// KOMPONEN: Tombol Login Apple
// ─────────────────────────────────────────────────────────────────────────────

class AppleLoginButton extends GetView<LoginController> {
  const AppleLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _SocialButton(
        label: 'Login with Apple',
        icon: const Icon(Icons.apple, size: 22, color: Color(0xFF1A1A1A)),
        isLoading: controller.isAppleLoading.value,
        onPressed: controller.loginWithApple,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// KOMPONEN: Tombol Login Google
// ─────────────────────────────────────────────────────────────────────────────

class GoogleLoginButton extends GetView<LoginController> {
  const GoogleLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _SocialButton(
        label: 'Login with Google',
        icon: const _GoogleIcon(),
        isLoading: controller.isGoogleLoading.value,
        onPressed: controller.loginWithGoogle,
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final bool isLoading;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.label,
    required this.icon,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF1A1A1A),
          side: BorderSide(color: Colors.grey.shade300, width: 1.5),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xFFCC4E0A),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  const SizedBox(width: 10),
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _GoogleIcon extends StatelessWidget {
  const _GoogleIcon();

  @override
  Widget build(BuildContext context) {
    // G sederhana menggunakan Text dengan warna Google
    return const Text(
      'G',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Color(0xFF4285F4),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// KOMPONEN: Link "Sign up"
// ─────────────────────────────────────────────────────────────────────────────

class SignUpLink extends GetView<LoginController> {
  const SignUpLink({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Don't have an account? ",
        style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
        children: [
          TextSpan(
            text: 'Sign up',
            style: GoogleFonts.poppins(
              color: const Color(0xFFCC4E0A),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                controller.selectedTab.value = 1;
                // TODO: Get.toNamed(Routes.REGISTER);
              },
          ),
        ],
      ),
    );
  }
}
