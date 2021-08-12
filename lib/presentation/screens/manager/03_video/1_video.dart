import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenVideoManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => outApp(context),
      child: Scaffold(
        appBar: buildAppBar(),
        drawer: ManagerNavigator(
          size: size,
          selectedIndex: 'Video',
        ),
        body: MyScrollView(
          listWidget: [
            SizedBox(height: 10),
            TitleWithNothing(
              title: 'Video',
            ),
            Container(child: FilterVideoM()),
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

class FilterVideoM extends StatefulWidget {
  @override
  _FilterVideoMState createState() => _FilterVideoMState();
}

class _FilterVideoMState extends State<FilterVideoM> {
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
                ],
              ),
            ),
            SizedBox(height: 15),
            PrimaryButton(
              text: 'Search',
              onPressed: () {
                String startDate = "";
                String endDate = "";
                if (_startDate.text.isNotEmpty) {
                  startDate = _startDate.text + "+00:00:00";
                }
                if (_endDate.text.isNotEmpty) {
                  endDate = _endDate.text + "+23:59:59";
                }
                BlocProvider.of<VideoBloc>(context).add(VideoFetchEventManager(
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
