import 'package:eskalate_mobile_coding_challange/presentation/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:eskalate_mobile_coding_challange/presentation/widgets/countries_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite')),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoritesError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is FavoritesLoaded) {
            if (state.favoriteCountries.isEmpty) {
              return const Center(
                child: Text(
                  'No favorite countries yet!',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.8,
                ),
                itemCount: state.favoriteCountries.length,
                itemBuilder: (context, index) {
                  return CountryCard(country: state.favoriteCountries[index]);
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
