import 'package:anigami/API%20Services/APIService.dart';
import 'package:anigami/API%20Services/ResponseModel/PopularAnimeResponseModel.dart';
import 'package:flutter/material.dart';

void main() {
  // dart execution from here
  runApp(const MyApp()); // flutter execution
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<PopularAnimeResponseModel> popularAnimeResponseModel = [];
  late List<PopularAnimeResponseModel> filteredList = [];
  bool isLoading = true, showSearchBar = false;
  String searchString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: <Widget>[
          if (!showSearchBar)
            IconButton(
                alignment: Alignment.centerRight,
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                )),
          TextField(
            onChanged: (String str) {
              if (str.length == 0) {
                showSearchBar = false;
              }
              searchString = str;
              for (int i = 0; i < popularAnimeResponseModel.length; i++) {
                if (popularAnimeResponseModel[i]
                    .animeTitle
                    .contains(searchString)) {
                  filteredList.add(popularAnimeResponseModel[i]);
                }
              }
            },
          )
        ],
        elevation: 2.0,
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          "AniGami",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            )
          : Center(
              heightFactor: double.infinity,
              widthFactor: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                      child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 6,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: popularAnimeResponseModel.length,
                    itemBuilder: (BuildContext context, int count) {
                      return GestureDetector(
                          onTap: () => ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: showSearchBar? Text(filteredList[count]
                                    .animeTitle):  Text(popularAnimeResponseModel[count]
                                    .animeTitle),
                              )),
                          child: showSearchBar
                              ? singleAnimeGrid(count, filteredList)
                              : singleAnimeGrid(
                                  count, popularAnimeResponseModel));
                    },
                    shrinkWrap: true,
                  ))
                ],
              ),
            ),
    );
  }

  Widget singlePopularAnimeWidget(
      int count, List<PopularAnimeResponseModel> popularAnimeResponseModel) {
    return Expanded(
      child: ListTile(
        title: Text(
          "Anime name: ${popularAnimeResponseModel.elementAt(count).animeTitle}",
          style: TextStyle(color: Colors.white),
        ),
        iconColor: Colors.white,
        leading: Icon(Icons.add_circle),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      callAPI();
    });
  }

  void callAPI() async {
    var response = await BaseClient().get("popular").catchError((error) {
      debugPrint(error.toString());
    });
    if (response != null) {
      setState(() {
        isLoading = false;
        popularAnimeResponseModel = popularAnimeFromJson(response);
      });
    }
  }

  Widget failureContainer() {
    return Container(
      alignment: Alignment.center,
      child: const Text(
        "Something Went wrong.... ☹",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget singleAnimeGrid(
      int count, List<PopularAnimeResponseModel> popularAnimeResponseModel) {
    return SingleChildScrollView(
      child: Card(
        color: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
            child: Column(
              children: [
                Image.network(popularAnimeResponseModel[count].animeImg),
                Text(
                  popularAnimeResponseModel[count].animeTitle,
                  style: TextStyle(color: Colors.white),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
            ),
          ),
        ),
      ),
    );
  }
}
