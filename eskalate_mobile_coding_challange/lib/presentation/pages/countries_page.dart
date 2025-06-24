import 'package:eskalate_mobile_coding_challange/main.dart';
import 'package:eskalate_mobile_coding_challange/model/country_model.dart';
import 'package:eskalate_mobile_coding_challange/presentation/widgets/countries_card.dart';
import 'package:flutter/material.dart';

class CountriesPage extends StatefulWidget {
  const CountriesPage({super.key});

  @override
  State<CountriesPage> createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  List<Country> filteredCountries = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCountries = MyApp.allCountriesData;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredCountries =
          MyApp.allCountriesData.where((country) {
            return country.name.toLowerCase().contains(query);
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Countries')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search countries',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16.0),

            Expanded(
              child:
                  MyApp.allCountriesData.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16.0,
                              mainAxisSpacing: 16.0,
                              childAspectRatio: 0.8,
                            ),
                        itemCount: filteredCountries.length,
                        itemBuilder: (context, index) {
                          return CountryCard(country: filteredCountries[index]);
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
