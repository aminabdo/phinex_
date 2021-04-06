import 'package:flutter/material.dart';
import 'package:phinex/utils/app_localization.dart';

class MyMultiSelectDialogItem<V> {
  const MyMultiSelectDialogItem(this.value, this.label);

  final V value;
  final String label;
}

class MyMultiSelectDialog<V> extends StatefulWidget {
  MyMultiSelectDialog({Key key, this.items, this.initialSelectedValues})
      : super(key: key);

  final List<MyMultiSelectDialogItem<V>> items;
  final Set<V> initialSelectedValues;

  @override
  State<StatefulWidget> createState() => _MyMultiSelectDialogState<V>();
}

class _MyMultiSelectDialogState<V> extends State<MyMultiSelectDialog<V>> {
  final _selectedValues = Set<V>();

  void initState() {
    super.initState();
    if (widget.initialSelectedValues != null) {
      _selectedValues.addAll(widget.initialSelectedValues);
    }
  }

  void _onItemCheckedChange(V itemValue, bool checked) {
    setState(() {
      if (checked) {
        _selectedValues.add(itemValue);
      } else {
        _selectedValues.remove(itemValue);
      }
    });
  }

  void _onCancelTap() {
    Navigator.pop(context);
  }

  void _onSubmitTap() {
    Navigator.pop(context, _selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppLocalization.of(context).translate('working_days'),
      ),
      contentPadding: EdgeInsets.only(top: 12.0),
      content: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: EdgeInsets.fromLTRB(14.0, 0.0, 24.0, 0.0),
          child: ListBody(
            children: widget.items.map(_buildItem).toList(),
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('CANCEL'),
          onPressed: _onCancelTap,
        ),
        FlatButton(
          child: Text('OK'),
          onPressed: _onSubmitTap,
        )
      ],
    );
  }

  Widget _buildItem(MyMultiSelectDialogItem<V> item) {
    final checked = _selectedValues.contains(item.value);
    return CheckboxListTile(
      value: checked,
      title: Text(item.label),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (checked) => _onItemCheckedChange(item.value, checked),
    );
  }
}

/**
 *  Example
 * 
  void _showMultiSelect(BuildContext context) async {
  final items = <MultiSelectDialogItem<int>>[
    MultiSelectDialogItem(1, 'Dog'),
    MultiSelectDialogItem(2, 'Cat'),
    MultiSelectDialogItem(3, 'Mouse'),
  ];

  final selectedValues = await showDialog<Set<int>>(
    context: context,
    builder: (BuildContext context) {
      return MultiSelectDialog(
        items: items,
        initialSelectedValues: [1, 3].toSet(),
      );
    },
  );

  print(selectedValues);
}
 * 
 */
