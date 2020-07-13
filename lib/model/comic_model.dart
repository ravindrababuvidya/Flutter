class ComicData {
  int courseId;
  String courseName;
  String courseRequirement;
  String courseServerType;
  int courseLength;
  int numberOfLessons;
  int numberOfStudentsAllowed;
  String createdOn;
  String accessToken;
  String publisher;
  String courseJson;
  String courseDropboxThumbnail;
  String courseTemporaryThumbnailURL;
  double coursePrice;
  String updatedOn;
  String author;
  String description;
  String gradeLevel;
  String language;

  ComicData(
      {this.courseId,
        this.courseName,
        this.courseRequirement,
        this.courseServerType,
        this.courseLength,
        this.numberOfLessons,
        this.numberOfStudentsAllowed,
        this.createdOn,
        this.accessToken,
        this.publisher,
        this.courseJson,
        this.courseDropboxThumbnail,
        this.courseTemporaryThumbnailURL,
        this.coursePrice,
        this.updatedOn,
        this.author,
        this.description,
        this.gradeLevel,
        this.language});

  ComicData.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    courseName = json['course_name'];
    courseRequirement = json['course_requirement'];
    courseServerType = json['course_server_type'];
    courseLength = json['course_length'];
    numberOfLessons = json['number_of_lessons'];
    numberOfStudentsAllowed = json['number_of_students_allowed'];
    createdOn = json['created_on'];
    accessToken = json['access_token'];
    publisher = json['publisher'];
    courseJson = json['course_json'];
    courseDropboxThumbnail = json['course_dropbox_thumbnail'];
    courseTemporaryThumbnailURL = json['course_temporary_thumbnailURL'];
    coursePrice = json['course_price'];
    updatedOn = json['updated_on'];
    author = json['author'];
    description = json['description'];
    gradeLevel = json['gradeLevel'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['course_name'] = this.courseName;
    data['course_requirement'] = this.courseRequirement;
    data['course_server_type'] = this.courseServerType;
    data['course_length'] = this.courseLength;
    data['number_of_lessons'] = this.numberOfLessons;
    data['number_of_students_allowed'] = this.numberOfStudentsAllowed;
    data['created_on'] = this.createdOn;
    data['access_token'] = this.accessToken;
    data['publisher'] = this.publisher;
    data['course_json'] = this.courseJson;
    data['course_dropbox_thumbnail'] = this.courseDropboxThumbnail;
    data['course_temporary_thumbnailURL'] = this.courseTemporaryThumbnailURL;
    data['course_price'] = this.coursePrice;
    data['updated_on'] = this.updatedOn;
    data['author'] = this.author;
    data['description'] = this.description;
    data['gradeLevel'] = this.gradeLevel;
    data['language'] = this.language;
    return data;
  }
}