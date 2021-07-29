import 'dart:io';

import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UpdateImage extends StatefulWidget {
  final String model;
  UpdateImage({this.model});
  @override
  _UpdateImageState createState() => _UpdateImageState(model: model);
}

class _UpdateImageState extends State<UpdateImage> {
  final String model;
  _UpdateImageState({this.model});

  File _image;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
      child: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: getImage,
                child: _image == null
                    ? Container(
                        height: 36,
                        width: 100,
                        child: ElevatedButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: kPrimaryColor.withOpacity(0.6),
                          ),
                          onPressed: getImage,
                          child: Icon(
                            Icons.add_a_photo,
                          ),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          height: 200.0,
                          width: 200.0,
                          decoration: BoxDecoration(
                            color: kPrimaryColor.withOpacity(0.3),
                          ),
                          child: Container(
                            height: 80,
                            child: Image.file(
                              _image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
          Container(
            child: _image == null
                ? Text("")
                : Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: PrimaryButton(
                      text: 'Save',
                      onPressed: () {
                        if (model == 'user') {
                          var user;
                          var state =
                              BlocProvider.of<UserDetailBloc>(context).state;
                          if (state is UserDetailLoaded) {
                            user = User(
                              userName: state.user.userName,
                              fullName: state.user.fullName,
                              phone: state.user.phone,
                              address: state.user.address,
                              birthDate: state.user.birthDate + " 0:0:0",
                              districtId: state.user.districtId,
                              email: state.user.email,
                              gender: state.user.gender,
                              identifyCard: state.user.identifyCard,
                              imageURL: state.user.imageURL,
                            );
                          }
                          BlocProvider.of<UserUpdateImageBloc>(context)
                              .add(UserUpdateImageSubmit(user, _image));
                        } else if (model == 'store') {
                          var store;
                          var state =
                              BlocProvider.of<StoreDetailBloc>(context).state;
                          if (state is StoreDetailLoaded) {
                            store = Store(
                              storeId: state.store.storeId,
                              storeName: state.store.storeName,
                              address: state.store.address,
                              districtId: state.store.districtId,
                              imageUrl: state.store.imageUrl,
                            );
                          }
                          BlocProvider.of<StoreUpdateImageBloc>(context)
                              .add(StoreUpdateImageSubmit(store, _image));
                        } else if (model == 'product') {
                          var product;
                          var state =
                              BlocProvider.of<ProductDetailBloc>(context).state;
                          if (state is ProductDetailLoaded) {
                            product = Product(
                              productId: state.product.productId,
                              productName: state.product.productName,
                              description: state.product.description,
                              imageUrl: state.product.imageUrl,
                            );
                            BlocProvider.of<ProductUpdateImageBloc>(context)
                                .add(ProductUpdateImageSubmit(product, _image));
                          }
                        } else if (model == 'camera') {
                          var camera;
                          var state =
                              BlocProvider.of<CameraDetailBloc>(context).state;
                          if (state is CameraDetailLoaded) {
                            camera = Camera(
                              cameraId: state.camera.cameraId,
                              cameraName: state.camera.cameraName,
                              macAddress: state.camera.macAddress,
                              ipAddress: state.camera.ipAddress,
                              rtspString: state.camera.rtspString,
                              imageUrl: state.camera.imageUrl,
                            );
                            BlocProvider.of<CameraUpdateImageBloc>(context)
                                .add(CameraUpdateImageSubmit(camera, _image));
                          }
                        }
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
