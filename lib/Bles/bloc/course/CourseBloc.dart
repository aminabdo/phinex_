import 'package:rxdart/rxdart.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/requests/jobs/JobAddRequest.dart';
import 'package:phinex/Bles/Model/responses/course/CourseCatResponse.dart';
import 'package:phinex/Bles/Model/responses/course/CourseSingleResponse.dart';
import 'package:phinex/Bles/Model/responses/course/CoursesByCatResponse.dart';
import 'package:phinex/utils/base/BaseBloc.dart';
import 'package:phinex/utils/base/BaseRequest.dart';

import '../../ApiRoutes.dart';

class CourseBloc extends BaseBloc {
  BehaviorSubject<CourseCatResponse> _cats = BehaviorSubject<CourseCatResponse>();

  BehaviorSubject<CoursesByCatResponse> _landing =
  BehaviorSubject<CoursesByCatResponse>();

  BehaviorSubject<CoursesByCatResponse> _coursesByCat =
  BehaviorSubject<CoursesByCatResponse>();

  BehaviorSubject<CourseSingleResponse> _single =
  BehaviorSubject<CourseSingleResponse>();

  getCats() async {
    CourseCatResponse response;
    response = CourseCatResponse.fromMap(
      await (await repository.get(ApiRoutes.courseCategory())).data,
    );
    _cats.value = response;
  }

  getLanding(int count) async {
    loading.value = true;

    CoursesByCatResponse response;

      response = CoursesByCatResponse.fromMap(
        await (await repository.get(ApiRoutes.courserandom(count))).data,
      );

    print('>>>>>>>>>>>>>>>>>');

    _landing.value = response;

    await getCats();
    loading.value = false;
  }

  getsingle(int courseID) async {
    loading.value = true;
    CourseSingleResponse response = CourseSingleResponse.fromMap(
        await (await repository.get(ApiRoutes.singleCourse(courseID))).data);
    _single.value = response;
    loading.value = false;
  }

  getCoursesByCat(BaseRequestSkipTake request) async {
    loading.value = true;

    await getCats();
    CoursesByCatResponse response;

    if (request.skip == 0) {
      response = CoursesByCatResponse.fromMap(
        await (await repository.get(ApiRoutes.courseByCat(request))).data,
      );
    } else {
      response.data.addAll(CoursesByCatResponse.fromMap(
        await (await repository.get(ApiRoutes.courseByCat(request))).data,
      ).data);
    }

    _coursesByCat.value = response;


    loading.value = false;
  }

  addCourse(BaseRequest request) async {

    CourseSingleResponse course = CourseSingleResponse.fromMap((await repository.post(ApiRoutes.createcourse(), request.toJson())).data);

    return course;
    // _landing.value.data.add(course.data);
    // _landing = _landing;
  }

  editCourse(JobAddRequest request, int CourseID) async {

    await repository.patch(ApiRoutes.editcourse(CourseID), request.toJson());

    _landing.value.data.removeWhere((element) => CourseID == element.id);
    _landing = _landing;

  }

  deleteCourse(int CourseID) async {
    await repository.delete(ApiRoutes.deletecourse(CourseID));
    _landing.value.data.removeWhere((element) => CourseID == element.id);
    _landing = _landing;
  }

  BehaviorSubject<CoursesByCatResponse> get landing => _landing;

  BehaviorSubject<CoursesByCatResponse> get CoursesByCat => _coursesByCat;

  BehaviorSubject<CourseSingleResponse> get single => _single;

  BehaviorSubject<CourseCatResponse> get cat => _cats;
}

final courseBloc = CourseBloc();
