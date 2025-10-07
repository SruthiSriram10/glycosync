import 'package:flutter/material.dart';
import 'package:glycosync/screens/Patients/Details/controller/detail_controller.dart';

class DiabetesTypeStep extends StatefulWidget {
  final DetailController controller;
  const DiabetesTypeStep({super.key, required this.controller});

  @override
  State<DiabetesTypeStep> createState() => _DiabetesTypeStepState();
}

class _DiabetesTypeStepState extends State<DiabetesTypeStep> {
  String? _selectedType;

  final List<String> diabetesTypes = [
    'Type 1',
    'Type 2',
    'Gestational',
    'LADA',
    'MODY',
    'Prediabetes',
    'I don\'t know',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'What is your diabetes type?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: diabetesTypes.map((type) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: _buildTypeChip(context, type),
                  );
                }).toList(),
              ),
            ),
          ),
          const Spacer(),
          FloatingActionButton(
            onPressed: () {
              if (_selectedType != null) {
                widget.controller.model.diabetesType = _selectedType!;
                // *** THIS IS THE FIX: It now correctly goes to the next page ***
                widget.controller.nextPage();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please select a type.')),
                );
              }
            },
            // Icon is now an arrow
            child: const Icon(Icons.arrow_forward_ios),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTypeChip(BuildContext context, String type) {
    final bool isSelected = _selectedType == type;
    return SizedBox(
      width: double.infinity,
      child: ChoiceChip(
        label: Text(type),
        selected: isSelected,
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              _selectedType = type;
            }
          });
        },
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.white : Theme.of(context).primaryColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(
            width: 1.5,
            color: Theme.of(context).primaryColor,
          ),
        ),
        selectedColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).canvasColor,
      ),
    );
  }
}