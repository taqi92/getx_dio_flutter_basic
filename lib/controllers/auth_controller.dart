import 'package:get/get.dart';
import 'package:mitro/models/responses/common/common_response.dart';
import 'package:mitro/models/responses/login/login_response.dart';
import 'package:mitro/network/repositories/auth_repository.dart';
import 'package:mitro/utils/constants.dart';
import 'package:mitro/utils/shared_pref.dart';


class AuthController extends GetxController {
  late final AuthRepository _authRepository;

  @override
  void onInit() {
    _authRepository = AuthRepository();
    super.onInit();
  }

  CommonResponse? legalDoc;
  String? resetPasswordSecret;

  final loginEmailObs = Rxn<String?>();
  final loginPasswordObs = Rxn<String?>();

  final nameObs = Rxn<String?>();
  final userTypeObs = Rxn<String?>();
  final signUpEmailObs = Rxn<String?>();
  final signUpPasswordObs = Rxn<String?>();

  final resetPasswordObs = Rxn<String?>();
  final resetPasswordOtpObs = Rxn<String?>();
  final forgotPasswordEmailObs = Rxn<String?>();

  void login() {
    loading();

    var request = {
      "email": loginEmailObs.value,
      "password": loginPasswordObs.value
    };

    _authRepository.login(request, (response, error) {
      if(response != null) {
        _saveUserInfoLocally(response.payload);
      } else {
       showMessage(error);
      }
    });
  }

  Future<void> _saveUserInfoLocally(LoginPayload? payload) async {
    try {
      /*var user = payload?.user;

      await SharedPref.write(keyUserId, "${user?.id}");
      await SharedPref.write(keyUserName, user?.name);
      await SharedPref.write(keyJwtToken, payload?.accessToken);
      await SharedPref.write(keyUserType, user?.roles?[0].roleType);
      await SharedPref.write(keyRefreshToken, payload?.refreshToken);
      //await subscribeUnSubscribeTopicToFirebase(user?.id);*/

      showMessage("Successfully Login", isToast: true);
      //Get.offAll(() => const HomeScreen(), transition: sendTransition);
    } catch (e) {
      showMessage(e.toString());
    }
  }

  void signUp() {
    loading();

    var request = {
      "name": nameObs.value,
      "email": signUpEmailObs.value,
      "password": signUpPasswordObs.value
    };

    _authRepository.signUp(request, (response, error) async {
      if(response != null) {
        showMessage(response.message, isToast: true);
        await Future.delayed(const Duration(seconds: 3));
        Get.back();
      } else {
        showMessage(error);
      }
    });
  }

  void forgotPassword({bool isResendCode = false}) {
    loading();

    var request = {
      "userEmail": forgotPasswordEmailObs.value
    };

    _authRepository.forgotPassword(request, (response, error) async {
      if(response != null) {
        showMessage(response.message, isToast: true);
        await Future.delayed(const Duration(seconds: 3));
        Get.back();
      } else {
        showMessage(error);
      }
    });
  }

  void getLegalDocs(String url) {
    loading();
    legalDoc = null;

    _authRepository.getLegalDocs(url, (response, error) {
      if(response != null) {
        legalDoc = response;
        update();
      } else {
        showMessage(error);
      }
    });
  }
}
