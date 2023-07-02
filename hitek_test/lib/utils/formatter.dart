class Formatter {
  static String formatNumber(String number){
    String numberInText = "";
    int counter = 0;
    for(int i = (number.length - 1);  i >= 0; i--){
      counter++;
      String str = number[i];
      if((counter % 3) != 0 && i !=0){
        numberInText = "$str$numberInText";
      }else if(i == 0 ){
        numberInText = "$str$numberInText";

      }else{
        numberInText = ".$str$numberInText";
      }
    }
    return numberInText.trim();
  }
}