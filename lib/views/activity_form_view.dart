import 'package:flutter/material.dart';
import '../viewmodels/activity_viewmodel.dart';

class ActivityFormView extends StatefulWidget {
  final ActivityViewModel viewModel;
  final int? activityId;

  const ActivityFormView({
    super.key,
    required this.viewModel,
    this.activityId,
  });

  @override
  State<ActivityFormView> createState() => _ActivityFormViewState();
}

class _ActivityFormViewState extends State<ActivityFormView> {
  static const Color primaryBerry = Color(0xFF9A005A);
  static const Color softBerry = Color(0xFFFCE7F3);

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;

  final List<String> _quickSuggestions = [
    'Olahraga',
    'Membaca Buku',
    'Mengerjakan Tugas',
    'Jogging',
    'Minum Air Putih',
  ];

  bool get isEditing => widget.activityId != null;

  @override
  void initState() {
    super.initState();
    String initialName = '';
    if (widget.activityId != null) {
      final existing = widget.viewModel.getById(widget.activityId!);
      if (existing != null) {
        initialName = existing.name;
      }
    }
    _nameController = TextEditingController(text: initialName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final inputName = _nameController.text;
    if (isEditing) {
      widget.viewModel.updateActivityName(widget.activityId!, inputName);
    } else {
      widget.viewModel.addActivity(inputName);
    }

    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Aktivitas' : 'Tambah Aktivitas'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: primaryBerry.withValues(alpha: 0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: softBerry,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            isEditing
                                ? Icons.edit_note_rounded
                                : Icons.playlist_add_rounded,
                            color: primaryBerry,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            isEditing
                                ? 'Perbarui Nama Aktivitas'
                                : 'Buat Aktivitas Baru',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: _nameController,
                      autofocus: true,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _saveForm(),
                      decoration: const InputDecoration(
                        labelText: 'Nama Aktivitas',
                        hintText: 'Contoh: Trail Run, Baca Buku',
                        prefixIcon:
                            Icon(Icons.label_outline, color: primaryBerry),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Nama aktivitas tidak boleh kosong.';
                        }
                        return null;
                      },
                    ),
                    if (!isEditing) ...[
                      const SizedBox(height: 16),
                      const Text(
                        'Ide cepat:',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _quickSuggestions.map((item) {
                          return ActionChip(
                            label: Text(item),
                            backgroundColor: softBerry,
                            labelStyle: const TextStyle(
                              color: primaryBerry,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                            side: BorderSide.none,
                            onPressed: () {
                              _nameController.text = item;
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _saveForm,
                icon: const Icon(Icons.save_rounded),
                label: const Text(
                  'Simpan Aktivitas',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}