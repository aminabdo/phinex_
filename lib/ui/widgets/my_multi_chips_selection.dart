
import 'package:flutter/material.dart';
import 'package:phinex/utils/consts.dart';

class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final Function(List<String>) onSelectionChanged;
  final List<String> selectedChoices;

  MultiSelectChip(this.reportList, {this.onSelectionChanged, @required this.selectedChoices});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<String> selectedChoices = List();

  @override
  initState() {
    super.initState();

    this.selectedChoices = widget.selectedChoices;
  }

  _buildChoiceList() {
    List<Widget> choices = List();
    widget.reportList.forEach(
          (item) {
        choices.add(
          Container(
            padding: EdgeInsets.all(4.0),
            child: ChoiceChip(
              label: Text(item),
              elevation: 2,
              avatar: selectedChoices.contains(item)
                  ? Icon(
                Icons.cancel_rounded,
                color: deepBlueColor,
                size: 22,
              )
                  : null,
              padding: EdgeInsets.all(4.0),
              selected: selectedChoices.contains(item),
              selectedColor: mainColor.withOpacity(.1),
              backgroundColor: Colors.grey[100],
              labelStyle: TextStyle(
                color:
                selectedChoices.contains(item) ? mainColor : Colors.black,
              ),
              onSelected: (selected) {
                setState(
                      () {
                    selectedChoices.contains(item)
                        ? selectedChoices.remove(item)
                        : selectedChoices.add(item);
                  },
                );
                widget.onSelectionChanged(selectedChoices);
              },
            ),
          ),
        );
      },
    );
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
