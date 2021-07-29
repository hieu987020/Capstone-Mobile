import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenStore extends StatelessWidget {
  const ScreenStore({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return Scaffold(
      appBar: buildAppBar(),
      drawer: AdminNavigator(
        size: size,
        selectedIndex: 'Store',
      ),
      floatingActionButton: AddFloatingButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ScreenStoreCreate()));
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
                  title: 'List Stores',
                  model: 'store',
                ),
                BlocBuilder<StoreBloc, StoreState>(
                  // ignore: missing_return
                  builder: (context, state) {
                    if (state is StoreLoaded) {
                      return StoreContent();
                    } else if (state is StoreError) {
                      return FailureStateWidget();
                    } else if (state is StoreLoading) {
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

class StoreContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Store> stores;
    var state = BlocProvider.of<StoreBloc>(context).state;
    if (state is StoreLoaded) {
      stores = state.stores;
    }

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: FutureBuilder<List<Store>>(
          initialData: stores,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Store> storeLst = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: storeLst.length,
                itemBuilder: (context, index) {
                  return ObjectListInkWell(
                    model: 'store',
                    imageURL: storeLst[index].imageUrl,
                    title: storeLst[index].storeName,
                    sub: storeLst[index].managerUsername ?? "-",
                    status: storeLst[index].statusName,
                    navigationField: storeLst[index].storeId,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScreenStoreDetail()),
                      );
                      BlocProvider.of<StoreDetailBloc>(context)
                          .add(StoreDetailFetchEvent(storeLst[index].storeId));
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
