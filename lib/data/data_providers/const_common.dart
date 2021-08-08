import 'dart:convert';

import 'package:capstone/data/models/models.dart';

class UrlBase {
  static const String baseUrl = "http://35.198.194.159:9091";
}

class StatusStringAuth {
  static const String Admin = "Admin";
  static const String Manager = "Manager";
}

class StatusIntBase {
  static const int All = 0;
  static const int Active = 1;
  static const int Inactive = 2;
  static const int Pending = 3;
}

class StatusStringBase {
  static const String All = "All";
  static const String Active = "Active";
  static const String Inactive = "Inactive";
  static const String Pending = "Pending";
}

class GenderStringBase {
  static const String Female = 'Female';
  static const String Male = 'Male';
}

class GenderIntBase {
  static const int Male = 0;
  static const int Female = 1;
}

class SearchFieldBase {
  static const String Default = "";
  static const String UserName = "userName";
}

class SearchValueBase {
  static const String Default = "";
}

class PageNumBase {
  static const int Default = 0;
}

class FetchNextBase {
  static const int Default = 0;
}

String parseJsonToMessage(String input) {
  var result = jsonDecode(input);
  ErrorMessage errorMess = ErrorMessage.fromJson(result);

  if (errorMess == null) {
    return "Something wrong";
  } else {
    String message = "";
    errorMess.listMess.forEach((element) {
      message += element.message;
      message += "\n";
    });
    return message;
  }
}

class ErrorCodeAndMessage {
  static const String errorCodeAndMessage = "errorCodeAndMsg";

  static const String MSG001 = "Username is required";
  static const String MSG002 = "Password is required";
  static const String MSG003 = "Invalid username or password";
  static const String MSG004 = "Old password is required";
  static const String MSG005 = "New password is required";
  static const String MSG006 = "Retype password is required";
  static const String MSG007 =
      "New password and retype password must be matched";
  static const String MSG008 =
      "The password must be must contain :\n- At least one digit [0-9].\n- At least one lowercase Latin character [a-z].\n- At least one uppercase Latin character [A-Z].\n- At least one special character like ! @ # & ( ).\n- At least 8 characters and a maximum of 20 characters.";
  static const String MSG009 = "No data";
  static const String MSG010 = "No data";
  static const String MSG011 = "No data";
  static const String MSG012 = "This shelf doesn't exist";
  static const String MSG013 = "Updating process is successful";
  static const String MSG014 = "The name is required";
  static const String MSG015 = "The fullname is between 1 to 100 characters";
  static const String MSG016 = "The description is required";
  static const String MSG017 = "The description is between 1 to 250 characters";
  static const String MSG018 = "The shelf's maximum of stack is required";
  static const String MSG019 =
      "The shelf's maximum of stack is between 1 to 30 stacks";
  static const String MSG020 = "This camera doesn't exist";
  static const String MSG021 = "Deleting process is successful";
  static const String MSG022 = "This stack doesn't exist";
  static const String MSG023 = "This product doesn't exist";
  static const String MSG024 = "The camera id is required.";
  static const String MSG025 = "This shelf is full";
  static const String MSG026 = "Image is required";
  static const String MSG027 = "The image must be png, jpg, jpeg format";
  static const String MSG028 = "Category is required";
  static const String MSG029 = "Category does not exist";
  static const String MSG030 = "The RTSP string is required";
  static const String MSG031 = "The ip address is required";
  static const String MSG032 =
      "The ip address must be x.x.x.x format (x is number between 0 to 255)";
  static const String MSG033 = "The category doesn't exist";
  static const String MSG034 = "The name already exist";
  static const String MSG035 = "The store doesn't exist";
  static const String MSG036 = "Address is required";
  static const String MSG037 = "Address is between 1 to 250 characters";
  static const String MSG038 = "City is required";
  static const String MSG039 = "District is required";
  static const String MSG041 = "The manager doesn't exist";
  static const String MSG042 = "Phone is between 10 to 13 digits";
  static const String MSG043 = "Manager already exists";
  static const String MSG044 = "Email is required";
  static const String MSG045 = "Email is wrong format";
  static const String MSG046 = "Status doesn't exist";
  static const String MSG047 = "Birthdate is required";
  static const String MSG048 = "Birthdate is invalid";
  static const String MSG049 = "Phone is required";
  static const String MSG051 = "Identity card is required";
  static const String MSG052 = "Identity card includes from 9 to 12 digits";
  static const String MSG053 = "Password is wrong";
  static const String MSG054 = "Gender is required.";
  static const String MSG055 = "Email is exist.";
  static const String MSG056 = "Identify card is exist";
  static const String MSG057 = "IPAddress is exist";
  static const String MSG058 = "RTSPString is exist";
  static const String MSG059 = "CategoryName is exist";
  static const String MSG060 = "ProductName is exist";
  static const String MSG061 = "ShelfName is exist";
  static const String MSG062 = "StoreName is exist";
  static const String MSG063 = "The manager does not found.";
  static const String MSG064 = "Create manager successfully.";
  static const String MSG065 = "This status is not exist.";
  static const String MSG066 =
      "Changing status must be followed by business rules:\n- Pending status can be changed to be inactive status if it has an inactive reason.\n- Inactive status only changing to be pending status and mappings are inactive.";
  static const String MSG067 =
      "Inactive reason must be from 1 to 250 characters.";
  static const String MSG068 = "The old password is not correct.";
  static const String MSG069 = "StoreID is required.";
  static const String MSG070 = "Analyzed time is required.";
  static const String MSG071 = "ShelfId is required.";
  static const String MSG072 = "Time must be format (hh:mm:ss)";
  static const String MSG073 =
      "BirthDate must be follow by format yyyy-MM-dd HH:mm:ss";
  static const String MSG074 = "Manager is not available.";
  static const String MSG075 = "Store is not available.";
  static const String MSG076 = "System can not finish this action.";
  static const String MSG077 = "Store and manager is not mapping.";
  static const String MSG078 = "Stack ID is required.";
  static const String MSG079 = "Shelf name is required.";
  static const String MSG080 = "Shelf name must be from 1 to 100 characters.";
  static const String MSG081 = "Store contain shelves active or pending.";
  static const String MSG082 = "Camera name is required.";
  static const String MSG083 = "Camera name must be from 1 to 100 characters.";
  static const String MSG084 = "TypeDetect is not exist.";
  static const String MSG085 = "Shelf must be exist and not active.";
  static const String MSG086 = "Camera must be exist and not active.";
  static const String MSG087 = "Camera or Shelf is not available.";
  static const String MSG088 = "Shelf and Camera is not mapping.";
  static const String MSG089 = "Product is not active.";
  static const String MSG090 = "Stack is already active or inactive.";
  static const String MSG091 = "Stack is already have a product.";
  static const String MSG092 =
      "Product and stack is not mapping or stack already have camera.";
  static const String MSG093 = "Camera is already active or inactive.";
  static const String MSG094 = "Camera and stack is not mapping.";
  static const String MSG095 = "Stack contain product.";
  static const String MSG096 = "Product ID is required.";
  static const String MSG097 = "Have stack contain this product.";
  static const String MSG098 =
      "Changing status product must be followed by business rules:\n- Active status can be changed to be inactive status if it has an inactive reason, and no any stack contain it.\n";
  static const String MSG099 = "Product name is required.";
  static const String MSG100 = "Stack much contain product.";
  static const String MSG101 = "Stack already active.";
  static const String MSG102 = "Catelogy is required.";
  static const String MSG103 =
      "Catelogy list at least 1 item, and maximum is 3.";
  static const String MSG104 = "Catelogy list contain invalid id.";
  static const String MSG105 = "Catelogy name is required.";
  static const String MSG106 = "Store name is required.";
  static const String MSG107 = "Store address is required.";
  static const String MSG108 = "Store analyzed time is required.";
  static const String MSG109 = "This category is being used.";
  static const String MSG110 =
      "Changing status category must be followed by business rules:\n- Active status can be changed to be inactive status if it has no product using it.\n";
  static const String MSG111 = "System have some problem. Please try later.";
  static const String MSG112 = "Please select a image.";
  static const String MSG113 = "jpg/jpeg/png file types are supported.";
  static const String MSG114 =
      "System could not create the directory where the uploaded files will be stored in server. Please try later.";
}
