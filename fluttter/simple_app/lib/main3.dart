import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Table Example'),
        ),
        body: const Column(
          children: [

            Expanded(
              child: MyTable(),
            ),
          ],
        ),
      ),
    );
  }
}

final List<GlobalKey> containerKeys = List.generate(7 * 13, (index) => GlobalKey());

class MyTable extends StatefulWidget {
  const MyTable({super.key});

  @override
  _MyTableState createState() => _MyTableState();

  static _MyTableState? of(BuildContext context) {
    return context.findAncestorStateOfType<_MyTableState>();
  }
}

class _MyTableState extends State<MyTable> with WidgetsBindingObserver {
  List<RenderBox?> renderBoxes = List.filled(7 * 13, null);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Понделник')),
          DataColumn(label: Text('Вторник')),
          DataColumn(label: Text('Среда')),
          DataColumn(label: Text('Четврток')),
          DataColumn(label: Text('Петок')),
        ],
        rows: List.generate(
          13,
              (rowIndex) => DataRow(
            cells: List.generate(
              5,
                  (colIndex) => DataCell(
                IntrinsicWidth(
                  child: Column(
                    children: [
                      Container(
                        key: containerKeys[rowIndex * 5 + colIndex],
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black, // Set the color of the border
                            width: 1.0, // Set the width of the border
                          ),
                        ),
                        child: Text('Cell $rowIndex-$colIndex'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    // Populate renderBoxes after the build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (int i = 0; i < containerKeys.length; i++) {
        renderBoxes[i] = containerKeys[i].currentContext?.findRenderObject() as RenderBox?;
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Populate renderBoxes after the build
      for (int i = 0; i < containerKeys.length; i++) {
        renderBoxes[i] = containerKeys[i].currentContext?.findRenderObject() as RenderBox?;
      }
    });
  }

  void updateTableState(RenderBox renderBox) {
    setState(() {
      print(renderBox);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
