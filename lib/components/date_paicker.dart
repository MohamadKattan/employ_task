// this dailoge for pick date
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/mixin.dart';
import '../controller/state_mangment.dart';

//this widget for cuptuer data of stat and end
Widget datePicker(BuildContext context) {
  return Container(
    margin: const EdgeInsets.all(12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 40 / 100,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(4.0)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              dailogePickDate(isStartdate: true, context: context),
              Consumer<EmployeeStateMangment>(
                builder: (_, val, child) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      val.startDate == ''
                          ? 'Today'
                          : ' ${val.startDate ?? 'Today'}',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const Icon(
          Icons.arrow_forward_outlined,
          color: Colors.green,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 40 / 100,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(4.0)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dailogePickDate(isStartdate: false, context: context),
              Consumer<EmployeeStateMangment>(
                builder: (_, val, child) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      val.endDate == '' ? 'No date' : val.endDate ?? 'No date',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

//this  dailoge date picker
Widget dailogePickDate(
    {required bool isStartdate, required BuildContext context}) {
  const dayTextStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.w700);
  final weekendTextStyle =
      TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w600);
  final anniversaryTextStyle = TextStyle(
    color: Colors.red[400],
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.underline,
  );
  final config = CalendarDatePicker2WithActionButtonsConfig(
    dayTextStyle: dayTextStyle,
    calendarType: CalendarDatePicker2Type.range,
    selectedDayHighlightColor: Colors.blue,
    yearTextStyle: const TextStyle(
      color: Color.fromARGB(255, 50, 41, 41),
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
    closeDialogOnCancelTapped: true,
    firstDayOfWeek: 1,
    weekdayLabelTextStyle: const TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.bold,
    ),
    controlsTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
    centerAlignModePicker: true,
    customModePickerIcon: const SizedBox(),
    selectedDayTextStyle: dayTextStyle.copyWith(color: Colors.white),
    dayTextStylePredicate: ({required date}) {
      TextStyle? textStyle;
      if (date.weekday == DateTime.saturday ||
          date.weekday == DateTime.sunday) {
        textStyle = weekendTextStyle;
      }
      if (DateUtils.isSameDay(date, DateTime(2021, 1, 25))) {
        textStyle = anniversaryTextStyle;
      }
      return textStyle;
    },
    dayBuilder: ({
      required date,
      textStyle,
      decoration,
      isSelected,
      isDisabled,
      isToday,
    }) {
      Widget? dayWidget;
      if (date.day % 3 == 0 && date.day % 9 != 0) {
        dayWidget = Container(
          decoration: decoration,
          child: Center(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Text(
                  MaterialLocalizations.of(context).formatDecimal(date.day),
                  style: textStyle,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 27.5),
                  child: Container(
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:
                          isSelected == true ? Colors.white : Colors.grey[500],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return dayWidget;
    },
    yearBuilder: ({
      required year,
      decoration,
      isCurrentYear,
      isDisabled,
      isSelected,
      textStyle,
    }) {
      return Center(
        child: Container(
          decoration: decoration,
          height: 36,
          width: 72,
          child: Center(
            child: Semantics(
              selected: isSelected,
              button: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    year.toString(),
                    style: textStyle,
                  ),
                  if (isCurrentYear == true)
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(left: 5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.redAccent,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
  return IconButton(
      onPressed: () async {
        final values = await showCalendarDatePicker2Dialog(
          context: context,
          config: config,
          dialogSize: const Size(325, 400),
          borderRadius: BorderRadius.circular(15),
          value: context.read<EmployeeStateMangment>().listOfDate,
          dialogBackgroundColor: Colors.white,
        );
        if (values != null) {
          if (isStartdate) {
            if (context.mounted) {
              context
                  .read<EmployeeStateMangment>()
                  .updateStartDate(formatDate(values));
            }
          } else {
            if (context.mounted) {
              context
                  .read<EmployeeStateMangment>()
                  .updateEndDATE(formatDate(values));
            }
          }
          if (context.mounted) {
            context.read<EmployeeStateMangment>().updateListOfDate(values);
          }
        }
      },
      icon: const Icon(
        Icons.date_range,
        color: Colors.blue,
      ));
}
