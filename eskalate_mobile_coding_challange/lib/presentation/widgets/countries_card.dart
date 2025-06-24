import 'package:eskalate_mobile_coding_challange/model/country_model.dart';
import 'package:eskalate_mobile_coding_challange/presentation/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:eskalate_mobile_coding_challange/presentation/pages/country_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryCard extends StatelessWidget {
  final Country country;

  const CountryCard({super.key, required this.country});

  bool _isUrl(String text) {
    return text.startsWith('http://') || text.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        bool isFavorite = false;
        if (state is FavoritesLoaded) {
          isFavorite = state.favoriteCountries.contains(country);
        }
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CountryDetailPage(country: country),
              ),
            );
          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        _isUrl(country.flagImageUrl) &&
                                country.flagImageUrl.isNotEmpty
                            ? Image.network(
                              country.flagImageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.broken_image,
                                        color: Colors.grey,
                                        size: 40,
                                      ),
                                      Text(
                                        'Failed to Load',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                            : country.flagImageUrl.isNotEmpty
                            ? Center(
                              child: Text(
                                country.flagImageUrl,
                                style: const TextStyle(fontSize: 80),
                              ),
                            )
                            : const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey,
                                    size: 40,
                                  ),
                                  Text(
                                    'No Flag',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                        Positioned(
                          bottom: 8.0,
                          left: 8.0,
                          right: 8.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.people,
                                      color: Colors.white,
                                      size: 16.0,
                                    ),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      country.population,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (isFavorite) {
                                    context.read<FavoriteBloc>().add(
                                      RemoveFavorite(country),
                                    );
                                  } else {
                                    context.read<FavoriteBloc>().add(
                                      AddFavorite(country),
                                    );
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6.0),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.white,
                                    size: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    country.name,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
