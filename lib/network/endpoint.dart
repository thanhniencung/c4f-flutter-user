class EndPoint {
  /*********** USER-SERVICE ***********/
  static const String SIGN_IN = "http://localhost:3000/sign-in";
  static const String SIGN_UP = "http://localhost:3000/sign-up";

  /*********** UPLOAD-SERVICE ***********/
  static const String UPLOAD = "http://localhost:3002/upload";

  /*********** PRODUCT-SERVICE ***********/
  static const String LIST_PRODUCT = "http://localhost:3001/product/list";

  /********** ORDER SERVICE **********/
  static const String ADD_TO_CARD = "http://localhost:3003/order/add";
  static const String DETAIL_SHOPPING_CARD =
      "http://localhost:3003/order/detail";
  static const String COUNT_SHOPPING_CARD = "http://localhost:3003/order/count";
  static const String CONFIRM_ORDER = "http://localhost:3003/order/confirm";
  static const String UPDATE_SHOPPING_CARD =
      "http://localhost:3003/order/update";
}
