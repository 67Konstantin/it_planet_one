  import '/exports.dart';

  class SecondScreen extends StatefulWidget {
    const SecondScreen({Key? key}) : super(key: key);

    @override
    State<SecondScreen> createState() => _SecondScreenState();
  }

  class _SecondScreenState extends State<SecondScreen> {
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
              // ElevatedButton(onPressed: (){changeTheme(context);}, child: Text('поменять тему'))
              CustomButton(
              text: "Поменять тему",
              onPressed: () {
                changeTheme(context);
                _incrementCounter();
              },
              textStyle: TextStyle(
                fontSize: 24,
              ),
            ),
            ],
          ),
        ),
        
      );
    }
  }