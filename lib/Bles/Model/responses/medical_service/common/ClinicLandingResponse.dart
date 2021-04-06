
import 'package:phinex/Bles/Model/responses/medical_service/common/CommonSingleResponse.dart';

class ClinicLandingResponse {
  DataBean data;
  String message;
  int code;

  static ClinicLandingResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ClinicLandingResponse clinicLandingResponseBean = ClinicLandingResponse();
    clinicLandingResponseBean.data = DataBean.fromMap(map['data']);
    clinicLandingResponseBean.message = map['message'];
    clinicLandingResponseBean.code = map['code'];
    return clinicLandingResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

/// clinics-specialties : [{"id":721,"name":"Urology","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2357,"deleted_at":null,"created_at":"2020-10-07T12:42:26.000000Z","updated_at":"2020-10-07T12:42:26.000000Z","clinics":[]},{"id":704,"name":"Inetrnal Medicine","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2340,"deleted_at":null,"created_at":"2020-10-07T12:38:57.000000Z","updated_at":"2020-10-07T12:38:57.000000Z","clinics":[]},{"id":681,"name":"Psychiatry","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2317,"deleted_at":null,"created_at":"2020-10-07T12:33:52.000000Z","updated_at":"2020-10-07T12:33:52.000000Z","clinics":[]},{"id":715,"name":"Pediatric Surgery","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2351,"deleted_at":null,"created_at":"2020-10-07T12:41:34.000000Z","updated_at":"2020-10-07T12:41:34.000000Z","clinics":[]},{"id":689,"name":"Andrology and Male Infertility","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2325,"deleted_at":null,"created_at":"2020-10-07T12:35:43.000000Z","updated_at":"2020-10-07T12:35:43.000000Z","clinics":[]},{"id":224,"name":"Surgeons","description":"Surgeons","keywords":"Surgeons","icon":null,"parent_id":13,"image_id":1762,"deleted_at":null,"created_at":"2020-09-20T13:08:19.000000Z","updated_at":"2020-09-20T13:08:19.000000Z","clinics":[]}]
/// specialties : [{"id":18,"name":"Dentist ","description":"?????","keywords":"?????","icon":null,"parent_id":13,"image_id":28,"deleted_at":null,"created_at":"2020-06-25T12:38:54.000000Z","updated_at":"2020-06-28T23:09:21.000000Z"},{"id":68,"name":"Neurologists","description":"Neurologists","keywords":"Neurologists","icon":null,"parent_id":13,"image_id":895,"deleted_at":null,"created_at":"2020-08-24T14:47:49.000000Z","updated_at":"2020-08-24T14:47:49.000000Z"},{"id":190,"name":"Cardiologist","description":"Cardiologist","keywords":"Cardiologist","icon":null,"parent_id":13,"image_id":1692,"deleted_at":null,"created_at":"2020-09-14T11:49:26.000000Z","updated_at":"2020-09-14T11:49:26.000000Z"},{"id":192,"name":"Cardiovascular","description":"Cardiovascular","keywords":"Cardiovascular","icon":null,"parent_id":13,"image_id":1692,"deleted_at":null,"created_at":"2020-09-14T12:00:39.000000Z","updated_at":"2020-09-14T12:00:39.000000Z"},{"id":198,"name":"Alternative Medicine","description":"Alternative Medicine","keywords":"Alternative Medicine","icon":null,"parent_id":13,"image_id":1736,"deleted_at":null,"created_at":"2020-09-20T10:56:03.000000Z","updated_at":"2020-09-20T10:56:03.000000Z"},{"id":199,"name":"Anesthesiologists","description":"Anesthesiologists","keywords":"Anesthesiologists","icon":null,"parent_id":13,"image_id":1737,"deleted_at":null,"created_at":"2020-09-20T10:58:14.000000Z","updated_at":"2020-09-20T10:58:14.000000Z"},{"id":200,"name":"Audiologists & Phoneticians","description":"Audiologists & Phoneticians","keywords":"Audiologists & Phoneticians","icon":null,"parent_id":13,"image_id":1738,"deleted_at":null,"created_at":"2020-09-20T11:06:58.000000Z","updated_at":"2020-09-20T11:06:58.000000Z"},{"id":201,"name":"Dermatologists","description":"Dermatologists","keywords":"Dermatologists","icon":null,"parent_id":13,"image_id":1739,"deleted_at":null,"created_at":"2020-09-20T11:10:41.000000Z","updated_at":"2020-09-20T11:10:41.000000Z"},{"id":202,"name":"Ear, Nose & Throat Specialists","description":"Ear, Nose & Throat Specialists","keywords":"Ear, Nose & Throat Specialists","icon":null,"parent_id":13,"image_id":1740,"deleted_at":null,"created_at":"2020-09-20T11:12:26.000000Z","updated_at":"2020-09-20T11:12:26.000000Z"},{"id":203,"name":"Endocrinologists","description":"Endocrinologists","keywords":"Endocrinologists","icon":null,"parent_id":13,"image_id":1741,"deleted_at":null,"created_at":"2020-09-20T11:14:40.000000Z","updated_at":"2020-09-20T11:14:40.000000Z"},{"id":204,"name":"Fertility","description":"Fertility","keywords":"Fertility","icon":null,"parent_id":13,"image_id":1742,"deleted_at":null,"created_at":"2020-09-20T11:48:18.000000Z","updated_at":"2020-09-20T11:48:18.000000Z"},{"id":205,"name":"Gastroenterologists & Endoscopy","description":"Gastroenterologists & Endoscopy","keywords":"Gastroenterologists & Endoscopy","icon":null,"parent_id":13,"image_id":1743,"deleted_at":null,"created_at":"2020-09-20T11:51:16.000000Z","updated_at":"2020-09-20T11:51:16.000000Z"},{"id":206,"name":"General Practitioners","description":"General Practitioners","keywords":"General Practitioners","icon":null,"parent_id":13,"image_id":1744,"deleted_at":null,"created_at":"2020-09-20T11:53:13.000000Z","updated_at":"2020-09-20T11:53:13.000000Z"},{"id":207,"name":"Geriatrics","description":"Geriatrics","keywords":"Geriatrics","icon":null,"parent_id":13,"image_id":1745,"deleted_at":null,"created_at":"2020-09-20T11:56:40.000000Z","updated_at":"2020-09-20T11:56:40.000000Z"},{"id":208,"name":"Hematologists","description":"Hematologists","keywords":"Hematologists","icon":null,"parent_id":13,"image_id":1746,"deleted_at":null,"created_at":"2020-09-20T11:59:01.000000Z","updated_at":"2020-09-20T11:59:01.000000Z"},{"id":209,"name":"Immunologists","description":"Immunologists","keywords":"Immunologists","icon":null,"parent_id":13,"image_id":1747,"deleted_at":null,"created_at":"2020-09-20T12:02:51.000000Z","updated_at":"2020-09-20T12:02:51.000000Z"},{"id":210,"name":"Internists","description":"Internists","keywords":"Internists","icon":null,"parent_id":13,"image_id":1748,"deleted_at":null,"created_at":"2020-09-20T12:04:54.000000Z","updated_at":"2020-09-20T12:04:54.000000Z"},{"id":211,"name":"Nephrologists","description":"Nephrologists","keywords":"Nephrologists","icon":null,"parent_id":13,"image_id":1749,"deleted_at":null,"created_at":"2020-09-20T12:07:01.000000Z","updated_at":"2020-09-20T12:07:01.000000Z"},{"id":212,"name":"Neurologists & Neurosurgeons","description":"Neurologists & Neurosurgeons","keywords":"Neurologists & Neurosurgeons","icon":null,"parent_id":13,"image_id":1750,"deleted_at":null,"created_at":"2020-09-20T12:12:36.000000Z","updated_at":"2020-09-20T12:12:36.000000Z"},{"id":213,"name":"Nutritionists & Dietitians","description":"Nutritionists & Dietitians","keywords":"Nutritionists & Dietitians","icon":null,"parent_id":13,"image_id":1751,"deleted_at":null,"created_at":"2020-09-20T12:19:31.000000Z","updated_at":"2020-09-20T12:19:31.000000Z"},{"id":214,"name":"Obstetricians & Gynaecologists","description":"Obstetricians & Gynaecologists","keywords":"Obstetricians & Gynaecologists","icon":null,"parent_id":13,"image_id":1752,"deleted_at":null,"created_at":"2020-09-20T12:22:29.000000Z","updated_at":"2020-09-20T12:22:29.000000Z"},{"id":215,"name":"Oncologists","description":"Oncologists","keywords":"Oncologists","icon":null,"parent_id":13,"image_id":1753,"deleted_at":null,"created_at":"2020-09-20T12:24:35.000000Z","updated_at":"2020-09-20T12:24:35.000000Z"},{"id":216,"name":"Ophthalmologists","description":"Ophthalmologists","keywords":"Ophthalmologists","icon":null,"parent_id":13,"image_id":1754,"deleted_at":null,"created_at":"2020-09-20T12:26:21.000000Z","updated_at":"2020-09-20T12:26:21.000000Z"},{"id":217,"name":"Orthopedic Surgeons","description":"Orthopedic Surgeons","keywords":"Orthopedic Surgeons","icon":null,"parent_id":13,"image_id":1755,"deleted_at":null,"created_at":"2020-09-20T12:29:16.000000Z","updated_at":"2020-09-20T12:29:16.000000Z"},{"id":218,"name":"Pain Management","description":"Pain Management","keywords":"Pain Management","icon":null,"parent_id":13,"image_id":1756,"deleted_at":null,"created_at":"2020-09-20T12:32:23.000000Z","updated_at":"2020-09-20T12:32:23.000000Z"},{"id":219,"name":"Pediatricians","description":"Pediatricians","keywords":"Pediatricians","icon":null,"parent_id":13,"image_id":1757,"deleted_at":null,"created_at":"2020-09-20T12:37:18.000000Z","updated_at":"2020-09-20T12:37:18.000000Z"},{"id":220,"name":"Physiotherapists","description":"Physiotherapists","keywords":"Physiotherapists","icon":null,"parent_id":13,"image_id":1758,"deleted_at":null,"created_at":"2020-09-20T12:43:15.000000Z","updated_at":"2020-09-20T12:43:15.000000Z"},{"id":221,"name":"Plastic Surgeons","description":"Plastic Surgeons","keywords":"Plastic Surgeons","icon":null,"parent_id":13,"image_id":1759,"deleted_at":null,"created_at":"2020-09-20T12:44:55.000000Z","updated_at":"2020-09-20T12:44:55.000000Z"},{"id":222,"name":"Psychiatrists","description":"Psychiatrists","keywords":"Psychiatrists","icon":null,"parent_id":13,"image_id":1760,"deleted_at":null,"created_at":"2020-09-20T12:46:44.000000Z","updated_at":"2020-09-20T12:46:44.000000Z"},{"id":223,"name":"Rheumatologists","description":"Rheumatologists","keywords":"Rheumatologists","icon":null,"parent_id":13,"image_id":1761,"deleted_at":null,"created_at":"2020-09-20T12:54:36.000000Z","updated_at":"2020-09-20T12:54:36.000000Z"},{"id":224,"name":"Surgeons","description":"Surgeons","keywords":"Surgeons","icon":null,"parent_id":13,"image_id":1762,"deleted_at":null,"created_at":"2020-09-20T13:08:19.000000Z","updated_at":"2020-09-20T13:08:19.000000Z"},{"id":225,"name":"Urologists","description":"Urologists","keywords":"Urologists","icon":null,"parent_id":13,"image_id":1763,"deleted_at":null,"created_at":"2020-09-20T13:11:35.000000Z","updated_at":"2020-09-20T13:11:35.000000Z"},{"id":226,"name":"Venereologists","description":"Venereologists","keywords":"Venereologists","icon":null,"parent_id":13,"image_id":1764,"deleted_at":null,"created_at":"2020-09-20T13:14:21.000000Z","updated_at":"2020-09-20T13:14:21.000000Z"},{"id":227,"name":"X-Ray","description":"X-Ray","keywords":"X-Ray","icon":null,"parent_id":13,"image_id":1765,"deleted_at":null,"created_at":"2020-09-20T13:19:38.000000Z","updated_at":"2020-09-20T13:19:38.000000Z"},{"id":679,"name":"Dermatology","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2315,"deleted_at":null,"created_at":"2020-10-07T12:33:36.000000Z","updated_at":"2020-10-07T12:33:36.000000Z"},{"id":680,"name":"Dentistry","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2316,"deleted_at":null,"created_at":"2020-10-07T12:33:45.000000Z","updated_at":"2020-10-07T12:33:45.000000Z"},{"id":681,"name":"Psychiatry","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2317,"deleted_at":null,"created_at":"2020-10-07T12:33:52.000000Z","updated_at":"2020-10-07T12:33:52.000000Z"},{"id":682,"name":"Pediatrics and New Born","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2318,"deleted_at":null,"created_at":"2020-10-07T12:34:01.000000Z","updated_at":"2020-10-07T12:34:01.000000Z"},{"id":683,"name":"Neurology","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2319,"deleted_at":null,"created_at":"2020-10-07T12:34:08.000000Z","updated_at":"2020-10-07T12:34:08.000000Z"},{"id":684,"name":"Orthopedics","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2320,"deleted_at":null,"created_at":"2020-10-07T12:34:17.000000Z","updated_at":"2020-10-07T12:34:17.000000Z"},{"id":685,"name":"Gynaecology and Infertility","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2321,"deleted_at":null,"created_at":"2020-10-07T12:35:04.000000Z","updated_at":"2020-10-07T12:35:04.000000Z"},{"id":686,"name":"Ear, Nose and Throat","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2322,"deleted_at":null,"created_at":"2020-10-07T12:35:13.000000Z","updated_at":"2020-10-07T12:35:13.000000Z"},{"id":687,"name":"Cardiology and Vascular Disease","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2323,"deleted_at":null,"created_at":"2020-10-07T12:35:21.000000Z","updated_at":"2020-10-07T12:35:21.000000Z"},{"id":688,"name":"Allergy and Immunology","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2324,"deleted_at":null,"created_at":"2020-10-07T12:35:32.000000Z","updated_at":"2020-10-07T12:35:32.000000Z"},{"id":689,"name":"Andrology and Male Infertility","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2325,"deleted_at":null,"created_at":"2020-10-07T12:35:43.000000Z","updated_at":"2020-10-07T12:35:43.000000Z"},{"id":690,"name":"Audiology","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2326,"deleted_at":null,"created_at":"2020-10-07T12:35:58.000000Z","updated_at":"2020-10-07T12:35:58.000000Z"},{"id":691,"name":"Cardiology and Thoracic Surgery","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2327,"deleted_at":null,"created_at":"2020-10-07T12:36:08.000000Z","updated_at":"2020-10-07T12:36:08.000000Z"},{"id":692,"name":"Chest and Respiratory","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2328,"deleted_at":null,"created_at":"2020-10-07T12:36:18.000000Z","updated_at":"2020-10-07T12:36:18.000000Z"},{"id":693,"name":"Diabetes and Endocrinology","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2329,"deleted_at":null,"created_at":"2020-10-07T12:36:26.000000Z","updated_at":"2020-10-07T12:36:26.000000Z"},{"id":694,"name":"Diagnostic Radiology","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2330,"deleted_at":null,"created_at":"2020-10-07T12:36:34.000000Z","updated_at":"2020-10-07T12:36:34.000000Z"},{"id":695,"name":"Diagnostic Radiology","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2331,"deleted_at":null,"created_at":"2020-10-07T12:36:41.000000Z","updated_at":"2020-10-07T12:36:41.000000Z"},{"id":696,"name":"Dietitian and Nutrition ","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2332,"deleted_at":null,"created_at":"2020-10-07T12:36:51.000000Z","updated_at":"2020-10-07T12:36:51.000000Z"},{"id":697,"name":"Family Medicine","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2333,"deleted_at":null,"created_at":"2020-10-07T12:36:59.000000Z","updated_at":"2020-10-07T12:36:59.000000Z"},{"id":698,"name":"Gastroenterology and Endoscopy","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2334,"deleted_at":null,"created_at":"2020-10-07T12:37:49.000000Z","updated_at":"2020-10-07T12:37:49.000000Z"},{"id":699,"name":"General Practice ","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2335,"deleted_at":null,"created_at":"2020-10-07T12:38:04.000000Z","updated_at":"2020-10-07T12:38:04.000000Z"},{"id":700,"name":"General Surgery","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2336,"deleted_at":null,"created_at":"2020-10-07T12:38:12.000000Z","updated_at":"2020-10-07T12:38:12.000000Z"},{"id":701,"name":"Geriatrics","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2337,"deleted_at":null,"created_at":"2020-10-07T12:38:24.000000Z","updated_at":"2020-10-07T12:38:24.000000Z"},{"id":702,"name":"Hematology","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2338,"deleted_at":null,"created_at":"2020-10-07T12:38:28.000000Z","updated_at":"2020-10-07T12:38:28.000000Z"},{"id":703,"name":"Hepatology","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2339,"deleted_at":null,"created_at":"2020-10-07T12:38:49.000000Z","updated_at":"2020-10-07T12:38:49.000000Z"},{"id":704,"name":"Inetrnal Medicine","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2340,"deleted_at":null,"created_at":"2020-10-07T12:38:57.000000Z","updated_at":"2020-10-07T12:38:57.000000Z"},{"id":705,"name":"IVF and Infertility","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2341,"deleted_at":null,"created_at":"2020-10-07T12:39:06.000000Z","updated_at":"2020-10-07T12:39:06.000000Z"},{"id":706,"name":"Laboratories","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2342,"deleted_at":null,"created_at":"2020-10-07T12:39:17.000000Z","updated_at":"2020-10-07T12:39:17.000000Z"},{"id":707,"name":"Nephrology","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2343,"deleted_at":null,"created_at":"2020-10-07T12:39:38.000000Z","updated_at":"2020-10-07T12:39:38.000000Z"},{"id":708,"name":"Neurosurgery","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2344,"deleted_at":null,"created_at":"2020-10-07T12:39:47.000000Z","updated_at":"2020-10-07T12:39:47.000000Z"},{"id":709,"name":"Obesity and Laparoscopic Surgery","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2345,"deleted_at":null,"created_at":"2020-10-07T12:39:55.000000Z","updated_at":"2020-10-07T12:39:55.000000Z"},{"id":710,"name":"Oncology","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2346,"deleted_at":null,"created_at":"2020-10-07T12:40:24.000000Z","updated_at":"2020-10-07T12:40:24.000000Z"},{"id":711,"name":"Oncology Surgery","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2347,"deleted_at":null,"created_at":"2020-10-07T12:40:28.000000Z","updated_at":"2020-10-07T12:40:28.000000Z"},{"id":712,"name":"Ophthalmology","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2348,"deleted_at":null,"created_at":"2020-10-07T12:41:06.000000Z","updated_at":"2020-10-07T12:41:06.000000Z"},{"id":713,"name":"Osteopathy","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2349,"deleted_at":null,"created_at":"2020-10-07T12:41:15.000000Z","updated_at":"2020-10-07T12:41:15.000000Z"},{"id":714,"name":"Pain Management","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2350,"deleted_at":null,"created_at":"2020-10-07T12:41:24.000000Z","updated_at":"2020-10-07T12:41:24.000000Z"},{"id":715,"name":"Pediatric Surgery","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2351,"deleted_at":null,"created_at":"2020-10-07T12:41:34.000000Z","updated_at":"2020-10-07T12:41:34.000000Z"},{"id":716,"name":"Phoniatrics","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2352,"deleted_at":null,"created_at":"2020-10-07T12:41:47.000000Z","updated_at":"2020-10-07T12:41:47.000000Z"},{"id":717,"name":"Physiotherapy and Sport Injuries","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2353,"deleted_at":null,"created_at":"2020-10-07T12:41:55.000000Z","updated_at":"2020-10-07T12:41:55.000000Z"},{"id":718,"name":"Plastic Surgery","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2354,"deleted_at":null,"created_at":"2020-10-07T12:42:02.000000Z","updated_at":"2020-10-07T12:42:02.000000Z"},{"id":719,"name":"Rheumatology","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2355,"deleted_at":null,"created_at":"2020-10-07T12:42:09.000000Z","updated_at":"2020-10-07T12:42:09.000000Z"},{"id":720,"name":"Spinal Surgery ","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2356,"deleted_at":null,"created_at":"2020-10-07T12:42:16.000000Z","updated_at":"2020-10-07T12:42:16.000000Z"},{"id":721,"name":"Urology","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2357,"deleted_at":null,"created_at":"2020-10-07T12:42:26.000000Z","updated_at":"2020-10-07T12:42:26.000000Z"},{"id":722,"name":"Vascular Surgery","description":",","keywords":",","icon":null,"parent_id":13,"image_id":2358,"deleted_at":null,"created_at":"2020-10-07T12:42:30.000000Z","updated_at":"2020-10-07T12:42:30.000000Z"}]

class DataBean {
  List<ClinicsSpecialtiesBean> clinics_specialties;
  List<SpecialtiesBean> specialties;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.clinics_specialties = List()..addAll(
      (map['clinics-specialties'] as List ?? []).map((o) => ClinicsSpecialtiesBean.fromMap(o))
    );
    dataBean.specialties = List()..addAll(
      (map['specialties'] as List ?? []).map((o) => SpecialtiesBean.fromMap(o))
    );
    return dataBean;
  }

  Map toJson() => {
    "clinics-specialties": clinics_specialties,
    "specialties": specialties,
  };
}

/// id : 18
/// name : "Dentist "
/// description : "?????"
/// keywords : "?????"
/// icon : null
/// parent_id : 13
/// image_id : 28
/// deleted_at : null
/// created_at : "2020-06-25T12:38:54.000000Z"
/// updated_at : "2020-06-28T23:09:21.000000Z"

class SpecialtiesBean {
  int id;
  String name;
  String description;
  String keywords;
  dynamic icon;
  dynamic parentId;
  dynamic imageId;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;

  static SpecialtiesBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SpecialtiesBean specialtiesBean = SpecialtiesBean();
    specialtiesBean.id = map['id'];
    specialtiesBean.name = map['name'];
    specialtiesBean.description = map['description'];
    specialtiesBean.keywords = map['keywords'];
    specialtiesBean.icon = map['icon'];
    specialtiesBean.parentId = map['parent_id'];
    specialtiesBean.imageId = map['image_id'];
    specialtiesBean.deletedAt = map['deleted_at'];
    specialtiesBean.createdAt = map['created_at'];
    specialtiesBean.updatedAt = map['updated_at'];
    return specialtiesBean;
  }

  Map toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "keywords": keywords,
    "icon": icon,
    "parent_id": parentId,
    "image_id": imageId,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

/// id : 721
/// name : "Urology"
/// description : ","
/// keywords : ","
/// icon : null
/// parent_id : 13
/// image_id : 2357
/// deleted_at : null
/// created_at : "2020-10-07T12:42:26.000000Z"
/// updated_at : "2020-10-07T12:42:26.000000Z"
/// clinics : []

class ClinicsSpecialtiesBean {
  int id;
  String name;
  String description;
  String keywords;
  dynamic icon;
  dynamic parentId;
  dynamic imageId;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;
  List<CommonBean> clinics;

  static ClinicsSpecialtiesBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ClinicsSpecialtiesBean clinics_specialtiesBean = ClinicsSpecialtiesBean();
    clinics_specialtiesBean.id = map['id'];
    clinics_specialtiesBean.name = map['name'];
    clinics_specialtiesBean.description = map['description'];
    clinics_specialtiesBean.keywords = map['keywords'];
    clinics_specialtiesBean.icon = map['icon'];
    clinics_specialtiesBean.parentId = map['parent_id'];
    clinics_specialtiesBean.imageId = map['image_id'];
    clinics_specialtiesBean.deletedAt = map['deleted_at'];
    clinics_specialtiesBean.createdAt = map['created_at'];
    clinics_specialtiesBean.updatedAt = map['updated_at'];
    clinics_specialtiesBean.clinics = List()..addAll(
        (map['clinics'] as List ?? []).map((o) => CommonBean.fromMap(o))
    );
    return clinics_specialtiesBean;
  }

  Map toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "keywords": keywords,
    "icon": icon,
    "parent_id": parentId,
    "image_id": imageId,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "clinics": clinics,
  };
}