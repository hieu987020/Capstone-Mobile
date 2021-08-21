import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenCategoryUpdateInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildNormalAppbar('Update Category'),
      body: BlocListener<CategoryUpdateBloc, CategoryUpdateState>(
        listener: (context, state) {
          if (state is CategoryUpdateLoaded) {
            _categoryUpdateLoaded(context, state);
          } else if (state is CategoryUpdateError) {
            _categoryUpdateError(context, state);
          } else if (state is CategoryUpdateLoading) {
            _categoryUpdateLoading(context);
          } else if (state is CategoryUpdateDuplicatedName) {
            Navigator.of(context).pop();
          }
        },
        child: MyScrollView(
          listWidget: [CategoryUpdateForm()],
        ),
      ),
    );
  }
}

_categoryUpdateLoaded(BuildContext context, CategoryUpdateLoaded state) {
  int cameraId;
  var cameraDetailState = BlocProvider.of<CategoryDetailBloc>(context).state;
  if (cameraDetailState is CategoryDetailLoaded) {
    cameraId = cameraDetailState.category.categoryId;
  }
  BlocProvider.of<CategoryDetailBloc>(context)
      .add(CategoryDetailFetchEvent(cameraId));
  Navigator.pop(context);
  Navigator.pop(context);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("Update Successfully"),
    duration: Duration(milliseconds: 2000),
  ));
}

_categoryUpdateError(BuildContext context, CategoryUpdateError state) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Update Error'),
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

_categoryUpdateLoading(BuildContext context) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return LoadingDialog();
    },
  );
}

class CategoryUpdateForm extends StatefulWidget {
  @override
  CategoryUpdateFormState createState() {
    return CategoryUpdateFormState();
  }
}

class CategoryUpdateFormState extends State<CategoryUpdateForm> {
  @override
  Widget build(BuildContext context) {
    var state = BlocProvider.of<CategoryDetailBloc>(context).state;
    Category cate;
    if (state is CategoryDetailLoaded) {
      cate = state.category;
    }

    final _formKey = GlobalKey<FormState>();
    final TextEditingController _categoryName =
        TextEditingController(text: cate.categoryName);

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
                text: "Save",
                onPressed: () {
                  CategoryUpdateBloc categoryUpdateBloc =
                      BlocProvider.of<CategoryUpdateBloc>(context);
                  if (_formKey.currentState.validate()) {
                    Category _category = new Category(
                      categoryId: cate.categoryId,
                      categoryName: _categoryName.text,
                    );
                    categoryUpdateBloc.add(CategoryUpdateSubmit(_category));
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
