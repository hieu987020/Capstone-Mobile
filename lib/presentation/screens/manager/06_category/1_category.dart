import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/const_common.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenCategoryManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => outApp(context),
      child: Scaffold(
        appBar: buildAppBar(),
        drawer: ManagerNavigator(
          size: size,
          selectedIndex: 'Category',
        ),
        body: MyScrollView(
          listWidget: [
            HeaderWithSearchBox(
              size: size,
              title: "Hi Manager",
            ),
            TitleWithMoreBtn(
              title: 'Category',
              model: 'category',
              defaultStatus: StatusStringBase.All,
            ),
            BlocBuilder<CategoryBloc, CategoryState>(
              // ignore: missing_return
              builder: (context, state) {
                if (state is CategoryLoaded) {
                  return CategoryContentM();
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
    );
  }
}

class CategoryContentM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Category> categories;
    var state = BlocProvider.of<CategoryBloc>(context).state;
    if (state is CategoryLoaded) {
      categories = state.categories;
    }

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: FutureBuilder<List<Category>>(
          initialData: categories,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Category> lst = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: lst.length,
                itemBuilder: (context, index) {
                  return CategoryListInkWell(
                    model: 'camera',
                    title: lst[index].categoryName,
                    status: lst[index].statusName,
                    navigationField: lst[index].categoryName,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ScreenCategoryDetailManager()),
                      );
                      BlocProvider.of<CategoryDetailBloc>(context)
                          .add(CategoryDetailFetchEvent(lst[index].categoryId));
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
