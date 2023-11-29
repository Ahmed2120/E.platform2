import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSession{

  static String getURL(){
    return 'http://educationplat22-001-site1.etempurl.com';
  }

  static List<int> priviliges = [];
  static String? userRole ;
  // String? get userRole => _userRole ;

    static void CreateSession(access_token,token_type,expires_in,phoneNumber,userId, name,
                profilePicture,userRole,issued,expires, wallet, priviliges) async{
      final SharedPreferences  session = await SharedPreferences.getInstance();
            session.setString('access_token', access_token);
            session.setString('token_type', token_type);
            session.setInt('expires_in', expires_in);
            session.setString('phoneNumber', phoneNumber);
            session.setString('userId', userId);
            session.setString('name', name);
            session.setString('profilePicture', getURL() + profilePicture);
            session.setString('userRole', userRole);
            session.setString('issued', issued);
            session.setString('expires', expires);
           // session.setString('name', name);
            session.setString('wallet', wallet);
            session.setString('priviliges', priviliges);

      // UserSession().splitPriviliges(priviliges);

    }

    static Future<Map> GetData()async{
      final SharedPreferences  session = await SharedPreferences.getInstance();

      Map session_map={
        'access_token':session.getString('access_token')!,
        'token_type':session.getString('token_type')!,
        'expires_in':session.getInt('expires_in')!,
        'phoneNumber':session.getString('phoneNumber')!,
        'userId':session.getString('userId')!,
        'name':session.getString('name')!,
        'profilePicture':session.getString('profilePicture')!,
        'userRole':session.getString('userRole')!,
        'issued':session.getString('issued')!,
        'expires':session.getString('expires')!,
      //  'name':session.getString('name')!,
        'wallet':session.getString('wallet')!,
        'priviliges':session.getString('priviliges')!,
      };

      setUserRole(session.getString('userRole')!);
      splitPriviliges(session.getString('priviliges')!);

      return session_map;
    }

     static void loginRemember(bool remember,String phone, String password) async{
    final SharedPreferences  session = await SharedPreferences.getInstance();
     session.setBool('remember', remember);
     session.setString('phone', phone);
     session.setString('password', password);

  }
    static Future<Map>  getLoginRemember() async{

    final SharedPreferences  session = await SharedPreferences.getInstance();

     Map login_map={
      'remember':session.getBool('remember')==null?false:session.getBool('remember'),
      'phone':session.getString('phone'),
      'password':session.getString('password'),
    };
    return  login_map;

  }


  static setUserRole(String role){
    userRole = role;
  }

  static splitPriviliges(String priviligesTxt){
    if(priviligesTxt.isEmpty) return;
    List x = priviligesTxt.split(',');

    for(var i in x){
      if(int.tryParse(i) != null){
        priviliges.add(int.parse(i));
      }
    }
  }

  static bool hasPrivilege(int num){

      if(userRole == '2') return true;

    for(var i in priviliges){
      if(i == num){
        return true;
      }
    }
    return false;
  }

}