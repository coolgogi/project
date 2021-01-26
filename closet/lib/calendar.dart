import 'package:flutter/material.dart';
import 'package:cell_calendar/cell_calendar.dart';
import 'sample_event.dart';

class Calendar extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final _sampleEvents = sampleEvents();

    return Scaffold(
      appBar: AppBar(
        title: Text('calendar'),
      ),
      body: CellCalendar(
        events: _sampleEvents,
        daysOfTheWeekBuilder: (dayIndex) {
          final labels = ["S", "M", "T", "W", "T", "F", "S"];
          return Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              labels[dayIndex],
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          );
        },
        monthYearLabelBuilder: (datetime) {
          final year = datetime.year.toString();
          final month = datetime.month.toString();
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "$month, $year",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
        onCellTapped: (date) {
          final eventsOnTheDate = _sampleEvents.where((event) {
            final eventDate = event.eventDate;
            return eventDate.year == date.year &&
                eventDate.month == date.month &&
                eventDate.day == date.day;
          }).toList();
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title:
                Text(date.month.monthName + " " + date.day.toString()),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: eventsOnTheDate
                      .map(
                        (event) => Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(4),
                      margin: EdgeInsets.only(bottom: 12),
                      color: event.eventBackgroundColor,
                      child: Text(
                        event.eventName,
                        style: TextStyle(color: event.eventTextColor),
                      ),
                    ),
                  )
                      .toList(),
                ),
              ));
        },
        onPageChanged: (firstDate, lastDate) {
          /// Called when the page was changed
          /// Fetch additional events by using the range between [firstDate] and [lastDate] if you want
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}