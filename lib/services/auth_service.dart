import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutternew/api.dart';
import 'package:flutternew/api_execption.dart';




class AuthService {


static  final dio = Dio();



static  Future<Either<String, bool>> userLogin(
      {required String email, required String password}) async {
    try {
        final response = await dio.post(Api.userLogin, data: {
          'email': email,
          'password': password
        });
      return Right(true);

    } on DioError catch (err) {
      return Left(DioException.getErrorText(err));
    }
  }


static  Future<Either<String, bool>> userSignUp(
    {
      required String email,
      required String password,
      required String fullname,
    }) async {
  try {
    final response = await dio.post(Api.userSignUp, data: {
      'email': email,
      'password': password,
      'fullname': fullname
    });
    return Right(true);
  } on DioError catch (err) {
    return Left(DioException.getErrorText(err));
  }
}




}
