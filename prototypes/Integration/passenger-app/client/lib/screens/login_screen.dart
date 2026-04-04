import 'package:flutter/material.dart';
import 'package:passenger_app/screens/home_screen.dart';

class PassengerLoginScreen extends StatefulWidget {
  const PassengerLoginScreen({super.key, required this.supabaseReady});

  final bool supabaseReady;

  @override
  State<PassengerLoginScreen> createState() => _PassengerLoginScreenState();
}

class _PassengerLoginScreenState extends State<PassengerLoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final _registerFormKey = GlobalKey<FormState>();
  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  final _registerNameController = TextEditingController();
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
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _registerNameController.dispose();
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

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => PassengerHomeScreen(
          passengerName: _extractDisplayName(_loginEmailController.text),
        ),
      ),
    );
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
    });

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => PassengerHomeScreen(
          passengerName: _registerNameController.text.trim(),
        ),
      ),
    );
  }

  String _extractDisplayName(String email) {
    final value = email.trim();
    if (!value.contains('@')) {
      return 'Passenger';
    }

    return value
        .split('@')
        .first
        .replaceAll('.', ' ')
        .trim()
        .split(' ')
        .map((segment) {
          if (segment.isEmpty) {
            return segment;
          }
          return '${segment[0].toUpperCase()}${segment.substring(1)}';
        })
        .join(' ');
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF08131A), Color(0xFF123342), Color(0xFF08131A)],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 460),
                  child: Card(
                    elevation: 10,
                    color: const Color(0xCC10212A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.directions_bus_filled_rounded,
                              color: theme.colorScheme.onPrimaryContainer,
                              size: 34,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'SL BusTrack',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Passenger access for route tracking, arrivals, and trip status.',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: const Color(0xFFB1C5D0),
                              height: 1.45,
                            ),
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
                                'Supabase is unavailable in this environment. UI flows still work for demo and validation.',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          if (_statusMessage != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 18),
                              child: Text(
                                _statusMessage!,
                                style: const TextStyle(
                                  color: Color(0xFFFF8F8F),
                                ),
                              ),
                            ),
                          TabBar(
                            labelColor: Colors.white,
                            unselectedLabelColor: const Color(0xFF8DA4AF),
                            indicator: BoxDecoration(
                              color: const Color(0xFF214150),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            dividerColor: Colors.transparent,
                            tabs: const [
                              Tab(text: 'Login'),
                              Tab(text: 'Register'),
                            ],
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            height: 510,
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
            'Passenger sign in',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _loginEmailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            style: const TextStyle(color: Colors.white),
            validator: _validateEmail,
            decoration: const InputDecoration(
              labelText: 'Email address',
              prefixIcon: Icon(Icons.alternate_email_rounded),
            ),
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _loginPasswordController,
            obscureText: _hideLoginPassword,
            textInputAction: TextInputAction.done,
            style: const TextStyle(color: Colors.white),
            validator: _validatePassword,
            onFieldSubmitted: (_) => _isSubmitting ? null : _login(),
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline_rounded),
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
                      'Password recovery is not wired yet. Contact operations support.';
                });
              },
              child: const Text('Need help signing in?'),
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
                    : const Text('Login as Passenger'),
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
            'Create passenger account',
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
              if (input.length < 3) {
                return 'Enter your full name.';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Full name',
              prefixIcon: Icon(Icons.person_outline_rounded),
            ),
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _registerEmailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            style: const TextStyle(color: Colors.white),
            validator: _validateEmail,
            decoration: const InputDecoration(
              labelText: 'Email address',
              prefixIcon: Icon(Icons.mail_outline_rounded),
            ),
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _registerPasswordController,
            obscureText: _hideRegisterPassword,
            textInputAction: TextInputAction.next,
            style: const TextStyle(color: Colors.white),
            validator: _validatePassword,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline_rounded),
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
          const SizedBox(height: 18),
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
                child: Text('Create Account'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
