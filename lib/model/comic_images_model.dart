class ComicImages {
  String topicImageId;
  String topicImageUrl;
  String quizTestType;
  bool quizIsAvailbleInPage;
  String quizTestScore;
  String quizTestLocation;

  ComicImages(
      {this.topicImageId,
        this.topicImageUrl,
        this.quizTestType,
        this.quizIsAvailbleInPage,
        this.quizTestScore,
        this.quizTestLocation});

  ComicImages.fromJson(Map<String, dynamic> json) {
    topicImageId = json['topic_image_id'];
    topicImageUrl = json['topic_image_url'];
    quizTestType = json['quiz_test_type'];
    quizIsAvailbleInPage = json['quiz_is_availble_in_page'];
    quizTestScore = json['quiz_test_score'];
    quizTestLocation = json['quiz_test_location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topic_image_id'] = this.topicImageId;
    data['topic_image_url'] = this.topicImageUrl;
    data['quiz_test_type'] = this.quizTestType;
    data['quiz_is_availble_in_page'] = this.quizIsAvailbleInPage;
    data['quiz_test_score'] = this.quizTestScore;
    data['quiz_test_location'] = this.quizTestLocation;
    return data;
  }
}