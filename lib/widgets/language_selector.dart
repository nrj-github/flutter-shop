import 'package:flutter/material.dart';
import '../models/language_model.dart';
import '../utils/constants.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  Language selectedLanguage = Language.defaultLanguage;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Language>(
      onSelected: (lang) {
        setState(() => selectedLanguage = lang);
      },
      itemBuilder: (context) {
        return Language.languages.map((lang) {
          return PopupMenuItem<Language>(
            value: lang,
            child: Row(
              children: [
                Text(lang.flag, style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 12),
                Text(lang.name, style: const TextStyle(fontSize: 14)),
              ],
            ),
          );
        }).toList();
      },
      child: const Icon(
        Icons.keyboard_arrow_down,
        size: 22,
        color: AppColors.textDark,
      ),
    );
  }
}
