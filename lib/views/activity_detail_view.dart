import 'package:flutter/material.dart';
import '../viewmodels/activity_viewmodel.dart';
import 'activity_form_view.dart';

class ActivityDetailView extends StatelessWidget {
  final ActivityViewModel viewModel;
  final int activityId;
  final void Function(String message)? onShowSnackBar;

  const ActivityDetailView({
    super.key,
    required this.viewModel,
    required this.activityId,
    this.onShowSnackBar,
  });

  static const Color primaryBerry = Color(0xFF9A005A);
  static const Color deepBerry = Color(0xFF5E0036);
  static const Color softBerry = Color(0xFFFCE7F3);

  void _notifySnackBar(BuildContext context, String message) {
    if (onShowSnackBar != null) {
      onShowSnackBar!(message);
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: deepBerry,
            behavior: SnackBarBehavior.floating,
          ),
        );
    }
  }

  Future<void> _editName(BuildContext context) async {
    final updated = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => ActivityFormView(
          viewModel: viewModel,
          activityId: activityId,
        ),
      ),
    );

    if (updated == true && context.mounted) {
      _notifySnackBar(context, 'Nama aktivitas berhasil diubah.');
    }
  }

  Future<void> _confirmReset(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text('Konfirmasi Reset'),
          content: const Text(
            'Apakah Anda yakin ingin mengembalikan nilai counter menjadi 0?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Ya, Reset'),
            ),
          ],
        );
      },
    );

    if (confirmed == true && context.mounted) {
      viewModel.reset(activityId);
      _notifySnackBar(context, 'Nilai counter di-reset menjadi 0.');
    }
  }

  Future<void> _confirmDelete(BuildContext context, String activityName) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text('Konfirmasi Hapus'),
          content: Text(
            'Apakah Anda yakin ingin menghapus aktivitas "$activityName"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (confirmed == true && context.mounted) {
      viewModel.deleteActivity(activityId);
      Navigator.pop(context);
      _notifySnackBar(context, 'Aktivitas "$activityName" berhasil dihapus.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: viewModel,
      builder: (context, _) {
        final activity = viewModel.getById(activityId);

        if (activity == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Detail Aktivitas')),
            body: const Center(
              child: Text('Aktivitas tidak ditemukan.'),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Detail Aktivitas'),
            actions: [
              IconButton(
                tooltip: 'Ubah Nama',
                icon: const Icon(Icons.edit_rounded),
                onPressed: () => _editName(context),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 28,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [primaryBerry, deepBerry],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: primaryBerry.withValues(alpha: 0.28),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'AKTIVITAS TERPILIH',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            activity.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 22),
                          Container(
                            width: 128,
                            height: 128,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.15),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                '${activity.counter}',
                                style: const TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: primaryBerry,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Total Hitungan Saat Ini',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 68,
                          height: 68,
                          child: ElevatedButton(
                            onPressed: activity.counter > 0
                                ? () {
                                    final changed =
                                        viewModel.decrement(activity.id);
                                    if (changed) {
                                      _notifySnackBar(
                                        context,
                                        'Counter berkurang menjadi ${activity.counter - 1}.',
                                      );
                                    }
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: softBerry,
                              foregroundColor: primaryBerry,
                              disabledBackgroundColor: Colors.grey.shade300,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            child: const Icon(Icons.remove_rounded, size: 34),
                          ),
                        ),
                        const SizedBox(width: 28),
                        SizedBox(
                          width: 68,
                          height: 68,
                          child: ElevatedButton(
                            onPressed: () {
                              viewModel.increment(activity.id);
                              _notifySnackBar(
                                context,
                                'Counter bertambah menjadi ${activity.counter + 1}.',
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryBerry,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            child: const Icon(Icons.add_rounded, size: 34),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    OutlinedButton.icon(
                      onPressed: () => _confirmReset(context),
                      icon: const Icon(Icons.restart_alt_rounded),
                      label: const Text('Reset Counter ke 0'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryBerry,
                        side: const BorderSide(color: primaryBerry),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _confirmDelete(context, activity.name),
                    icon: const Icon(Icons.delete_outline_rounded),
                    label: const Text(
                      'Hapus Aktivitas',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}