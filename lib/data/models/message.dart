import 'package:equatable/equatable.dart';

class ErrorMessage extends Equatable {
  final List<MessageError> listMess;
  ErrorMessage({this.listMess});
  @override
  List<Object> get props => [listMess];

  @override
  bool get stringify => true;

  factory ErrorMessage.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> listMessJson = json["errorCodeAndMsg"];
    List<MessageError> listMess = List<MessageError>.empty(growable: true);
    listMessJson.forEach((key, value) {
      listMess.add(new MessageError(code: key, message: value));
    });
    return new ErrorMessage(listMess: listMess);
  }
}

class MessageError extends Equatable {
  final String code;
  final String message;

  MessageError({
    this.code,
    this.message,
  });

  @override
  List<Object> get props => [code, message];

  @override
  bool get stringify => true;
}
