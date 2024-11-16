import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondaryAddressCard extends StatelessWidget {
  final String name;
  final String country;
  final String city;
  final String phoneNumber;
  final String address;
  final bool isSelected;
  final VoidCallback onSelect;

  const SecondaryAddressCard({
    Key? key,
    required this.name,
    required this.country,
    required this.city,
    required this.phoneNumber,
    required this.address,
    this.isSelected = false,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20)),
      child: GestureDetector(
        onTap: onSelect,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 20),
                        SizedBox(width: 8),
                        Text(
                          "$city, $country",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.phone,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 20),
                        SizedBox(width: 8),
                        Text(
                          phoneNumber,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.home,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            address,
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Selection indicator
              Icon(
                Icons.check_circle,
                color: isSelected
                    ? CupertinoColors.activeGreen
                    : Theme.of(context).colorScheme.secondary,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
