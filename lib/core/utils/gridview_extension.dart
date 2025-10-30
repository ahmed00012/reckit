extension GridviewExtension on double{

  int get itemCount{
    if(this > 1220) {
      return 5;
    }
    else if(this > 1000) {
      return 4;
    } else if(this > 750) {
      return 3;
    } else if(this > 500) {
      return 2;
    } else {
      return 1;
    }

  }
  double get childAspectRatio{
    if(this > 1220) {
      return 0.95;
    }
    else if(this > 1000) {
      return 1;
    } else if(this > 750) {
      return 1.05;
    } else if(this > 500) {
      return 1.1;
    } else{
      return 1.6;
    }
  }
}