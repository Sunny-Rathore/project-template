import 'package:flutter/material.dart';

import '../core/app_export.dart';
import '../data/models/selection_popup_model.dart';

class SearchableMultiSelectDialog extends StatefulWidget {
  final List<SelectionPopupModel> items;
  final List<SelectionPopupModel> selectedItems;
  final Function(List<SelectionPopupModel>) onSelectionChanged;
  final String hint;
  const SearchableMultiSelectDialog({
    super.key,
    required this.items,
    required this.selectedItems,
    required this.onSelectionChanged,
    required this.hint,
  });

  @override
  State<SearchableMultiSelectDialog> createState() => _SearchableMultiSelectDialogState();
}

class _SearchableMultiSelectDialogState extends State<SearchableMultiSelectDialog> {
  late List<SelectionPopupModel> _filteredItems;
  late List<SelectionPopupModel> _selectedItems;

  @override
  void initState() {
    super.initState();
    _filteredItems = [...widget.items];
    _selectedItems = [...widget.selectedItems];
  }

  void _filterItems(String query) {
    setState(() {
      _filteredItems = widget.items.where((item) => item.title.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AlertDialog(
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.h)),
      backgroundColor: Colors.white,
      title: Text(widget.hint, style: textTheme.headlineSmall!),
      content: SizedBox(
        height: SizeUtils.height * 0.5,
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFormField(hintText: 'Search...', onChanged: _filterItems),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredItems.length,
                itemBuilder: (context, index) {
                  final item = _filteredItems[index];
                  return CheckboxListTile(
                    activeColor: appTheme.primary,
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    title: Text(item.title, style: textTheme.bodySmall!.copyWith(fontSize: 17.fSize)),
                    value: _selectedItems.contains(item),
                    onChanged: (bool? value) {
                      setState(() {
                        if (_selectedItems.contains(item)) {
                          _selectedItems.remove(item);
                        } else {
                          _selectedItems.add(item);
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel', style: textTheme.bodySmall),
        ),
        TextButton(
          onPressed: () {
            widget.onSelectionChanged(_selectedItems);
            Navigator.pop(context);
          },
          child: Text('OK', style: textTheme.titleMedium!.copyWith(color: appTheme.primary)),
        ),
      ],
    );
  }
}
