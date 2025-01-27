  import '/exports.dart';

  class TimeTableScreen extends StatefulWidget {
    const TimeTableScreen({Key? key}) : super(key: key);

    @override
    State<TimeTableScreen> createState() => _TimeTableScreenState();
  }

  class _TimeTableScreenState extends State<TimeTableScreen> {
    int _counter = 0;

    void _incrementCounter() {
      setState(() {
        _counter++;
      });
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: MediaQuery.of(context).padding.top * 0.0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Вы нажали на кнопку: ',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              ElevatedButton(onPressed: (){changeTheme(context);}, child: Text('поменять тему'))
              
            ],
          ),
        ),
        
      );
    }
  }