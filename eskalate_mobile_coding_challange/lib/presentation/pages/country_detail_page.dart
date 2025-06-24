import 'package:eskalate_mobile_coding_challange/model/country_model.dart';
import 'package:flutter/material.dart';

class CountryDetailPage extends StatelessWidget {
  final Country country;

  const CountryDetailPage({super.key, required this.country});

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  bool _isUrl(String text) {
    return text.startsWith('http://') || text.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
              child: SizedBox(
                height: 250,
                width: double.infinity,
                child:
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
                            style: const TextStyle(fontSize: 120),
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    country.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildDetailRow('Area', country.area),
                  _buildDetailRow('Population', country.population),
                  _buildDetailRow('Region', country.region),
                  _buildDetailRow('Sub Region', country.subRegion),

                  const SizedBox(height: 30),

                  const Text(
                    'Timezone',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children:
                        country.timezones.map((timezone) {
                          return Chip(
                            label: Text(timezone),
                            backgroundColor: Colors.blue.withOpacity(0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: Colors.blue[100]!),
                            ),
                            labelStyle: TextStyle(color: Colors.blue[800]),
                          );
                        }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
