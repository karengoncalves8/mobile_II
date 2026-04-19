import 'package:personal_diary/utils/formatter.dart';

class DiaryEntry {
    final DateTime dateTime;
    final String content;
    
    DiaryEntry({
        required this.dateTime,
        required this.content,
    });

    String get formattedDate => normalizeDateTime(dateTime);
}