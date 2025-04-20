import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ContactRequestsRecord extends FirestoreRecord {
  ContactRequestsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  bool hasMessage() => _message != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  bool hasTimestamp() => _timestamp != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _message = snapshotData['message'] as String?;
    _timestamp = snapshotData['timestamp'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('contact_requests');

  static Stream<ContactRequestsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ContactRequestsRecord.fromSnapshot(s));

  static Future<ContactRequestsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ContactRequestsRecord.fromSnapshot(s));

  static ContactRequestsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ContactRequestsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ContactRequestsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ContactRequestsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ContactRequestsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ContactRequestsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createContactRequestsRecordData({
  String? email,
  String? message,
  DateTime? timestamp,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'message': message,
      'timestamp': timestamp,
    }.withoutNulls,
  );

  return firestoreData;
}

class ContactRequestsRecordDocumentEquality
    implements Equality<ContactRequestsRecord> {
  const ContactRequestsRecordDocumentEquality();

  @override
  bool equals(ContactRequestsRecord? e1, ContactRequestsRecord? e2) {
    return e1?.email == e2?.email &&
        e1?.message == e2?.message &&
        e1?.timestamp == e2?.timestamp;
  }

  @override
  int hash(ContactRequestsRecord? e) =>
      const ListEquality().hash([e?.email, e?.message, e?.timestamp]);

  @override
  bool isValidKey(Object? o) => o is ContactRequestsRecord;
}
