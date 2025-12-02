import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/theme/app_theme.dart';
import '../common/glass_container.dart';

class ModernTimePicker extends StatefulWidget {
  final TimeOfDay? initialTime;
  final Function(TimeOfDay) onTimeSelected;

  const ModernTimePicker({
    super.key,
    this.initialTime,
    required this.onTimeSelected,
  });

  @override
  State<ModernTimePicker> createState() => _ModernTimePickerState();
}

class _ModernTimePickerState extends State<ModernTimePicker> {
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.initialTime ?? const TimeOfDay(hour: 9, minute: 0);
  }

  final List<Map<String, dynamic>> presets = [
    {
      'name': 'Morning',
      'icon': Iconsax.sun_1,
      'time': const TimeOfDay(hour: 7, minute: 0),
      'gradient': LinearGradient(
        colors: [Color(0xFFFFA726), Color(0xFFFF7043)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    },
    {
      'name': 'Noon',
      'icon': Iconsax.sun_fog,
      'time': const TimeOfDay(hour: 12, minute: 0),
      'gradient': LinearGradient(
        colors: [Color(0xFFFFD54F), Color(0xFFFFCA28)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    },
    {
      'name': 'Evening',
      'icon': Iconsax.moon,
      'time': const TimeOfDay(hour: 18, minute: 0),
      'gradient': LinearGradient(
        colors: [Color(0xFF7E57C2), Color(0xFF5E35B1)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    },
    {
      'name': 'Night',
      'icon': Iconsax.moon,
      'time': const TimeOfDay(hour: 21, minute: 0),
      'gradient': LinearGradient(
        colors: [Color(0xFF424242), Color(0xFF212121)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    },
  ];

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  void _selectPreset(TimeOfDay time) {
    setState(() {
      selectedTime = time;
    });
  }

  Future<void> _pickCustomTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? const TimeOfDay(hour: 9, minute: 0),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              hourMinuteShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              dayPeriodShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(51),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          // Title
          Text(
            'Set Reminder Time',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 24),
          // Current selection display
          GlassContainer(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.clock,
                      size: 24,
                      color: AppColors.primaryPurple,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      selectedTime != null
                          ? _formatTime(selectedTime!)
                          : 'Not set',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Quick presets title
          Row(
            children: [
              Icon(
                Iconsax.flash_1,
                size: 18,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(153),
              ),
              const SizedBox(width: 8),
              Text(
                'Quick Presets',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color:
                      Theme.of(context).colorScheme.onSurface.withAlpha(153),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Preset buttons grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.2,
            ),
            itemCount: presets.length,
            itemBuilder: (context, index) {
              final preset = presets[index];
              final isSelected = selectedTime == preset['time'];

              return GestureDetector(
                onTap: () => _selectPreset(preset['time']),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: isSelected ? preset['gradient'] : null,
                    color: isSelected
                        ? null
                        : Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withAlpha(25),
                    borderRadius: BorderRadius.circular(16),
                    border: isSelected
                        ? Border.all(color: Colors.white.withAlpha(76), width: 2)
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        preset['icon'],
                        color: isSelected
                            ? Colors.white
                            : Theme.of(context).colorScheme.onSurface,
                        size: 28,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        preset['name'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? Colors.white
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        _formatTime(preset['time']),
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected
                              ? Colors.white.withAlpha(204)
                              : Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withAlpha(153),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          // Custom time button
          OutlinedButton(
            onPressed: _pickCustomTime,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              side: BorderSide(
                color: AppColors.primaryPurple.withAlpha(128),
                width: 2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.setting_2, color: AppColors.primaryPurple),
                const SizedBox(width: 12),
                const Text(
                  'Pick Custom Time',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Confirm button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (selectedTime != null) {
                  widget.onTimeSelected(selectedTime!);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: AppColors.primaryPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Show the modern time picker as a modal bottom sheet
  static Future<TimeOfDay?> show(
    BuildContext context, {
    TimeOfDay? initialTime,
  }) async {
    TimeOfDay? result;

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ModernTimePicker(
        initialTime: initialTime,
        onTimeSelected: (time) {
          result = time;
        },
      ),
    );

    return result;
  }
}
