
String handleNull(String? str){
  if(str==null)
    return '';
  else
    return str;
}

String getAuthors(List<String>? list){
  if(list==null || list.isEmpty) {
    return 'Author N/A';
  } else {
    String authors = list.toString();
    var replace1 = authors.replaceAll('[', '');
    var replace2 = replace1.replaceAll(']', '');
    return 'by $replace2';
  }
}