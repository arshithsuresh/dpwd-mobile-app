import 'dart:math';

import 'package:dpwdapp/api/ComplaintAPI.dart';
import 'package:dpwdapp/error/ProjectExceptions.dart';
import 'package:dpwdapp/error/UserExceptions.dart';
import 'package:dpwdapp/model/complaintModel.dart';
import 'package:dpwdapp/model/complaintModel.dart';
import 'package:flutter/foundation.dart';

class ComplaintProvider extends ChangeNotifier {
  List<Complaint> _complaints = [];
  Complaint selectedComplaint;
  int _selectedComplaint;
  ComplaintAPI _complaintAPI = ComplaintAPI();

  selectComplaint(Complaint complaint) {
    this.selectedComplaint = complaint;
    notifyListeners();
  }

  resetSelectedComplaint() {
    this.selectedComplaint = null;
    notifyListeners();
  }

  Future<List<Complaint>> initializeAllComplaints() async {
    _complaints = await _complaintAPI.getAllComplaint();
    if (_complaints != null) {
      notifyListeners();
      return _complaints;
    }
    return null;
  }

  List<Complaint> getAllComplaints() {
    if (_complaints != null || _complaints.length > 0) {
      return _complaints;
    }

    return null;
  }

  Future<bool> createComplaint(Complaint complaintData, String userid) async {
    try {
      final result = await _complaintAPI.createComplaint(
          complaint: complaintData, complaintID: complaintData.bid);

      if (result == true) _complaints.add(complaintData);
      notifyListeners();
      return result;
    } on InvalidDataFormat catch (e) {
      print(e.toString());
    } on UnAuthorizedUser catch (e) {
      print(e.toString());
    }
    notifyListeners();
    return false;
  }

  Future<bool> signCurrentComplaint() async {
    try {
      final result =
          await _complaintAPI.signComplaint(complaintID: selectedComplaint.bid);
      if (result) {
        return true;
      }
    } on UnAuthorizedUser catch (e) {}

    return false;
  }
  Future<bool> upVoteCurrentComplaint() async {
    try {
      final result =
          await _complaintAPI.upVoteComplaint(complaintID: selectedComplaint.bid);
      if (result) {
        return true;
      }
    } on UnAuthorizedUser catch (e) {}

    return false;
  }

  Future<Map<String, Complaint>> getCurrentComplaintHistory() async {
    try {
      final result = await _complaintAPI.getComplaintHistory(
          complaintID: selectedComplaint.bid);
      if (result != null) {
        return result;
      }
    } on Exception catch (e) {
      print(e);
    }

    return null;
  }

  Future<bool> updateComplaintStatusPending() async {
    try {
      final result = await _complaintAPI.setComplaintStatusPending(
          complaintID: selectedComplaint.bid);

      if (result == true) {
        selectedComplaint = await _complaintAPI.getComplaintByID(
            complaintID: selectedComplaint.bid);
        notifyListeners();
        return true;
      }
    } on UnAuthorizedUser catch (e) {
      print(e.toString());
    }

    return false;
  }

  Future<bool> updateComplaintStatusVerified() async {
    try {
      final result = await _complaintAPI.setComplaintStatusVerified(
          complaintID: selectedComplaint.bid);

      if (result == true) {
        selectedComplaint = await _complaintAPI.getComplaintByID(
            complaintID: selectedComplaint.bid);
        notifyListeners();
        return true;
      }
    } on UnAuthorizedUser catch (e) {
      print(e.toString());
    }

    return false;
  }

  Future<bool> updateComplaintStatusInvalid() async {
    try {
      final result = await _complaintAPI.setComplaintStatusInvalid(
          complaintID: selectedComplaint.bid);

      if (result == true) {
        selectedComplaint = await _complaintAPI.getComplaintByID(
            complaintID: selectedComplaint.bid);
        notifyListeners();
        return true;
      }
    } on UnAuthorizedUser catch (e) {
      print(e.toString());
    }

    return false;
  }

  Future<bool> updateComplaintStatusResolved() async {
    try {
      final result = await _complaintAPI.setComplaintStatusResolved(
          complaintID: selectedComplaint.bid);

      if (result == true) {
        selectedComplaint = await _complaintAPI.getComplaintByID(
            complaintID: selectedComplaint.bid);
        notifyListeners();
        return true;
      }
    } on UnAuthorizedUser catch (e) {
      print(e.toString());
    }

    return false;
  }
}
