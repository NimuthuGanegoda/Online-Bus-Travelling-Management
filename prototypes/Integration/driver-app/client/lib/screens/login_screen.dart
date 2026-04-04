import 'package:driver_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class DriverLoginScreen extends StatefulWidget {
  const DriverLoginScreen({super.key, required this.supabaseReady});

  final bool supabaseReady;

  @override
  State<DriverLoginScreen> createState() => _DriverLoginScreenState();
}

class _DriverLoginScreenState extends State<DriverLoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final _registerFormKey = GlobalKey<FormState>();
  final _driverIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _registerNameController = TextEditingController();
  final _registerDriverIdController = TextEditingController();
  final _registerPhoneController = TextEditingController();
  final _registerEmailController = TextEditingController();
  final _registerPasswordController = TextEditingController();
  final _registerConfirmPasswordController = TextEditingController();

  var _hideLoginPassword = true;
  var _hideRegisterPassword = true;
  var _hideConfirmPassword = true;
  var _isSubmitting = false;
  String? _statusMessage;

  @override
  void dispose() {
    _driverIdController.dispose();
    _passwordController.dispose();
    _registerNameController.dispose();
    _registerDriverIdController.dispose();
    _registerPhoneController.dispose();
    _registerEmailController.dispose();
    _registerPasswordController.dispose();
    _registerConfirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_loginFormKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
      _statusMessage = null;
    });

    await Future<void>.delayed(const Duration(milliseconds: 450));

    if (!mounted) {
      return;
    }

    setState(() {
      _isSubmitting = false;
    });

    Navigator.of(context).pushReplacementNamed(DriverHomeScreen.routeName);
  }

  Future<void> _register() async {
    if (!_registerFormKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
      _statusMessage = null;
    });

    await Future<void>.delayed(const Duration(milliseconds: 450));

    if (!mounted) {
      return;
    }

    setState(() {
      _isSubmitting = false;
      _statusMessage =
          'Driver profile staged successfully. Approval flow can be connected next.';
    });
  }

  String? _validateDriverId(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) {
      return 'Driver ID is required.';
    }
    if (input.length < 4) {
      return 'Use at least 4 characters.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    final input = value ?? '';
    if (input.isEmpty) {
      return 'Password is required.';
    }
    if (input.length < 8) {
      return 'Use at least 8 characters.';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) {
      return 'Email is required.';
    }
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(input)) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF140B09), Color(0xFF2B1712), Color(0xFF140B09)],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 470),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Icon(
                                  Icons.badge_outlined,
                                  size: 32,
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'SL BusTrack',
                                      style: theme.textTheme.headlineSmall
                                          ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
                                      'Driver operations portal',
                                      style: TextStyle(
                                        color: Color(0xFFD9B7AA),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          if (!widget.supabaseReady)
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 18),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: const Color(0x33F4B942),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: const Color(0x66F4B942),
                                ),
                              ),
                              child: const Text(
                                'Supabase is unavailable in this environment. Driver UI is running in standalone mode.',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          if (_statusMessage != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 18),
                              child: Text(
                                _statusMessage!,
                                style: const TextStyle(
                                  color: Color(0xFFFFD2C8),
                                ),
                              ),
                            ),
                          TabBar(
                            indicator: BoxDecoration(
                              color: const Color(0xFF3B241F),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            dividerColor: Colors.transparent,
                            labelColor: Colors.white,
                            unselectedLabelColor: const Color(0xFFAF8C82),
                            tabs: const [
                              Tab(text: 'Login'),
                              Tab(text: 'Register'),
                            ],
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            height: 560,
                            child: TabBarView(
                              children: [
                                _buildLoginForm(context),
                                _buildRegisterForm(context),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Driver sign in',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _driverIdController,
            textInputAction: TextInputAction.next,
            style: const TextStyle(color: Colors.white),
            validator: _validateDriverId,
            decoration: const InputDecoration(
              labelText: 'Driver ID or username',
              prefixIcon: Icon(Icons.person_outline_rounded),
              filled: true,
              fillColor: Color(0xFF3A2520),
            ),
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _passwordController,
            obscureText: _hideLoginPassword,
            textInputAction: TextInputAction.done,
            style: const TextStyle(color: Colors.white),
            validator: _validatePassword,
            onFieldSubmitted: (_) => _isSubmitting ? null : _login(),
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              filled: true,
              fillColor: const Color(0xFF3A2520),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _hideLoginPassword = !_hideLoginPassword;
                  });
                },
                icon: Icon(
                  _hideLoginPassword
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                setState(() {
                  _statusMessage =
                      'Credential reset is not connected yet. Use dispatch support for recovery.';
                });
              },
              child: const Text('Forgot credentials?'),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _isSubmitting ? null : _login,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Login as Driver'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterForm(BuildContext context) {
    return Form(
      key: _registerFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Driver onboarding',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _registerNameController,
            textInputAction: TextInputAction.next,
            style: const TextStyle(color: Colors.white),
            validator: (value) {
              final input = value?.trim() ?? '';
              if (input.isEmpty) {
                return 'Full name is required.';
              }
              return input.length < 3 ? 'Enter your full name.' : null;
            },
            decoration: const InputDecoration(
              labelText: 'Full name',
              prefixIcon: Icon(Icons.badge_rounded),
              filled: true,
              fillColor: Color(0xFF3A2520),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _registerDriverIdController,
            textInputAction: TextInputAction.next,
            style: const TextStyle(color: Colors.white),
            validator: _validateDriverId,
            decoration: const InputDecoration(
              labelText: 'Driver ID',
              prefixIcon: Icon(Icons.pin_outlined),
              filled: true,
              fillColor: Color(0xFF3A2520),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _registerPhoneController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            style: const TextStyle(color: Colors.white),
            validator: (value) {
              final digits = (value ?? '').replaceAll(RegExp(r'\D'), '');
              if (digits.length < 10) {
                return 'Enter a valid phone number.';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Phone number',
              prefixIcon: Icon(Icons.phone_outlined),
              filled: true,
              fillColor: Color(0xFF3A2520),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _registerEmailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            style: const TextStyle(color: Colors.white),
            validator: _validateEmail,
            decoration: const InputDecoration(
              labelText: 'Email address',
              prefixIcon: Icon(Icons.mail_outline_rounded),
              filled: true,
              fillColor: Color(0xFF3A2520),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _registerPasswordController,
            obscureText: _hideRegisterPassword,
            textInputAction: TextInputAction.next,
            style: const TextStyle(color: Colors.white),
            validator: _validatePassword,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              filled: true,
              fillColor: const Color(0xFF3A2520),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _hideRegisterPassword = !_hideRegisterPassword;
                  });
                },
                icon: Icon(
                  _hideRegisterPassword
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _registerConfirmPasswordController,
            obscureText: _hideConfirmPassword,
            textInputAction: TextInputAction.done,
            style: const TextStyle(color: Colors.white),
            validator: (value) {
              final error = _validatePassword(value);
              if (error != null) {
                return error;
              }
              if (value != _registerPasswordController.text) {
                return 'Passwords do not match.';
              }
              return null;
            },
            onFieldSubmitted: (_) => _isSubmitting ? null : _register(),
            decoration: InputDecoration(
              labelText: 'Confirm password',
              prefixIcon: const Icon(Icons.verified_user_outlined),
              filled: true,
              fillColor: const Color(0xFF3A2520),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _hideConfirmPassword = !_hideConfirmPassword;
                  });
                },
                icon: Icon(
                  _hideConfirmPassword
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                ),
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: FilledButton.tonal(
              onPressed: _isSubmitting ? null : _register,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text('Submit Driver Profile'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
