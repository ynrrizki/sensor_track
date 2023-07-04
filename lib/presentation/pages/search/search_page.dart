// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';


// class SearchPage extends StatefulWidget {
//   const SearchPage({super.key});

//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   TextEditingController searchController = TextEditingController();
//   bool isSearchEmpty = true;

//   @override
//   void initState() {
//     super.initState();
//     searchController.addListener(_updateSearchState);
//   }

//   @override
//   void dispose() {
//     searchController.removeListener(_updateSearchState);
//     searchController.dispose();
//     super.dispose();
//   }

//   void _updateSearchState() {
//     setState(() {
//       isSearchEmpty = searchController.text.isEmpty;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         iconTheme: const IconThemeData(color: Colors.white),
//         elevation: 0,
//         centerTitle: true,
//         title: SearchFieldWidget(
//           hintText: 'Title',
//           searchController: searchController,
//           onChanged: (value) {
//             context.read<SearchBloc>().add(
//                   SearchContent(title: value),
//                 );
//           },
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             child: TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text(
//                 'Cancel',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 15,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 15)
//         ],
//       ),
//       body: isSearchEmpty
//           ? const IdleSearch()
//           : LoadSearch(
//               ratingRepository: ratingRepository,
//             ),
//     );
//   }
// }

// class LoadSearch extends StatelessWidget {
//   const LoadSearch({
//     super.key,
//     required this.ratingRepository,
//   });

//   final RatingRepository ratingRepository;

//   @override
//   Widget build(BuildContext context) {
//     List<Search> searchs = Search.searchs;
//     return BlocBuilder<SearchBloc, SearchState>(
//       buildWhen: (previous, current) => current is SearchLoaded,
//       builder: (context, state) {
//         if (state is SearchLoading) {
//           return const Center(
//             child: CircularProgressIndicator(
//               color: Colors.blueAccent,
//             ),
//           );
//         } else if (state is SearchLoaded) {
//           searchs = state.searchs;
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//             child: ListView(
//               children: searchs.map(
//                 (search) {
//                   return StreamBuilder(
//                     stream: const Stream.empty(),
//                     builder: (context, snapshot) {
//                       return ContentCardWidget(
//                         name: search.title,
//                         icon: search.icon,
//                         description: search.description,
//                       );
//                     },
//                   );
//                 },
//               ).toList(),
//             ),
//           );
//         }
//         return const Center(
//           child: Text('Something went wrong'),
//         );
//       },
//     );
//   }
// }

// class ContentCardWidget extends StatelessWidget {
//   const ContentCardWidget({
//     super.key,
//     required this.name,
//     required this.icon,
//     required this.description,
//   });

//   final String name;
//   final Icon icon;
//   final String description;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         onTap: () {},
//         contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//         iconColor: Colors.blueAccent,
//         textColor: Colors.blueAccent,
//         leading: Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: Colors.blue.shade100,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: icon,
//         ),
//         title: Text(
//           name,
//           style: GoogleFonts.poppins(
//             fontSize: 18,
//             fontWeight: FontWeight.w500,
//           ),
//           softWrap: false,
//           overflow: TextOverflow.ellipsis,
//         ),
//         subtitle: Text(
//           description,
//           style: GoogleFonts.poppins(
//             color: Colors.blueAccent,
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }
