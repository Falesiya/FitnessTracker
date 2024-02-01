//return todays date as yy mm dd
//------------------------------
//function
String todaysDateYYMMDD() {
  var dateTimeObject = DateTime.now();
  //Extract yea month & day using dateTimeObject
  String year = dateTimeObject.year.toString();
  //month in the format of mm
  String month = dateTimeObject.month.toString();
  //it ensures that they are represented with two digits (MM and DD) by adding a leading zero if they are single dig
  if (month.length == 1) {
    month = '0$month';
  }

  //day in the format of dd
  String day = dateTimeObject.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }
  //concatenate the month year and day
  String yyymmdd = year + month + day;
  return yyymmdd;
}
//convert String yymmdd to Datetime object
//------------------------------------------
DateTime createDateTimeObject(String yyyymmdd){
  int yyyy=int.parse(yyyymmdd.substring(0,4));
  int mm=int.parse(yyyymmdd.substring(4,6));
  int dd=int.parse(yyyymmdd.substring(6,8));
  DateTime dateTimeObject=DateTime(yyyy,mm,dd);
  return dateTimeObject;
}

//Convert  DateTime object to string YYYYMMDD

String convertDateTimeToYYYYMMDD(DateTime dateTime)
{
  String year=dateTime.year.toString();
   String month = dateTime.month.toString();
 
  if (month.length == 1) {
    month = '0$month';
  }

   String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }
    String yyymmdd = year + month + day;
  return yyymmdd;
}