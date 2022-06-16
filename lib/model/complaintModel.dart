class Location {
  double lat;
  double lng;

  Location({this.lat, this.lng});

  factory Location.fromJson(Map<String, dynamic> data) {
    return Location(
        lat: double.parse(data['lat'].toString()),
        lng: double.parse(data['long'].toString()));
  }
}

class Complaint {
  String bid;
  String title;
  String complaintID;
  String createdBy;
  String createdDate;
  String detailedDesc;

  Location location;
  String region;
  String shortDesc;
  List<String> signatures;
  int status;
  String type;
  String image;
  String resolvedImage;
  List<String> upVotes;

  getBID() {
    if (bid.length < 16) return bid;

    final len = bid.length;
    return bid.substring(0, 12) + "...." + bid.substring(len - 6, len - 1);
  }

  getCreatedByID() {
    if (createdBy.length < 16) return bid;

    final len = createdBy.length;
    return createdBy.substring(0, 12) +
        "...." +
        createdBy.substring(len - 6, len - 1);
  }

  getNumberOfUpVotes() {
    return upVotes.length;
  }

  getNumberOfSignatures() {
    return signatures.length;
  }

  Complaint(
      {this.bid,
      this.complaintID,
      this.title,
      this.createdBy,
      this.createdDate,
      this.detailedDesc,
      this.location,
      this.region,
      this.shortDesc,
      this.signatures,
      this.status,
      this.type,
      this.upVotes,
      this.image,
      this.resolvedImage});

  factory Complaint.fromJson(Map<String, dynamic> data) {
    return Complaint(
        bid: data['bid'],
        complaintID: data['complaintID'],
        title: data['title'],
        createdBy: data['createdBy'],
        createdDate: data['createdDate'],
        detailedDesc: data['detailedDesc'],
        location: Location.fromJson(data['location']),
        region: data['region'],
        shortDesc: data['shortDesc'],
        image: data.containsKey("image")?data["image"]:null,
        resolvedImage: data.containsKey("resolvedImage")?data["resolvedImage"]:null,
        signatures:data.containsKey("signatures")?
            data['signatures'].map<String>((val) => val.toString()).toList():[],
        status: int.parse(data['status'].toString()),
        upVotes: data['upVotes'].map<String>((val) => val.toString()).toList(),
        type: data['type']);
  }
}
