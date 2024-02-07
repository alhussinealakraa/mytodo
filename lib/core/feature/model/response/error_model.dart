
class ErrorModel{
  ErrorModel(
      {this.errorMessage, });

  ErrorModel.fromJson(Map<String, dynamic> parsedJson){
    errorMessage = parsedJson['message'];
  }


  String? errorMessage;

}