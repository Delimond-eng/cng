import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

var storage = GetStorage();

String truncateStringWithPoint(String text, int length) {
  return (text.length >= length) ? "${text.substring(0, length)}..." : text;
}

String truncateString(String text, int length) {
  return (text.length >= length) ? text.substring(0, length) : text;
}

List<String> strSpliter(String date) {
  var strList = date.split(RegExp(r"[,| ]"));
  return strList;
}

Future<PickedFile> takePhoto({ImageSource src}) async {
  final ImagePicker _picker = ImagePicker();
  // ignore: deprecated_member_use
  final pickedFile = await _picker.getImage(source: src, imageQuality: 60);

  if (pickedFile != null) {
    return pickedFile;
  } else {
    return null;
  }
}

Future<List<PickedFile>> takeMultiplePhoto({ImageSource src}) async {
  final ImagePicker _picker = ImagePicker();
  // ignore: deprecated_member_use
  final pickedFile = await _picker.getMultiImage(imageQuality: 60);

  if (pickedFile != null) {
    return pickedFile;
  } else {
    return null;
  }
}

String dateFromString(DateTime date) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  String formatted = formatter.format(date);
  return formatted;
}

String chatDateParse(String strdate) {
  final DateFormat _formatter = (strdate.contains("-"))
      ? DateFormat('dd-MM-yyyy')
      : DateFormat('dd/MM/yyyy');

  DateTime date = _formatter.parse(strdate);

  final now = DateTime.now();
  if (_formatter.format(now) == _formatter.format(date)) {
    return 'Aujourd\'hui';
  } else if (_formatter.format(DateTime(now.year, now.month, now.day - 1)) ==
      _formatter.format(date)) {
    return 'Hier';
  } else {
    return DateFormat.yMMMd("fr_FR").format(date);
  }
}

String msgDate(String strdate) {
  final DateFormat _formatter = (strdate.contains("-"))
      ? DateFormat('dd-MM-yyyy')
      : DateFormat('dd/MM/yyyy');
  DateTime date = _formatter.parse(strdate.trim().split("|")[1].trim());
  final now = DateTime.now();
  if (_formatter.format(now) == _formatter.format(date)) {
    return strdate.trim().split("|")[0].trim();
  } else if (_formatter.format(DateTime(now.year, now.month, now.day - 1)) ==
      _formatter.format(date)) {
    return "Hier";
  } else {
    return '${DateFormat('dd').format(date)}/${DateFormat('MM').format(date)}';
  }
}

DateTime strTodate(String date) {
  final DateFormat formatter = (date.contains("-"))
      ? DateFormat('dd-MM-yyyy')
      : DateFormat('dd/MM/yyyy');
  DateTime d = formatter.parse(date);
  return d;
}

String strDateLong(String value) {
  var date = strTodate(value);
  String converted = DateFormat.yMMMd().format(date);
  return converted;
}

String strDateLongFr(String value) {
  var date = strTodate(value);
  String converted = DateFormat.yMMMd("fr_FR").format(date);
  return converted;
}
