import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingProvider extends ChangeNotifier {
  // User data
  String _userName = '';
  String _userAvatar = '😊';
  List<String> _selectedGoals = [];
  List<String> _selectedGoodHabits = [];
  List<String> _selectedBadHabits = [];
  String _schedulePreference = 'morning'; // morning or night
  List<int> _preferredDays = [1, 2, 3, 4, 5, 6, 7]; // All days
  String _reminderTime = '09:00';

  // Getters
  String get userName => _userName;
  String get userAvatar => _userAvatar;
  List<String> get selectedGoals => _selectedGoals;
  List<String> get selectedGoodHabits => _selectedGoodHabits;
  List<String> get selectedBadHabits => _selectedBadHabits;
  String get schedulePreference => _schedulePreference;
  List<int> get preferredDays => _preferredDays;
  String get reminderTime => _reminderTime;

  // Setters
  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void setUserAvatar(String avatar) {
    _userAvatar = avatar;
    notifyListeners();
  }

  void toggleGoal(String goal) {
    if (_selectedGoals.contains(goal)) {
      _selectedGoals.remove(goal);
    } else {
      _selectedGoals.add(goal);
    }
    notifyListeners();
  }

  void toggleGoodHabit(String habit) {
    if (_selectedGoodHabits.contains(habit)) {
      _selectedGoodHabits.remove(habit);
    } else {
      _selectedGoodHabits.add(habit);
    }
    notifyListeners();
  }

  void toggleBadHabit(String habit) {
    if (_selectedBadHabits.contains(habit)) {
      _selectedBadHabits.remove(habit);
    } else {
      _selectedBadHabits.add(habit);
    }
    notifyListeners();
  }

  void setSchedulePreference(String preference) {
    _schedulePreference = preference;
    // Auto-adjust reminder time based on preference
    if (preference == 'morning') {
      _reminderTime = '07:00';
    } else {
      _reminderTime = '21:00';
    }
    notifyListeners();
  }

  void setReminderTime(String time) {
    _reminderTime = time;
    notifyListeners();
  }

  void togglePreferredDay(int day) {
    if (_preferredDays.contains(day)) {
      _preferredDays.remove(day);
    } else {
      _preferredDays.add(day);
    }
    notifyListeners();
  }

  // Save onboarding data
  Future<void> saveOnboardingData() async {
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.setBool('onboarding_completed', true);
    await prefs.setString('user_name', _userName);
    await prefs.setString('user_avatar', _userAvatar);
    await prefs.setStringList('user_goals', _selectedGoals);
    await prefs.setStringList('selected_good_habits', _selectedGoodHabits);
    await prefs.setStringList('selected_bad_habits', _selectedBadHabits);
    await prefs.setString('schedule_preference', _schedulePreference);
    await prefs.setString('reminder_time', _reminderTime);
    await prefs.setString('join_date', DateTime.now().toIso8601String());
  }

  // Load onboarding data (for editing profile later)
  Future<void> loadOnboardingData() async {
    final prefs = await SharedPreferences.getInstance();
    
    _userName = prefs.getString('user_name') ?? 'User';
    _userAvatar = prefs.getString('user_avatar') ?? '😊';
    _selectedGoals = prefs.getStringList('user_goals') ?? [];
    _selectedGoodHabits = prefs.getStringList('selected_good_habits') ?? [];
    _selectedBadHabits = prefs.getStringList('selected_bad_habits') ?? [];
    _schedulePreference = prefs.getString('schedule_preference') ?? 'morning';
    _reminderTime = prefs.getString('reminder_time') ?? '09:00';
    
    notifyListeners();
  }

  void reset() {
    _userName = '';
    _userAvatar = '😊';
    _selectedGoals = [];
    _selectedGoodHabits = [];
    _selectedBadHabits = [];
    _schedulePreference = 'morning';
    _preferredDays = [1, 2, 3, 4, 5, 6, 7];
    _reminderTime = '09:00';
    notifyListeners();
  }
}
