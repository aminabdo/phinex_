import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/responses/professions/ProfessionsByCatResponse.dart';
import 'package:phinex/Bles/Model/responses/professions/ProfessionsByUserResponse.dart';
import 'package:phinex/Bles/Model/responses/professions/ProfessionsLandingResponse.dart';
import 'package:phinex/Bles/Model/responses/professions/ProfessionsSearchResponse.dart';
import 'package:phinex/Bles/api_provider/Professions/ProfessionsApiProvider.dart';
import 'package:phinex/utils/base/BaseRepository.dart';

class ProfessionsRepository extends BaseRepository {
  ProfessionsApiProvider _apiProvider = ProfessionsApiProvider();

  Future<ProfessionsLandingResponse> getProfessionsLanding() {
    return _apiProvider.getProfessionsLanding();
  }

  Future<ProfessionsByCatResponse> getProfessionsByCat(
      BaseRequestSkipTake request) {
    return _apiProvider.getProfessionsByCat(request);
  }

  Future<ProfessionsByUserResponse> getProfessionsSingle(int id) {
    return _apiProvider.getProfessionsByUser(id);
  }

  Future<ProfessionsSearchResponse> getProfessionsSearch(String search) {
    return _apiProvider.getProfessionsSearch(search);
  }
}
