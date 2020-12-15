import 'package:wallpapersdev/modal/categories.dart';

String API_KEY = '563492ad6f9170000100000100121c1acda742a2a1546f60c0e885c9';

List<CategoriesModal> getCategories() {
  List<CategoriesModal> categories = new List();
  CategoriesModal categoriesModal = new CategoriesModal();

  categoriesModal.categoryImg =
      "https://images.pexels.com/photos/545008/pexels-photo-545008.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoriesModal.categoryName = "Street Art";
  categories.add(categoriesModal);
  categoriesModal = new CategoriesModal();

  categoriesModal.categoryImg =
      "https://images.pexels.com/photos/1545505/pexels-photo-1545505.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  categoriesModal.categoryName = "Abstract";
  categories.add(categoriesModal);
  categoriesModal = new CategoriesModal();

  categoriesModal.categoryImg =
      "https://images.pexels.com/photos/1136575/pexels-photo-1136575.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  categoriesModal.categoryName = "Night City";
  categories.add(categoriesModal);
  categoriesModal = new CategoriesModal();

  categoriesModal.categoryImg =
      "https://images.pexels.com/photos/598917/pexels-photo-598917.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  categoriesModal.categoryName = "Photography";

  categories.add(categoriesModal);
  categoriesModal = new CategoriesModal();

  categoriesModal.categoryImg =
      "https://images.pexels.com/photos/1910236/pexels-photo-1910236.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  categoriesModal.categoryName = "Art";

  categories.add(categoriesModal);
  categoriesModal = new CategoriesModal();

  categoriesModal.categoryImg =
      "https://images.pexels.com/photos/466685/pexels-photo-466685.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoriesModal.categoryName = "City";
  categories.add(categoriesModal);
  categoriesModal = new CategoriesModal();

  categoriesModal.categoryImg =
      "https://images.pexels.com/photos/2116475/pexels-photo-2116475.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoriesModal.categoryName = "Bikes";
  categories.add(categoriesModal);
  categoriesModal = new CategoriesModal();

  categoriesModal.categoryImg =
      "https://images.pexels.com/photos/1149137/pexels-photo-1149137.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoriesModal.categoryName = "Cars";
  categories.add(categoriesModal);
  categoriesModal = new CategoriesModal();

  categoriesModal.categoryImg =
      "https://images.pexels.com/photos/4173624/pexels-photo-4173624.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  categoriesModal.categoryName = "All";
  categories.add(categoriesModal);
  categoriesModal = new CategoriesModal();

  return categories;
}
