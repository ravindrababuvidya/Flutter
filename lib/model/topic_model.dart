class TopicsData {
  String courseId;
  String topicId;
  String topicName;
  String topicLocation;
  bool topicHavePrequiresmentTestAvailablity;
  String topicHavePrequiresmentTestLocation;
  int topicHavePrequirementTestId;
  String topicImagesLocation;

  TopicsData(
      {this.courseId,
        this.topicId,
        this.topicName,
        this.topicLocation,
        this.topicHavePrequiresmentTestAvailablity,
        this.topicHavePrequiresmentTestLocation,
        this.topicHavePrequirementTestId,
        this.topicImagesLocation});

  TopicsData.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    topicId = json['topic_id'];
    topicName = json['topic_name'];
    topicLocation = json['topic_location'];
    topicHavePrequiresmentTestAvailablity =
    json['topic_have_prequiresment_test_availablity'];
    topicHavePrequiresmentTestLocation =
    json['topic_have_prequiresment_test_location'];
    topicHavePrequirementTestId = json['topic_have_prequirement_test_id'];
    topicImagesLocation = json['topic_images_location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['topic_id'] = this.topicId;
    data['topic_name'] = this.topicName;
    data['topic_location'] = this.topicLocation;
    data['topic_have_prequiresment_test_availablity'] =
        this.topicHavePrequiresmentTestAvailablity;
    data['topic_have_prequiresment_test_location'] =
        this.topicHavePrequiresmentTestLocation;
    data['topic_have_prequirement_test_id'] = this.topicHavePrequirementTestId;
    data['topic_images_location'] = this.topicImagesLocation;
    return data;
  }
}