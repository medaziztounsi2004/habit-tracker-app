import 'package:flutter/material.dart';
import 'dart:math';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import 'glass_container.dart';

class MotivationalQuoteCard extends StatefulWidget {
  const MotivationalQuoteCard({super.key});

  @override
  State<MotivationalQuoteCard> createState() => _MotivationalQuoteCardState();
}

class _MotivationalQuoteCardState extends State<MotivationalQuoteCard> {
  late String _quote;

  @override
  void initState() {
    super.initState();
    _quote = _getRandomQuote();
  }

  String _getRandomQuote() {
    final random = Random();
    final index = random.nextInt(AppConstants.motivationalQuotes.length);
    return AppConstants.motivationalQuotes[index];
  }

  void _refreshQuote() {
    setState(() {
      _quote = _getRandomQuote();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(20),
      borderRadius: 20,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.format_quote,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _quote,
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Theme.of(context).colorScheme.onSurface.withAlpha(153),
              size: 20,
            ),
            onPressed: _refreshQuote,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
