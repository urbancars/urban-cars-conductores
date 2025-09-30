import 'package:flutter/material.dart';

class RefreshableBlocPage extends StatefulWidget {
  final Widget Function(BuildContext context) builder;
  final Future<void> Function(BuildContext context) onRefresh;
  final Duration cooldown;

  const RefreshableBlocPage({
    super.key,
    required this.builder,
    required this.onRefresh,
    this.cooldown = const Duration(seconds: 60),
  });

  @override
  State<RefreshableBlocPage> createState() => _RefreshableBlocPageState();
}

class _RefreshableBlocPageState extends State<RefreshableBlocPage> {
  DateTime _lastRefresh = DateTime.fromMillisecondsSinceEpoch(0);

  Future<void> _handleRefresh(BuildContext context) async {
    final now = DateTime.now();
    if (now.difference(_lastRefresh) < widget.cooldown) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "⏳ Solo puedes actualizar cada ${widget.cooldown.inSeconds} segundos",
          ),
        ),
      );
      return;
    }
    _lastRefresh = now;
    await widget.onRefresh(context);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _handleRefresh(context),
      child: widget.builder(context),
    );
  }
}
