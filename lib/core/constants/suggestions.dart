class HabitSuggestions {
  static const List<Map<String, dynamic>> goodHabits = [
    {'name': 'Drink Water', 'icon': '💧', 'category': 'Health'},
    {'name': 'Exercise', 'icon': '🏃', 'category': 'Fitness'},
    {'name': 'Meditate', 'icon': '🧘', 'category': 'Mindfulness'},
    {'name': 'Read', 'icon': '📚', 'category': 'Learning'},
    {'name': 'Sleep 8 Hours', 'icon': '😴', 'category': 'Health'},
    {'name': 'Eat Healthy', 'icon': '🥗', 'category': 'Nutrition'},
    {'name': 'Journal', 'icon': '✍️', 'category': 'Mindfulness'},
    {'name': 'Wake Early', 'icon': '🌅', 'category': 'Productivity'},
    {'name': 'Take Vitamins', 'icon': '💊', 'category': 'Health'},
    {'name': 'Walk 10K Steps', 'icon': '🚶', 'category': 'Fitness'},
    {'name': 'Screen-Free Hour', 'icon': '📵', 'category': 'Digital Wellness'},
    {'name': 'Practice Gratitude', 'icon': '🙏', 'category': 'Mindfulness'},
    {'name': 'Study', 'icon': '📖', 'category': 'Learning'},
    {'name': 'Yoga', 'icon': '🧘‍♀️', 'category': 'Fitness'},
    {'name': 'Stretch', 'icon': '🤸', 'category': 'Fitness'},
    {'name': 'Floss', 'icon': '🦷', 'category': 'Health'},
    {'name': 'Cold Shower', 'icon': '🚿', 'category': 'Health'},
    {'name': 'Meal Prep', 'icon': '🍱', 'category': 'Nutrition'},
    {'name': 'Learn Language', 'icon': '🗣️', 'category': 'Learning'},
    {'name': 'Play Instrument', 'icon': '🎸', 'category': 'Creative'},
    {'name': 'Draw/Paint', 'icon': '🎨', 'category': 'Creative'},
    {'name': 'Call Family', 'icon': '📞', 'category': 'Social'},
    {'name': 'Skin Care', 'icon': '🧴', 'category': 'Health'},
    {'name': 'No Snacking', 'icon': '🍎', 'category': 'Nutrition'},
    {'name': 'Budget Review', 'icon': '💰', 'category': 'Finance'},
  ];

  static const List<Map<String, dynamic>> badHabits = [
    {
      'name': 'Smoking',
      'icon': '🚬',
      'category': 'Health',
      'moneyPerDay': 10.0
    },
    {
      'name': 'Alcohol',
      'icon': '🍺',
      'category': 'Health',
      'moneyPerDay': 15.0
    },
    {
      'name': 'Social Media Addiction',
      'icon': '📱',
      'category': 'Digital',
      'moneyPerDay': 0.0
    },
    {
      'name': 'Sugar/Junk Food',
      'icon': '🍬',
      'category': 'Health',
      'moneyPerDay': 8.0
    },
    {
      'name': 'Caffeine',
      'icon': '☕',
      'category': 'Health',
      'moneyPerDay': 5.0
    },
    {
      'name': 'Nail Biting',
      'icon': '💅',
      'category': 'Health',
      'moneyPerDay': 0.0
    },
    {
      'name': 'Gaming Addiction',
      'icon': '🎮',
      'category': 'Digital',
      'moneyPerDay': 0.0
    },
    {
      'name': 'Oversleeping',
      'icon': '😴',
      'category': 'Health',
      'moneyPerDay': 0.0
    },
    {
      'name': 'Impulse Shopping',
      'icon': '🛒',
      'category': 'Finance',
      'moneyPerDay': 20.0
    },
    {
      'name': 'Negative Self-Talk',
      'icon': '😠',
      'category': 'Mental Health',
      'moneyPerDay': 0.0
    },
    {
      'name': 'Procrastination',
      'icon': '⏰',
      'category': 'Productivity',
      'moneyPerDay': 0.0
    },
    {
      'name': 'Fast Food',
      'icon': '🍔',
      'category': 'Nutrition',
      'moneyPerDay': 12.0
    },
    {
      'name': 'Energy Drinks',
      'icon': '🥤',
      'category': 'Health',
      'moneyPerDay': 4.0
    },
    {
      'name': 'Late Night Snacking',
      'icon': '🍕',
      'category': 'Nutrition',
      'moneyPerDay': 6.0
    },
    {
      'name': 'Excessive TV',
      'icon': '📺',
      'category': 'Digital',
      'moneyPerDay': 0.0
    },
  ];

  static const List<String> userGoals = [
    '🏃 Build healthy habits',
    '🚫 Quit bad habits',
    '📈 Track my progress',
    '🎯 Achieve my goals',
    '🧘 Improve mindfulness',
    '💪 Get fit',
    '📚 Learn new skills',
    '🌟 Boost productivity',
  ];

  static const List<String> avatarEmojis = [
    '😊',
    '🤩',
    '😎',
    '🥳',
    '🤗',
    '😇',
    '🥰',
    '😺',
    '🦊',
    '🐼',
    '🦁',
    '🐯',
    '🐻',
    '🐨',
    '🐸',
    '🦉',
    '🦄',
    '🌟',
    '⭐',
    '✨',
    '🔥',
    '💎',
    '🌈',
    '🎨',
  ];

  // Motivational quotes for panic button
  static const Map<String, List<String>> motivationalQuotes = {
    'smoking': [
      'Every cigarette you don\'t smoke is doing you good!',
      'You\'re stronger than your cravings. This too shall pass.',
      'Think about how proud you\'ll be tomorrow.',
      'Your body is already healing. Keep going!',
      'You didn\'t come this far to only come this far.',
    ],
    'alcohol': [
      'One day at a time. You\'ve got this.',
      'Your future self will thank you for staying strong.',
      'The urge will pass. Stay present.',
      'You\'re breaking the cycle. That\'s powerful.',
      'Remember why you started this journey.',
    ],
    'social_media': [
      'Real life is happening right now. Don\'t miss it.',
      'Your mind deserves this break.',
      'Comparison is the thief of joy. Stay offline.',
      'You\'re rewiring your brain for better focus.',
      'The best moments aren\'t posted online.',
    ],
    'junk_food': [
      'Your body deserves nourishment, not punishment.',
      'This craving will pass in 10 minutes.',
      'Think about how you\'ll feel after vs. before.',
      'You\'re building a healthier relationship with food.',
      'Real food, real energy, real you.',
    ],
    'default': [
      'You\'ve come too far to give up now.',
      'Progress, not perfection.',
      'Every moment is a fresh start.',
      'You\'re stronger than you think.',
      'Believe in yourself. You can do this.',
    ],
  };

  // Coping strategies for panic button
  static const Map<String, List<String>> copingStrategies = {
    'smoking': [
      'Drink a glass of water slowly',
      'Take 10 deep breaths',
      'Go for a 5-minute walk',
      'Chew gum or eat a mint',
      'Call a supportive friend',
      'Do 10 push-ups or jumping jacks',
    ],
    'alcohol': [
      'Call your sponsor or support person',
      'Attend a virtual meeting',
      'Drink sparkling water or tea',
      'Go for a walk or run',
      'Practice the 4-7-8 breathing technique',
      'Journal about your feelings',
    ],
    'social_media': [
      'Put phone in another room for 30 minutes',
      'Read a chapter of a book',
      'Do a 5-minute meditation',
      'Call a friend instead',
      'Go outside for fresh air',
      'Work on a hobby or project',
    ],
    'junk_food': [
      'Drink a large glass of water',
      'Eat a healthy snack like fruit or nuts',
      'Brush your teeth',
      'Take a short walk',
      'Do a quick workout',
      'Call a friend to distract yourself',
    ],
    'default': [
      'Take 5 deep breaths',
      'Drink a glass of water',
      'Go for a short walk',
      'Listen to your favorite music',
      'Talk to someone you trust',
      'Write down your thoughts',
    ],
  };
}
