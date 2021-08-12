import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderWithSearchBox extends StatelessWidget {
  HeaderWithSearchBox({
    @required this.size,
    @required this.title,
    @required this.valueSearch,
    @required this.onSubmitted,
    @required this.onChanged,
    @required this.onTap,
  });

  final Size size;
  final String title;
  final TextEditingController valueSearch;
  final void Function(String) onSubmitted;
  final void Function(String) onChanged;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(bottom: kDefaultPadding),
      // It will cover 20% of our total height
      height: size.height * 0.2,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
            ),
            height: size.height * 0.2 - 50,
            decoration: BoxDecoration(
              // color: kPrimaryColor,
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Container(
                    child: Image.asset(
                      "assets/images/cffe.png",
                      color: kBackgroundColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: EdgeInsets.only(
                  left: kDefaultPadding, right: kDefaultPadding, bottom: 5),
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted: onSubmitted,
                      onChanged: onChanged,
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: kPrimaryColor.withOpacity(0.5),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: SvgPicture.asset(
                      "assets/icons/search.svg",
                      color: kPrimaryColor,
                      height: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  final void Function(String) onSubmitted;
  final void Function(String) onChanged;
  final void Function() onTap;

  const SearchBox({
    @required this.onSubmitted,
    @required this.onChanged,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 4),
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: kPrimaryColor.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 8,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                textInputAction: TextInputAction.search,
                onSubmitted: onSubmitted,
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: kPrimaryColor.withOpacity(0.5),
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            GestureDetector(
              onTap: onTap,
              child: SvgPicture.asset(
                "assets/icons/search.svg",
                color: kPrimaryColor,
                height: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
