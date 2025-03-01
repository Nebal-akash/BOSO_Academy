import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DateTime _selectedDay = DateTime.now();
  Map<DateTime, List<Map<String, dynamic>>> _events = {};

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  void _fetchEvents() async {
    _firestore.collection('events').snapshots().listen((snapshot) {
      Map<DateTime, List<Map<String, dynamic>>> newEvents = {};
      for (var doc in snapshot.docs) {
        DateTime date = (doc['date'] as Timestamp).toDate();
        date = DateTime(date.year, date.month, date.day);
        if (newEvents[date] == null) newEvents[date] = [];
        newEvents[date]?.add({'id': doc.id, 'title': doc['title'], 'color': doc['color']});
      }
      setState(() {
        _events = newEvents;
      });
    });
  }

  void _addEvent(String title, Color color) {
    _firestore.collection('events').add({
      'title': title,
      'date': _selectedDay,
      'color': color.value.toString(),
    });
  }

  void _deleteEvent(String id) {
    _firestore.collection('events').doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Year ${_selectedDay.year}",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: _showAddEventDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(12, (index) {
            DateTime monthStart = DateTime(_selectedDay.year, index + 1, 1);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    DateFormat('MMMM yyyy').format(monthStart),
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                _buildMonthGrid(monthStart),
                _buildEventList(monthStart),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildMonthGrid(DateTime monthStart) {
    int daysInMonth = DateTime(monthStart.year, monthStart.month + 1, 0).day;
    int startDay = monthStart.weekday;
    return GridView.builder(
      padding: EdgeInsets.all(8),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: daysInMonth + startDay,
      itemBuilder: (context, index) {
        if (index < startDay) {
          return Container();
        }
        DateTime day = DateTime(monthStart.year, monthStart.month, index - startDay + 1);
        bool hasEvent = _events[day] != null && _events[day]!.isNotEmpty;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedDay = day;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: hasEvent ? Colors.deepPurpleAccent : Colors.white10,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              '${index - startDay + 1}',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEventList(DateTime month) {
    List<DateTime> eventDays = _events.keys.where((date) => date.month == month.month).toList();
    return Container(
      color: Colors.black,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Events for ${DateFormat('MMMM yyyy').format(month)}",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          eventDays.isEmpty
              ? Text("No Events", style: TextStyle(color: Colors.white54))
              : Column(
            children: eventDays.map((day) {
              List<Map<String, dynamic>> events = _events[day] ?? [];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('MMMM d').format(day),
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  ...events.map((event) => Card(
                    color: Color(int.parse(event['color'])),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(event['title'], style: TextStyle(color: Colors.white)),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.white),
                        onPressed: () => _deleteEvent(event['id']),
                      ),
                    ),
                  )).toList(),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _showAddEventDialog() {
    String eventText = "";
    Color selectedColor = Colors.blue;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text("Add Event", style: TextStyle(color: Colors.white)),
        content: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter event name",
            hintStyle: TextStyle(color: Colors.white54),
            filled: true,
            fillColor: Colors.white10,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onChanged: (value) => eventText = value,
        ),
        actions: [
          TextButton(child: Text("Cancel", style: TextStyle(color: Colors.redAccent)), onPressed: () => Navigator.pop(context)),
          TextButton(child: Text("Save", style: TextStyle(color: Colors.deepPurpleAccent)), onPressed: () { if (eventText.isNotEmpty) _addEvent(eventText, selectedColor); Navigator.pop(context); })
        ],
      ),
    );
  }
}
