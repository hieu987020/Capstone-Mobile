import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/const_common.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenCategoryCreate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CategoryCreateBloc>(context)
        .add(CategoryCreateInitialEvent());
    return Scaffold(
      appBar: buildNormalAppbar('Create Category'),
      resizeToAvoidBottomInset: false,
      body: BlocListener<CategoryCreateBloc, CategoryCreateState>(
        listener: (context, state) {
          if (state is CategoryCreateLoaded) {
            _categoryCreateLoaded(context, state);
          } else if (state is CategoryCreateError) {
            _categoryCreateError(context, state);
          } else if (state is CategoryCreateLoading) {
            loadingCommon(context);
          } else if (state is CategoryCreateDuplicatedName) {
            Navigator.of(context).pop();
          }
        },
        child: MyScrollView(
          listWidget: [
            CategoryCreateForm(),
          ],
        ),
      ),
    );
  }
}

_categoryCreateLoaded(BuildContext context, CategoryCreateLoaded state) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ScreenCategory()),
  );
  BlocProvider.of<CategoryBloc>(context).add(CategoryFetchEvent(
    searchValue: "",
    searchField: "",
    fetchNext: 100,
    pageNum: 0,
    statusId: 0,
  ));
  BlocProvider.of<CategoryCreateBloc>(context)
      .add(CategoryCreateInitialEvent());
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("Create Successfully"),
    duration: Duration(milliseconds: 2000),
  ));
}

_categoryCreateError(BuildContext context, CategoryCreateError state) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Create Error'),
        content: Text(state.message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Back'),
          ),
        ],
      );
    },
  );
}

class CategoryCreateForm extends StatefulWidget {
  @override
  CategoryCreateFormState createState() {
    return CategoryCreateFormState();
  }
}

class CategoryCreateFormState extends State<CategoryCreateForm> {
  final _formKey = GlobalKey<FormState>();
  final _categoryName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              CategoryTextField(
                hintText: "Category Name",
                controller: _categoryName,
              ),
              BlocBuilder<CategoryCreateBloc, CategoryCreateState>(
                builder: (context, state) {
                  if (state is CategoryCreateDuplicatedName) {
                    return DuplicateField(state.message);
                  }
                  return SizedBox(height: 0);
                },
              ),
              SizedBox(height: 15.0),
              PrimaryButton(
                text: "Create",
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Category _cate = new Category(
                      categoryName: _categoryName.text,
                    );
                    BlocProvider.of<CategoryCreateBloc>(context)
                        .add(CategoryCreateSubmitEvent(_cate));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
