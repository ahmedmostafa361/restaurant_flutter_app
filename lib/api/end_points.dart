class EndPoints {
  static const String baseUrl = 'https://fakerestaurantapi.runasp.net/api';
  static const String restaurantApi = '/Restaurant';
  static const String restaurantByIdApi = '/Restaurant/{id}';
  static const String menuApi = '/Restaurant/{id}/menu';
  static const String restaurantItemApi = '/Restaurant/items';
  static const String registerRequestApi = '/User/register';
  static const String loginRequestApi = '/User/getusercode';
  static const String makeOrderApi = '/Order/{restaurantId}/makeorder';
  static const String getAllOrderApi = "/Order";
  static const String getAllOrderDetailsByIdApi = "/Order/{master_id}";
}