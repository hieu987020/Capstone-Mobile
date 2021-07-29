import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenCategory extends StatelessWidget {
  const ScreenCategory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return Scaffold(
      appBar: buildAppBar(),
      drawer: AdminNavigator(
        size: size,
        selectedIndex: 'Category',
      ),
      floatingActionButton: AddFloatingButton(
        onPressed: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => ScreenCategoryCreate()));
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                HeaderWithSearchBox(size),
                TitleWithMoreBtn(
                  title: 'List Categories',
                  model: 'category',
                ),
                BlocBuilder<CategoryBloc, CategoryState>(
                  // ignore: missing_return
                  builder: (context, state) {
                    if (state is CategoryLoaded) {
                      return CategoryContent();
                    } else if (state is CategoryError) {
                      return FailureStateWidget();
                    } else if (state is CategoryLoading) {
                      return LoadingWidget();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Category> categories;
    var state = BlocProvider.of<CategoryBloc>(context).state;
    if (state is CategoryLoaded) {
      categories = state.categories;
    }

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: FutureBuilder<List<Category>>(
          initialData: categories,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Category> cameraLst = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: cameraLst.length,
                itemBuilder: (context, index) {
                  return ObjectListInkWell(
                    model: 'camera',
                    imageURL:
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Solid_black.svg/1024px-Solid_black.svg.png',
                    title: cameraLst[index].categoryName,
                    sub: cameraLst[index].categoryName,
                    status: cameraLst[index].statusName,
                    navigationField: cameraLst[index].categoryName,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => ScreenCategoryDetail()),
                      // );
                      // BlocProvider.of<CategoryDetailBloc>(context).add(
                      //     CategoryDetailFetchEvent(cameraLst[index].cameraId));
                    },
                  );
                },
              );
            } else if (snapshot.data == null) {
              return NoRecordWidget();
            } else if (snapshot.hasError) {
              return Text("No Record: ${snapshot.error}");
            }
            return LoadingWidget();
          },
        ),
      ),
    );
  }
}
