import 'package:attendence_list/domain/entities/attendance_person.dart';
import 'package:attendence_list/domain/repositories/attendance_repository.dart';
import 'package:attendence_list/presentation/controllers/attendance_controller.dart';
import 'package:attendence_list/presentation/widgets/attendance_empty_state.dart';
import 'package:attendence_list/presentation/widgets/attendance_list_item.dart';
import 'package:attendence_list/presentation/widgets/attendance_summary_card.dart';
import 'package:attendence_list/presentation/widgets/person_input_section.dart';
import 'package:flutter/material.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key, required this.repository});

  final AttendanceRepository repository;

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  late final AttendanceController _controller;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AttendanceController(repository: widget.repository);
    _controller.addListener(_onControllerChanged);
    _controller.loadPeople();
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    final message = _controller.errorMessage;
    if (message == null || !mounted) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
    _controller.clearError();
  }

  Future<void> _onAddPerson() async {
    final wasSaved = await _controller.addPerson(_nameController.text);
    if (wasSaved) {
      _nameController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance List')),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, _) {
            if (_controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final isWide = constraints.maxWidth >= 900;

                final formAndSummary = Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    PersonInputSection(
                      controller: _nameController,
                      onAdd: _onAddPerson,
                    ),
                    const SizedBox(height: 12),
                    AttendanceSummaryCard(
                      total: _controller.people.length,
                      present: _controller.presentCount,
                    ),
                  ],
                );

                final listSection = _buildPeopleList();

                if (isWide) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 360, child: formAndSummary),
                        const SizedBox(width: 16),
                        Expanded(child: listSection),
                      ],
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      formAndSummary,
                      const SizedBox(height: 12),
                      Expanded(child: listSection),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildPeopleList() {
    if (_controller.people.isEmpty) {
      return const AttendanceEmptyState();
    }

    return Card(
      child: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: _controller.people.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (BuildContext context, int index) {
          final AttendancePerson person = _controller.people[index];
          return AttendanceListItem(
            person: person,
            onChanged: (bool isPresent) =>
                _controller.togglePresence(person, isPresent),
            onDelete: () => _controller.removePerson(person.id),
          );
        },
      ),
    );
  }
}
