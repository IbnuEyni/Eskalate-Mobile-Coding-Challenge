import 'package:eskalate_mobile_coding_challange/main.dart';
import 'package:eskalate_mobile_coding_challange/model/country_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FavoriteEvent {}

class LoadFavorites extends FavoriteEvent {}

class AddFavorite extends FavoriteEvent {
  final Country country;
  AddFavorite(this.country);
}

class RemoveFavorite extends FavoriteEvent {
  final Country country;
  RemoveFavorite(this.country);
}

abstract class FavoriteState {}

class FavoritesLoading extends FavoriteState {}

class FavoritesLoaded extends FavoriteState {
  final List<Country> favoriteCountries;
  FavoritesLoaded(this.favoriteCountries);
}

class FavoritesError extends FavoriteState {
  final String message;
  FavoritesError(this.message);
}

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  static const String _favoritesKey = 'favoriteCountryNames';

  FavoriteBloc() : super(FavoritesLoading()) {
    on<LoadFavorites>((event, emit) async {
      emit(FavoritesLoading());
      try {
        final prefs = await SharedPreferences.getInstance();
        final List<String> favoriteNames =
            prefs.getStringList(_favoritesKey) ?? [];

        final List<Country> favoriteCountries =
            MyApp.allCountriesData
                .where((country) => favoriteNames.contains(country.name))
                .toList();

        emit(FavoritesLoaded(favoriteCountries));
      } catch (e) {
        emit(FavoritesError('Failed to load favorites: $e'));
      }
    });

    on<AddFavorite>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      List<String> favoriteNames = prefs.getStringList(_favoritesKey) ?? [];

      if (!favoriteNames.contains(event.country.name)) {
        favoriteNames.add(event.country.name);
        await prefs.setStringList(_favoritesKey, favoriteNames);
      }
      add(LoadFavorites());
    });

    on<RemoveFavorite>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      List<String> favoriteNames = prefs.getStringList(_favoritesKey) ?? [];

      if (favoriteNames.contains(event.country.name)) {
        favoriteNames.remove(event.country.name);
        await prefs.setStringList(_favoritesKey, favoriteNames);
      }
      add(LoadFavorites());
    });

    add(LoadFavorites());
  }
}
