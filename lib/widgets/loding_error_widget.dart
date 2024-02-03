import 'package:flutter/material.dart';

class ProgressIndicatorBubble extends StatefulWidget {
  const ProgressIndicatorBubble({
    Key? key,
  });

  @override
  State<ProgressIndicatorBubble> createState() => _ProgressIndicatorState();
}

class _ProgressIndicatorState extends State<ProgressIndicatorBubble>
    with TickerProviderStateMixin {
  late AnimationController controller;

  double sent = 0.0;
  double total = 1000.0;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 500),
    )..addListener(() {
        setState(() {});
      });
    super.initState();

    // Эмуляция загрузки файла
    _simulateFileUpload();
  }

  // Эмуляция загрузки файла
  Future<void> _simulateFileUpload() async {
    const totalSize =
        1000; // Задайте общий размер файла, который вы хотите загрузить
    const chunkSize =
        50; // Задайте размер порции данных, которые отправляются за один раз

    // final double targetSent = totalSize.toDouble();

    while (sent < totalSize) {
      await Future.delayed(const Duration(milliseconds: 600));

      sent += chunkSize;
      if (sent > totalSize) {
        sent = totalSize.toDouble();
      }

      setState(() {});
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = total > 0 ? sent / total : 0;

    return LinearProgressIndicator(
      value: progress,
      backgroundColor: Colors.grey,
    );
  }
}
