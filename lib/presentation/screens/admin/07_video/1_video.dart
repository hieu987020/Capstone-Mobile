import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final _controller = VideoPlayerController.network(
    //   'https://storage.googleapis.com/capstone_storeage/videos/bdfe8984-d8ff-44c3-91f4-55f0d63d86b9-20210701-031548.mp4',
    // );

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
            HeaderWithSearchBox(
              size: size,
              title: "Hi Admin",
            ),
            TitleWithNothing(
              title: 'Video',
            ),
            FilterVideo(),
          ],
        ),
      ),
    );
  }
}

class FilterVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _type = TextEditingController(text: 'Counter');
    var _startDate = TextEditingController();
    var _endDate = TextEditingController();
    var _selectedStore = TextEditingController();
    var _selectedShelf = TextEditingController();

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
            CameraTypeRatio(controller: _type, defaultValue: 'Counter'),
            (_type.text == 'Counter')
                ? Column(
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
                          }
                          return SizedBox(height: 0);
                        },
                      ),
                    ],
                  )
                : Column(
                    children: [
                      BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                          if (state is ProductLoaded) {
                            return ProductDropDown(
                              selectedStore: _selectedStore,
                              defaultStore: "",
                            );
                          }
                          return LoadingContainer();
                        },
                      ),
                      SizedBox(height: 15),
                      // BlocBuilder<ShelfBloc, ShelfState>(
                      //   builder: (context, state) {
                      //     if (state is ShelfLoaded) {
                      //       return ShelfDropDown(
                      //         selectedShelf: selectedShelf,
                      //         defaultShelf: "",
                      //       );
                      //     }
                      //     return SizedBox(height: 0);
                      //   },
                      // ),
                    ],
                  ),

            // "videoUrl" : "https://storage.googleapis.com/download/storage/v1/b/capstone_storeage/o/videos%2Fdd198a40-2f61-468f-b06d-5863e9eeb6cf-20210803-034126.mp4?generation=1627962110819448&alt=media",
          ],
        ),
      ),
    );
  }
}
