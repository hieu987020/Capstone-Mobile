import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => outApp(context),
      child: Scaffold(
        appBar: buildAppBar(),
        drawer: AdminNavigator(
          size: size,
          selectedIndex: 'Video',
        ),
        body: MyScrollView(
          listWidget: [
            SizedBox(height: 10),
            TitleWithNothing(
              title: 'Video',
            ),
            Container(child: FilterVideo()),
            BlocBuilder<VideoBloc, VideoState>(
              builder: (context, state) {
                if (state is VideoCountingLoading) {
                  return LoadingWidget();
                } else if (state is VideoCountingLoaded) {
                  return VideoCountingContent();
                } else if (state is VideoError) {
                  return FailureStateWidget();
                }
                return SizedBox();
              },
            ),
            BlocBuilder<VideoBloc, VideoState>(
              builder: (context, state) {
                if (state is VideoEmotionLoading) {
                  return LoadingWidget();
                } else if (state is VideoEmotionLoaded) {
                  return VideoEmotionContent();
                } else if (state is VideoError) {
                  return FailureStateWidget();
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FilterVideo extends StatefulWidget {
  @override
  _FilterVideoState createState() => _FilterVideoState();
}

class _FilterVideoState extends State<FilterVideo> {
  final _type = TextEditingController(text: '1');
  final _startDate = TextEditingController(text: '');
  final _endDate = TextEditingController(text: '');
  final _selectedStore = TextEditingController(text: '');
  final _selectedShelf = TextEditingController(text: '');
  final _selectedProduct = TextEditingController(text: '');

  bool visibleCounting = true;
  bool visibleEmotion = true;
  String groupValue;

  @override
  void initState() {
    groupValue = "Counting";
    visibleCounting = true;
    visibleEmotion = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Container(
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Row(
              children: [
                SizedBox(
                  width: 150,
                  child: DateFilter(
                    hintText: "Start date",
                    controller: _startDate,
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  width: 150,
                  child: DateFilter(
                    hintText: "End date",
                    controller: _endDate,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Theme(
              data: Theme.of(context).copyWith(
                brightness: Brightness.dark,
                unselectedWidgetColor: kPrimaryColor,
                radioTheme: RadioThemeData(),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    child: ListTile(
                      title: const Text(
                        'Counting',
                        style: TextStyle(fontSize: 14),
                      ),
                      leading: Radio<String>(
                        value: "Counting",
                        groupValue: groupValue,
                        activeColor: kPrimaryColor,
                        onChanged: (String value) {
                          setState(() {
                            groupValue = value;
                            visibleCounting = true;
                            visibleEmotion = false;
                          });
                          _type.value = TextEditingValue(text: '1');
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: ListTile(
                      title: const Text(
                        'Emotion',
                        style: TextStyle(fontSize: 14),
                      ),
                      leading: Radio<String>(
                        value: "Emotion",
                        groupValue: groupValue,
                        activeColor: kPrimaryColor,
                        onChanged: (String value) {
                          setState(() {
                            groupValue = value;
                            visibleCounting = false;
                            visibleEmotion = true;
                          });
                          _type.value = TextEditingValue(text: '2');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: visibleCounting,
              child: Column(
                children: [
                  BlocBuilder<StoreBloc, StoreState>(
                    builder: (context, state) {
                      if (state is StoreLoaded) {
                        return StoreDropDown(
                          selectedStore: _selectedStore,
                          defaultStore: "",
                        );
                      }
                      return LoadingContainer();
                    },
                  ),
                  SizedBox(height: 15),
                  BlocBuilder<ShelfBloc, ShelfState>(
                    builder: (context, state) {
                      if (state is ShelfLoaded) {
                        return ShelfDropDown(
                          selectedShelf: _selectedShelf,
                          defaultShelf: "",
                        );
                      } else if (state is ShelfLoading) {
                        return LoadingWidget();
                      }
                      return SizedBox(height: 0);
                    },
                  ),
                ],
              ),
            ),
            Visibility(
              visible: visibleEmotion,
              child: Column(
                children: [
                  BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is ProductLoaded) {
                        return ProductDropDown(
                          selectedStore: _selectedProduct,
                          defaultStore: "",
                        );
                      }
                      return LoadingContainer();
                    },
                  ),
                  SizedBox(height: 15),
                  BlocBuilder<StoreBloc, StoreState>(
                    builder: (context, state) {
                      if (state is StoreLoaded) {
                        return StoreDropDown(
                          selectedStore: _selectedStore,
                          defaultStore: "",
                        );
                      }
                      return SizedBox(height: 0);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            PrimaryButton(
              text: 'Search',
              onPressed: () {
                print(_selectedStore.text);
                if (_selectedStore.text.isEmpty) {
                  BlocProvider.of<VideoBloc>(context).add(VideoFetchEvent(
                    dateStart: "",
                    dateEnd: "",
                    videoType: int.parse(_type.text),
                    storeId: "all",
                    shelfId: "all",
                    productId: "all",
                  ));
                  return;
                }
                String startDate = "";
                String endDate = "";
                if (_startDate.text.isNotEmpty) {
                  startDate = _startDate.text + "+00:00:00";
                }
                if (_endDate.text.isNotEmpty) {
                  endDate = _endDate.text + "+23:59:59";
                }
                BlocProvider.of<VideoBloc>(context).add(VideoFetchEvent(
                  dateStart: startDate,
                  dateEnd: endDate,
                  videoType: int.parse(_type.text),
                  storeId: _selectedStore.text,
                  shelfId: _selectedShelf.text,
                  productId: _selectedProduct.text,
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class VideoCountingContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Store> stores = [];
    var state = BlocProvider.of<VideoBloc>(context).state;
    if (state is VideoCountingLoaded) {
      stores = state.stores;
    }
    List<Store> listStore = [];
    if (stores != null) {
      listStore = stores;
    }
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: FutureBuilder<List<Store>>(
          initialData: listStore,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Store> storeLst = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: storeLst.length,
                itemBuilder: (context, storeIndex) {
                  List<Shelf> listShelves = storeLst[storeIndex].shelves;
                  return Container(
                    child: Column(
                      children: [
                        TitleWithColor(
                          title: "Store: " + storeLst[storeIndex].storeName,
                          color: kPrimaryColor.withOpacity(0.2),
                        ),
                        SizedBox(height: 5),
                        FutureBuilder<List<Shelf>>(
                          initialData: listShelves,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Shelf> shelfLst = snapshot.data;
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: shelfLst.length,
                                itemBuilder: (context, shelfIndex) {
                                  List<Video> listVideos =
                                      shelfLst[shelfIndex].videos;
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: TitleWithColor(
                                          title: "Shelf: " +
                                              shelfLst[shelfIndex].shelfName,
                                          color: Colors.green.withOpacity(0.2),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      FutureBuilder<List<Video>>(
                                        initialData: listVideos,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            List<Video> videoLst =
                                                snapshot.data;

                                            return ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: videoLst.length,
                                                itemBuilder: (context, index) {
                                                  return CountingVideoListInkWell(
                                                    model: 'video',
                                                    index:
                                                        (index + 1).toString(),
                                                    title: videoLst[index]
                                                        .videoName,
                                                    sub: "Start Date: " +
                                                        videoLst[index]
                                                            .startedTime,
                                                    three: "End Date: " +
                                                        videoLst[index]
                                                            .endedTime,
                                                    four: "Upload Time: " +
                                                        videoLst[index]
                                                            .updatedTime,
                                                    five: "Total people: " +
                                                            videoLst[index]
                                                                .hotspot
                                                                .totalPeople
                                                                .toString() ??
                                                        "",
                                                    status: "",
                                                    navigationField:
                                                        videoLst[index]
                                                            .videoName,
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    VideoApp(
                                                                      video: videoLst[
                                                                          index],
                                                                    )),
                                                      );
                                                    },
                                                  );
                                                });
                                          } else if (snapshot.data == null ||
                                              snapshot.data.isEmpty) {
                                            return NoRecordWidget();
                                          } else if (snapshot.error) {
                                            return ErrorRecordWidget();
                                          }
                                          return LoadingWidget();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else if (snapshot.data == null ||
                                snapshot.data.isEmpty) {
                            } else if (snapshot.hasError) {}
                            return LoadingWidget();
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.data == null || snapshot.data.isEmpty) {
              return NoRecordWidget();
            } else if (snapshot.hasError) {
              return ErrorRecordWidget();
            }
            return LoadingContainer();
          },
        ),
      ),
    );
  }
}

class VideoEmotionContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Store> stores = [];
    var state = BlocProvider.of<VideoBloc>(context).state;
    if (state is VideoEmotionLoaded) {
      stores = state.stores;
    }
    List<Store> listStore = [];
    listStore = stores;
    if (listStore == null) {
      return NoRecordWidget();
    }
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: FutureBuilder<List<Store>>(
          initialData: listStore,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Store> storeLst = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: storeLst.length,
                itemBuilder: (context, storeIndex) {
                  List<Video> listVideo = storeLst[storeIndex].videos;
                  return Container(
                    child: Column(
                      children: [
                        TitleWithColor(
                          title: "Store: " + storeLst[storeIndex].storeName,
                          color: Colors.red.withOpacity(0.2),
                        ),
                        SizedBox(height: 5),
                        FutureBuilder<List<Video>>(
                          initialData: listVideo,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Video> videoLst = snapshot.data;
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: videoLst.length,
                                itemBuilder: (context, index) {
                                  return CountingVideoListInkWell(
                                    model: 'video',
                                    index: index.toString(),
                                    title: videoLst[index].videoName,
                                    sub: "Start Date: " +
                                        videoLst[index].startedTime,
                                    three: "End Date: " +
                                        videoLst[index].endedTime,
                                    four: "Upload Time: " +
                                        videoLst[index].updatedTime,
                                    five: "Happy Emotion: " +
                                            videoLst[index]
                                                .emotion
                                                .happy
                                                .toString() ??
                                        "",
                                    status: "",
                                    navigationField: videoLst[index].videoName,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => VideoApp(
                                                  video: videoLst[index],
                                                )),
                                      );
                                    },
                                  );
                                },
                              );
                            } else if (snapshot.data == null ||
                                snapshot.data.isEmpty) {
                              return NoRecordWidget();
                            } else if (snapshot.hasError) {
                              return ErrorRecordWidget();
                            }
                            return LoadingWidget();
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.data == null || snapshot.data.isEmpty) {
              return NoRecordWidget();
            } else if (snapshot.hasError) {
              return ErrorRecordWidget();
            }
            return LoadingContainer();
          },
        ),
      ),
    );
  }
}
