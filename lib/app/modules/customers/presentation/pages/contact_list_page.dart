import 'dart:async';

import 'package:cognisto/app/modules/customers/domain/service/customers_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../data/models/customers_model.dart' show UsersResponse;
import '../widgets/components/cached_network_image.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  final TextEditingController _searchController = TextEditingController();
  final CustomerService _customerService = CustomerService();
  late Future<UsersResponse> _futureUsers;
  Timer? _debounce;

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _futureUsers = _customerService.getAllCustomers(
      currentPage,
    ); // initial load
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final query = _searchController.text.trim();
      setState(() {
        _futureUsers = query.isEmpty
            ? _customerService.getAllCustomers(currentPage)
            : _customerService.getCustomerByName(query);
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(hint: Text("Search a contact")),
              ),
            ),
            SizedBox(height: 20),
            FutureBuilder<UsersResponse>(
              future: _futureUsers,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CupertinoActivityIndicator(radius: 18));
                }
                if (!snapshot.hasData || snapshot.data!.users.isEmpty) {
                  return const Center(child: Text("No users found"));
                }

                final users = snapshot.data!.users;
                if (snapshot.hasData) {
                  final data = snapshot.data;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final currentUser = data?.users[index];
                        return ListTile(
                              title: Text(
                                "${currentUser?.firstName} ${currentUser?.lastName}",
                              ),
                              subtitle: Text(currentUser?.email ?? "No Email"),
                              trailing: CachedImageContainer(
                                imageUrl: currentUser!.image,
                              ),
                            )
                            .animate(delay: 100.ms * index)
                            .fadeIn(duration: 300.ms)
                            .slideY(begin: 0.2, duration: 300.ms);
                      },
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
