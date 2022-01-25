import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mitro/utils/style.dart';

class DefaultDateTimePicker extends StatefulWidget {

  final String? text;
  final double? width;
  final Color? textColor;
  final double? fontSize;
  final bool isTimePicked;
  final DateTime? defaultDate;
  final TimeOfDay? defaultTime;
  final Color? buttonColor;
  final double borderRadius;
  final EdgeInsets padding;
  final Function(String? value, int? timestamp) onChanged;

  const DefaultDateTimePicker({
    Key? key,
    required this.text,
    this.defaultDate,
    this.defaultTime,
    this.fontSize = 18,
    this.borderRadius = 5,
    required this.onChanged,
    this.isTimePicked = true,
    this.width = double.infinity,
    this.textColor = Colors.white,
    this.buttonColor = kPrimaryColor,
    this.padding = const EdgeInsets.fromLTRB(20, 8, 20, 8),
  }) : super(key: key);

  @override
  State<DefaultDateTimePicker> createState() => _DefaultDateTimePickerState();
}

class _DefaultDateTimePickerState extends State<DefaultDateTimePicker> {
  String? _selectedDateTime;

  @override
  void didChangeDependencies() {
    if(widget.isTimePicked && widget.defaultDate != null && widget.defaultTime != null) {
      _selectedDateTime = "${DateFormat("dd/MM/yyyy").format(widget.defaultDate!)}  ${widget.defaultTime!.format(context)}";
    } else if(widget.defaultDate != null) {
      _selectedDateTime = DateFormat("dd/MM/yyyy").format(widget.defaultDate!);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 0, left: 16, right: 16,),
        child: TextField(
          readOnly: true,
          autofocus: true,
          controller: TextEditingController(text: _selectedDateTime),
          decoration: InputDecoration(
            labelText: widget.text?.tr() ?? "",
            hintText: widget.isTimePicked ? "DD/MM/YYYY HH:MM A" : "DD/MM/YYYY",
            contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
            // suffixIcon: const Icon(Icons.date_range),
          ),
          onTap: () => _showDateTimePicker(),
        ),
      ),
    );
  }

  Future<void> _showDateTimePicker() async {
    DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (datePicked != null) {
      if(widget.isTimePicked) {
        final TimeOfDay? timePicked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute),
        );

        if (timePicked != null) {
          setState(() {
            datePicked =  datePicked!.add(Duration(hours: timePicked.hour, minutes: timePicked.minute));
            _selectedDateTime = "${DateFormat("dd/MM/yyyy").format(datePicked!)}  ${timePicked.format(context)}";
            widget.onChanged(_selectedDateTime, datePicked!.millisecondsSinceEpoch ~/ 1000);
          });
        }
      } else {
        setState(() {
          _selectedDateTime = DateFormat("dd/MM/yyyy").format(datePicked!);
          widget.onChanged(_selectedDateTime, datePicked!.millisecondsSinceEpoch ~/ 1000);
        });
      }
    }
  }
}
