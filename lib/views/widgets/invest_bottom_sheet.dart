import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InvestBottomSheet extends StatefulWidget {
  const InvestBottomSheet({super.key, required this.onSuccess});

  final VoidCallback onSuccess;

  @override
  State<InvestBottomSheet> createState() => _InvestBottomSheetState();
}

class _InvestBottomSheetState extends State<InvestBottomSheet> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  bool get _isValid {
    final amount = int.tryParse(_ctrl.text);
    return amount != null && amount >= 100;
  }

  void _confirm() {
    Navigator.of(context).pop();
    widget.onSuccess();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Invest',
            style: tt.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _ctrl,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              labelText: 'Amount',
              prefixText: '₹  ',
              hintText: 'Min. ₹100',
              border: const OutlineInputBorder(),
              suffixText: '.00',
              suffixStyle: TextStyle(color: cs.onSurfaceVariant),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Minimum investment amount is ₹100',
            style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _isValid ? _confirm : null,
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(50)),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
