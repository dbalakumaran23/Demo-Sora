import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

/// Manages authentication state — login, register, token storage.
class AuthService {
  static const String _tokenKey = 'jwt_token';
  static const String _userKey = 'user_data';

  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  String? _cachedToken;
  Map<String, dynamic>? _cachedUser;
  bool _isGuest = false;

  /// Whether the current session is a guest (restricted) session.
  bool get isGuest => _isGuest;

  /// Start a guest session — no backend call, just sets the flag.
  void loginAsGuest() {
    _isGuest = true;
  }

  /// Get stored JWT token.
  Future<String?> getToken() async {
    if (_cachedToken != null) return _cachedToken;
    final prefs = await SharedPreferences.getInstance();
    _cachedToken = prefs.getString(_tokenKey);
    return _cachedToken;
  }

  /// Check if user is logged in.
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  /// Register a new user.
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String fullName,
    String? department,
    String? year,
    String? semester,
    String? rollNumber,
  }) async {
    final response = await ApiService().post('/auth/register', body: {
      'email': email,
      'password': password,
      'full_name': fullName,
      if (department != null) 'department': department,
      if (year != null) 'year': year,
      if (semester != null) 'semester': semester,
      if (rollNumber != null) 'roll_number': rollNumber,
    });

    await _saveSession(response['token'], response['user']);
    return response;
  }

  /// Login with email and password.
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await ApiService().post('/auth/login', body: {
      'email': email,
      'password': password,
    });

    await _saveSession(response['token'], response['user']);
    return response;
  }

  /// Get current user profile from backend.
  Future<Map<String, dynamic>> getProfile() async {
    final response = await ApiService().get('/auth/profile');
    _cachedUser = response['user'];
    return response;
  }

  /// Update user profile.
  Future<Map<String, dynamic>> updateProfile(
      Map<String, dynamic> updates) async {
    final response = await ApiService().put('/auth/profile', body: updates);
    _cachedUser = response['user'];
    return response;
  }

  /// Get cached user data.
  Map<String, dynamic>? get currentUser => _cachedUser;

  /// Logout — clear stored token and guest flag.
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
    _cachedToken = null;
    _cachedUser = null;
    _isGuest = false;
  }

  /// Save token and user to SharedPreferences.
  Future<void> _saveSession(String token, Map<String, dynamic> user) async {
    _cachedToken = token;
    _cachedUser = user;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }
}
