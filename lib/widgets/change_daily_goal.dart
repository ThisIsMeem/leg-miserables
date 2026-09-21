import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<int?> showChangeGoalDialog(BuildContext context) {
  return showDialog<int>(
    context: context,
    builder: (_) => const ChangeGoalDialog(),
  );
}

class ChangeGoalDialog extends StatefulWidget {
  const ChangeGoalDialog({super.key});

  @override
  State<ChangeGoalDialog> createState() => _ChangeGoalDialogState();
}

class _ChangeGoalDialogState extends State<ChangeGoalDialog> {
  final TextEditingController _controller = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final value = int.tryParse(_controller.text);
    if (value == null || value <= 0) {
      setState(() => _error = 'Enter a number greater than 0');
      return;
    }
    Navigator.of(context).pop(value);
  }

  @override
  Widget build(BuildContext context) {
    const squareButton = RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
    );
    final buttonStyle = OutlinedButton.styleFrom(
      shape: squareButton,
      foregroundColor: Colors.black,
      side: const BorderSide(width: 2),
      padding: const EdgeInsets.symmetric(vertical: 14),
    );

    return Dialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(width: 4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Change Goal', style: Theme.of(context).textTheme.titleLarge),
            const Divider(thickness: 2, color: Colors.black),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              autofocus: true,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
              decoration: InputDecoration(
                hintText: 'insert num here',
                errorText: _error,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              onChanged: (_) {
                if (_error != null) setState(() => _error = null);
              },
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: buttonStyle,
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    style: buttonStyle,
                    onPressed: _submit,
                    child: const Text('OK'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
