import 'package:path_provider_example/exports/exports.dart';

class PathProviderExample extends StatefulWidget {
  const PathProviderExample({Key? key}) : super(key: key);

  @override
  _PathProviderExampleState createState() => _PathProviderExampleState();
}

class _PathProviderExampleState extends State<PathProviderExample> {
  final _textController = TextEditingController();

  Future<String> get _getFolderLocationPath async {
    Directory papka = await getApplicationDocumentsDirectory();
    debugPrint("Folder Path: " + papka.path.toString());
    return papka.path;
  }

  Future get _createFileToSystemUsingFolderFunctionUpon async {
    var yozilganFaylPathi = await _getFolderLocationPath;
    return File(yozilganFaylPathi + '/meningFayl.txt');
  }

  Future<String> _faylniOqi() async {
    try {
      File myData = await _createFileToSystemUsingFolderFunctionUpon;
      String dataFromFile = await myData.readAsString();
      return dataFromFile;
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> _faylgaYoz(String yoziladiganText) async {
    File myData = await _createFileToSystemUsingFolderFunctionUpon;
    return myData.writeAsString(yoziladiganText);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Work With Provider",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 4,
                controller: _textController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Bu Yerda Yozilganlar Faylga Saqlanadi"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: _saveToSystem,
                  child: const Text("Save Text"),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  onPressed: _readFromFileSystem,
                  child: const Text("Write Text"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _saveToSystem() {
    _faylgaYoz(_textController.text);
  }

  void _readFromFileSystem() {
    _faylniOqi().then((value) => debugPrint(value.toString()));
  }
}
