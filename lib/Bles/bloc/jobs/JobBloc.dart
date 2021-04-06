import 'package:rxdart/rxdart.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/requests/jobs/JobAddRequest.dart';
import 'package:phinex/Bles/Model/responses/jobs/JobLandingResponse.dart';
import 'package:phinex/Bles/Model/responses/jobs/JobSingleResponse.dart';
import 'package:phinex/Bles/Model/responses/jobs/JobsByCatResponse.dart';
import 'package:phinex/utils/base/BaseBloc.dart';
import 'package:phinex/utils/base/BaseRequest.dart';

import '../../ApiRoutes.dart';

class JobBloc extends BaseBloc {
  BehaviorSubject<JobCatResponse> _cats = BehaviorSubject<JobCatResponse>();

  BehaviorSubject<JobsByCatResponse> _landing =
      BehaviorSubject<JobsByCatResponse>();

  BehaviorSubject<JobsByCatResponse> _jobsByCat =
      BehaviorSubject<JobsByCatResponse>();

  BehaviorSubject<JobSingleResponse> _single =
      BehaviorSubject<JobSingleResponse>();

  getCats() async {
    JobCatResponse response;
    response = JobCatResponse.fromMap(
      await (await repository.get(ApiRoutes.jobCategory())).data,
    );
    _cats.value = response;
  }

  getLanding(int count) async {
    loading.value = true;
    await getCats();

    JobsByCatResponse response;


      response = JobsByCatResponse.fromMap(
        await (await repository.get(ApiRoutes.jobrandom(count))).data,
      );


    print('>>>>>>>>>>>>>>>>>');

    _landing.value = response;


    loading.value = false;
  }

  getsingle(int jobID) async {
    loading.value = true;
    JobSingleResponse response = JobSingleResponse.fromMap(
        await (await repository.get(ApiRoutes.singleJob(jobID))).data);
    _single.value = response;
    loading.value = false;
  }

  getJobsByCat(BaseRequestSkipTake request) async {

    loading.value = true;

    if (request.skip == 0) {
      JobsByCatResponse response = JobsByCatResponse.fromMap(
        await (await repository.get(ApiRoutes.jobByCat(request))).data,
      );
      _jobsByCat.value = response;

    } else {

      _jobsByCat.value.data.addAll(JobsByCatResponse.fromMap(
        await (await repository.get(ApiRoutes.jobByCat(request))).data,
      ).data);
    }




    loading.value = false;

  }

  Future<JobSingleResponse> addJob(BaseRequest request) async {
    JobSingleResponse job = JobSingleResponse.fromMap((await repository.post(ApiRoutes.createJob(), request.toJson())).data);
    _landing.value.data.add(job.data);
    _landing = _landing;

    return job;
  }

  editJob(JobAddRequest request, int jobID) async {
    await repository.patch(ApiRoutes.editJob(jobID), request.toJson());

    _landing.value.data.removeWhere((element) => jobID == element.id);
    _landing = _landing;
  }

  deleteJob(int jobID) async {
    await repository.delete(ApiRoutes.deleteJob(jobID));
    _landing.value.data.removeWhere((element) => jobID == element.id);
    _landing = _landing;
  }

  BehaviorSubject<JobsByCatResponse> get landing => _landing;

  BehaviorSubject<JobsByCatResponse> get jobsByCat => _jobsByCat;

  BehaviorSubject<JobSingleResponse> get single => _single;

  BehaviorSubject<JobCatResponse> get cat => _cats;
}

final jobBloc = JobBloc();
