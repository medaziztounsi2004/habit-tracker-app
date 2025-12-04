import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/theme/app_theme.dart';
import '../common/glass_container.dart';

class IconPicker extends StatelessWidget {
  final IconData? selectedIcon;
  final Function(IconData) onIconSelected;

  const IconPicker({
    super.key,
    this.selectedIcon,
    required this.onIconSelected,
  });

  static const List<IconData> habitIcons = [
    // Health & Fitness
    Iconsax.heart,
    Iconsax.flash_1,
    Iconsax.activity,
    Iconsax.heart_tick,
    Iconsax.health,
    Iconsax.weight,
    Iconsax.weight_1,
    
    // Food & Drink
    Iconsax.drop,
    Iconsax.coffee,
    Iconsax.cake,
    
    // Sleep & Rest
    Iconsax.moon,
    Iconsax.sun_1,
    Iconsax.alarm,
    
    // Learning & Work
    Iconsax.book_1,
    Iconsax.teacher,
    Iconsax.pen_add,
    Iconsax.note_text,
    Iconsax.document_text,
    Iconsax.chart_1,
    
    // Mindfulness & Mental Health
    Iconsax.medal_star,
    Iconsax.emoji_happy,
    Iconsax.lovely,
    Iconsax.star_1,
    Iconsax.crown_1,
    
    // Social & Communication
    Iconsax.call,
    Iconsax.message,
    Iconsax.messages,
    Iconsax.user,
    Iconsax.people,
    
    // Productivity
    Iconsax.tick_circle,
    Iconsax.task_square,
    Iconsax.calendar,
    Iconsax.clock,
    Iconsax.timer,
    Iconsax.lamp_charge,
    Iconsax.lamp_1,
    
    // Creative
    Iconsax.brush,
    Iconsax.music,
    Iconsax.camera,
    Iconsax.microphone,
    Iconsax.video,
    
    // Finance
    Iconsax.wallet,
    Iconsax.money,
    Iconsax.card,
    Iconsax.chart_success,
    Iconsax.trend_up,
    
    // Nature & Environment
    Iconsax.tree,
    Iconsax.sun_fog,
    Iconsax.cloud,
    
    // Technology & Digital
    Iconsax.mobile,
    Iconsax.monitor,
    Iconsax.game,
    
    // Quit Habits
    Iconsax.danger,
    Iconsax.close_circle,
    Iconsax.shield_tick,
    
    // Achievement & Goals
    Iconsax.cup,
    Iconsax.award,
    Iconsax.diamonds,
    Iconsax.send_2,
    Iconsax.flag,
    
    // Miscellaneous
    Iconsax.home,
    Iconsax.car,
    Iconsax.shopping_cart,
    Iconsax.gift,
    Iconsax.heart_circle,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.all(20),
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
            'Choose an Icon',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),
          // Icon grid
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemCount: habitIcons.length,
              itemBuilder: (context, index) {
                final icon = habitIcons[index];
                final isSelected = selectedIcon == icon;

                return GestureDetector(
                  onTap: () {
                    onIconSelected(icon);
                    Navigator.pop(context);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      gradient: isSelected ? AppColors.primaryGradient : null,
                      color: isSelected
                          ? null
                          : Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withAlpha(25),
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected
                          ? Border.all(
                              color: AppColors.primaryPurple,
                              width: 2,
                            )
                          : null,
                    ),
                    child: Icon(
                      icon,
                      color: isSelected
                          ? Colors.white
                          : Theme.of(context).colorScheme.onSurface,
                      size: 28,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Show the icon picker as a modal bottom sheet
  static Future<IconData?> show(
    BuildContext context, {
    IconData? selectedIcon,
  }) async {
    IconData? result;

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => IconPicker(
        selectedIcon: selectedIcon,
        onIconSelected: (icon) {
          result = icon;
        },
      ),
    );

    return result;
  }
}
