import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:derviza_app/bloc/expert/expert_bloc.dart';
import 'package:derviza_app/bloc/expert/expert_event.dart';
import 'package:derviza_app/bloc/expert/expert_state.dart';
import 'package:derviza_app/model/expert.dart';
import 'package:derviza_app/screen/expert_screen.dart';

class ExpertListPage extends StatefulWidget {
  @override
  _ExpertListPageState createState() => _ExpertListPageState();
}

class _ExpertListPageState extends State<ExpertListPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String _sortBy = 'Rating';
  String _searchQuery = '';
  Set<String> _selectedSpecialities = {};
  List<String> _uniqueSpecialities = [];
  StreamSubscription? _expertSubscription;

  @override
  void initState() {
    super.initState();
    context.read<ExpertBloc>().add(LoadExperts());
    _expertSubscription = context.read<ExpertBloc>().stream.listen((state) {
       if (mounted && state is ExpertLoaded) {
        List<Expert> experts = state.experts;
        Set<String> uniqueSpecialities = {};
        for (Expert expert in experts) {
          uniqueSpecialities.add(expert.speciality);
        }
        setState(() {
          _uniqueSpecialities = uniqueSpecialities.toList();
        });
      }
    });

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _expertSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expert List'),
      ),
      backgroundColor: Color.fromARGB(255, 236, 241, 228),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search by name',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  flex: 1,
                  child: DropdownButton<String>(
                    value: _sortBy,
                    onChanged: (String? newValue) {
                      setState(() {
                        _sortBy = newValue!;
                      });
                    },
                    items: <String>['Rating', 'Experience']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Color(0xFF416422),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    dropdownColor: Color(0xFF819a20),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: _uniqueSpecialities.map((speciality) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      padding: EdgeInsets.all(2.0),
                      label: Text(speciality, style: TextStyle(color: Colors.white)),
                      selected: _selectedSpecialities.contains(speciality),
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            _selectedSpecialities.add(speciality);
                          } else {
                            _selectedSpecialities.remove(speciality);
                          }
                        });
                      },
                      selectedColor: Colors.green,
                      checkmarkColor: Colors.white,
                      backgroundColor: Color(0xFF598216),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<ExpertBloc, ExpertState>(
              builder: (context, state) {
                if (state is ExpertLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ExpertLoaded) {
                  List<Expert> experts = state.experts;

                  // Filter experts based on the search query and selected specialities
                  if (_searchQuery.isNotEmpty) {
                    experts = experts.where((expert) =>
                        expert.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
                  }
                  if (_selectedSpecialities.isNotEmpty) {
                    experts = experts.where((expert) =>
                        _selectedSpecialities.contains(expert.speciality)).toList();
                  }

                  // Sort the experts list based on the selected sorting option
                  if (_sortBy == 'Rating') {
                    experts.sort((a, b) => b.rating.compareTo(a.rating));
                  } else if (_sortBy == 'Experience') {
                    experts.sort((a, b) => b.experience.compareTo(a.experience));
                  }

                  return ListView.builder(
                    itemCount: experts.length,
                    itemBuilder: (context, index) {
                      final expert = experts[index];
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1, 0),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: _controller,
                          curve: Curves.easeInOut,
                        )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          
                          child: Card(
                            elevation: 4,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                              child: ListTile(
                                leading: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      // color: Colors.black,
                                      // width: 2.0,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      expert.imagesUrl.isNotEmpty
                                        ? expert.imagesUrl
                                        : 'placeholder_image_url.png',
                                    ),
                                  ),
                                ),
                                title: Text(expert.name),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Experience: ${expert.experience} years'),
                                    Text('Rating: ${expert.rating.toStringAsFixed(1)}'),
                                    Text('Speciality: ${expert.speciality}'),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          "/expertsPage",
                                          arguments: expert,
                                        );
                                      },
                                      icon: Icon(Icons.remove_red_eye),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is ExpertError) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                } else {
                  return Center(
                    child: Text('No experts available.'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
