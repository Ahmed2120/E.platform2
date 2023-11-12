import 'package:eplatform/model/privateGroup/privateGroupModel.dart';
import 'package:eplatform/model/subject/subModel.dart';
import 'package:eplatform/model/teacherModels/customTeacherModels.dart';
import 'package:scoped_model/scoped_model.dart';
import 'CountryModel.dart';
import 'ads/adsModel.dart';
import 'assistant/assistantModel.dart';
import 'exam/examModel.dart';
import 'group/groupDetailsModel.dart';
import 'homework/homeWorkModel.dart';
import 'profile/changePasswordModel.dart';
import 'chat/groupChatMessagesModel.dart';
import 'chat/singleChatMessagesModel.dart';
import 'chat/teachers_groupChatModel.dart';
import 'courses/courseModel.dart';
import 'degree/degreeModel.dart';
import 'group/groupsModel.dart';
import 'home/homeModel.dart';
import 'note/noteModel.dart';
import 'question/question_model.dart';
import 'schedule/scheduleModel.dart';
import 'studentSubscriptionsModel.dart';
import 'group/addGroupCommentAndRateModel.dart';
import 'loginModel.dart';
import 'teacher/allTeacherModel.dart';
import 'teacherModels/createdTeacherCoursesModel.dart';
import 'teacherModels/teacherCreatedGroupModel.dart';
import 'teacherModels/teacherExamModel.dart';
import 'teacherModels/teacherGroupSessionsANDStudentModel.dart';
import 'teacherModels/teacherHomeModel.dart';
import 'teacherModels/teacherNoteModel.dart';
import 'teacherModels/teacherSubModel.dart';
import 'teacherModels/teacher_examDetails_model.dart';
import 'updateProfileModel.dart';
import 'wallet/wallet_model.dart';

class MainModel extends Model with CountryModel,SubModel,
    LoginModel,
    AddGroupVideoCommentModel ,StudentSubscriptionsModel,DegreeModel,
    PrivateGroupModel,TeachersToChatModel,SingleChatMessagesModel,
    TeacherGroupsModel,GroupChatMessagesModel, NoteModel ,CourseModel, ChangePasswordModel,
    HomeModel,AllTeacherModel, ScheduleModel,HomeWorkModel, UpdateProfileModel , GroupDetailsModel,
    ExamModel,TeacherHomeModel,TeacherSubModel,CustomTeacherModels,TeacherCreatedNoteModel,
    TeacherCreatedGroupModel, CreatedTeacherCoursesModel,TeacherExamModel,
    TeacherGroupSessionsANDStudentModel, TeacherExamDetailsModel, QuestionModel,
    AssistantModel, AdvertisingModel, WalletModel
{

}

