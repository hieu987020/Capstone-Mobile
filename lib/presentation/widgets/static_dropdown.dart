import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/business_logic/bloc/city/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StaticDropDown extends StatefulWidget {
  final TextEditingController controller;
  final String defaultCity;
  final String defaultDistrict;
  StaticDropDown(
      {@required this.controller, this.defaultCity, this.defaultDistrict});

  @override
  _StaticDropDownState createState() =>
      _StaticDropDownState(controller, defaultCity, defaultDistrict);
}

class _StaticDropDownState extends State<StaticDropDown> {
  final TextEditingController controller;
  final String defaultCity;
  final String defaultDistrict;
  _StaticDropDownState(this.controller, this.defaultCity, this.defaultDistrict);

  List<String> countries = ['Ho Chi Minh', 'Ha Noi'];
  List<String> hcmCity = [
    'District 1',
    "District 2",
    "District 3",
    "District 4",
    "District 5",
    "District 6",
    "District 7",
    "District 8",
    "District 9",
    "District 10",
    "District 11",
    "District 12"
  ];
  List<String> hnCity = [
    'Ba Dinh District',
    "Bac Tu Liem District",
    "Cau giay District",
    "Dong Da District",
    "Ha Dong District",
    "Hai Ba Trung District",
    "Hoan Kiem District",
    "Hoan Mai District",
    "Long Bien District",
    "Nam Tu Liem District",
    "Tay Ho District",
    "Thanh Xuan District",
  ];
  List<String> dictricts = [];
  String selectedCity;
  String selectedDistrict;

  @override
  void initState() {
    if (defaultCity.isEmpty || defaultCity == null) {
    } else {
      selectedCity = defaultCity;
      if (defaultCity == 'Ho Chi Minh') {
        dictricts = hcmCity;
      } else if (defaultCity == 'Ha Noi') {
        dictricts = hnCity;
      }
      selectedDistrict = defaultDistrict;
      BlocProvider.of<CityBloc>(context).add(CityFetchEvent());
      var state = BlocProvider.of<CityBloc>(context).state;
      List<City> cities;
      if (state is CityLoaded) {
        cities = state.cities;
      }
      if (cities != null) {
        cities.forEach((city) {
          if (city.cityName == selectedCity) {
            city.listDistrict.forEach((district) {
              if (district.districtName == selectedDistrict) {
                controller.value = TextEditingValue(text: district.districtId);
              }
            });
          }
        });
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CityBloc>(context).add(CityFetchEvent());
    var state = BlocProvider.of<CityBloc>(context).state;
    List<City> cities;
    return Column(
      children: [
        // Country Dropdown
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: kPrimaryColor.withOpacity(0.4),
                spreadRadius: 0,
                blurRadius: 8,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white))),
            hint: Text(
              'Choose City',
              style: TextStyle(
                fontSize: 14.0,
                color: Color.fromRGBO(169, 176, 185, 1),
              ),
            ),
            value: selectedCity,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
            isExpanded: true,
            items: countries.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (country) {
              if (country == 'Ho Chi Minh') {
                dictricts = hcmCity;
              } else if (country == 'Ha Noi') {
                dictricts = hnCity;
              } else {
                dictricts = [];
              }
              setState(() {
                selectedDistrict = null;
                selectedCity = country;
              });
            },
          ),
        ),
        // Country Dropdown Ends here
        SizedBox(height: 15.0),
        // Province Dropdown
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: kPrimaryColor.withOpacity(0.4),
                spreadRadius: 0,
                blurRadius: 8,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white))),
            hint: Text(
              'Choose District',
              style: TextStyle(
                fontSize: 14.0,
                color: Color.fromRGBO(169, 176, 185, 1),
              ),
            ),
            value: selectedDistrict,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
            isExpanded: true,
            items: dictricts.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (district) {
              setState(() {
                selectedDistrict = district;
              });

              if (state is CityLoaded) {
                cities = state.cities;
              }
              if (cities != null) {
                cities.forEach((city) {
                  if (city.cityName == selectedCity) {
                    city.listDistrict.forEach((district) {
                      if (district.districtName == selectedDistrict) {
                        controller.value =
                            TextEditingValue(text: district.districtId);
                      }
                    });
                  }
                });
              }
            },
          ),
        ),
        // Province Dropdown Ends here
      ],
    );
  }
}

// class TypeDetectDropDown extends StatefulWidget {
//   TypeDetectDropDown({this.controller, this.defaultType});
//   final TextEditingController controller;
//   final String defaultType;

//   @override
//   _TypeDetectDropDownState createState() =>
//       _TypeDetectDropDownState(controller, defaultType);
// }

// class _TypeDetectDropDownState extends State<TypeDetectDropDown> {
//   final TextEditingController controller;
//   final String defaultType;
//   _TypeDetectDropDownState(this.controller, this.defaultType);
//   String selectedType;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 18.0),
//       width: double.infinity,
//       height: 50,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: [
//           BoxShadow(
//             color: kPrimaryColor.withOpacity(0.4),
//             spreadRadius: 0,
//             blurRadius: 8,
//             offset: Offset(0, 2), // changes position of shadow
//           ),
//         ],
//       ),
//       child: DropdownButtonFormField<String>(
//         decoration: InputDecoration(
//             enabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.white))),
//         hint: Text(
//           'Choose Type Detect',
//           style: TextStyle(
//             fontSize: 14.0,
//             color: Color.fromRGBO(169, 176, 185, 1),
//           ),
//         ),
//         value: selectedType,
//         style: TextStyle(
//           fontSize: 16.0,
//           color: Colors.black,
//         ),
//         isExpanded: true,
//         items: <String>['Hotspot', 'Emotion'].map((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Text(value),
//           );
//         }).toList(),
//         onChanged: (type) {
//           setState(() {
//             selectedType = type;
//           });
//           if (type == 'Hotspot') {
//             controller.value = TextEditingValue(text: '1');
//           } else if (type == 'Emotion') {
//             controller.value = TextEditingValue(text: '2');
//           }
//         },
//       ),
//     );
//   }
// }
