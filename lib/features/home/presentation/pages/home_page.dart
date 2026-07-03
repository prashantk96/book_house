import 'package:book_house/features/home/presentation/cubit/home_cubit.dart';
import 'package:book_house/features/home/presentation/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final categories = [
    {
      'title': 'Fiction',
      'color': const Color(0xffDDF2FF),
      'image': 'assets/images/genere.png',
    },
    {
      'title': 'Science',
      'color': const Color(0xffFCE4FF),
      'image': 'assets/images/genere1.png',
    },
  ];

  @override
  void initState() {
    super.initState();

    context.read<HomeCubit>().fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),

      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final isListView = state.isListView;

          final selectedTab = state.selectedTab;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text(
                        'Books',

                        style: GoogleFonts.poppins(
                          fontSize: width * .09,

                          fontWeight: FontWeight.w700,

                          color: const Color(0xff202244),
                        ),
                      ),

                      Image.asset('assets/images/user_avatar.png'),
                    ],
                  ),

                  const SizedBox(height: 25),

                  /// SEARCH
                  Container(
                    height: 56,

                    decoration: BoxDecoration(
                      color: const Color(0xffF1F0F8),

                      borderRadius: BorderRadius.circular(18),
                    ),

                    child: TextField(
                      onSubmitted: (value) {
                        if (value.trim().isNotEmpty) {
                          context.read<HomeCubit>().search(value);
                        }
                      },

                      decoration: InputDecoration(
                        border: InputBorder.none,

                        hintText: 'Search Books',

                        hintStyle: GoogleFonts.poppins(
                          color: const Color(0xffB8B5D0),
                        ),

                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color(0xffB8B5D0),
                        ),

                        suffixIcon: IconButton(
                          onPressed: () {
                            context.read<HomeCubit>().fetchBooks();
                          },

                          icon: const Icon(
                            Icons.tune,
                            color: Color(0xffB8B5D0),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// CATEGORY
                  SizedBox(
                    height: 120,

                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,

                      itemCount: categories.length,

                      separatorBuilder: (_, __) => const SizedBox(width: 15),

                      itemBuilder: (_, index) {
                        final item = categories[index];

                        return InkWell(
                          borderRadius: BorderRadius.circular(20),

                          onTap: () {
                            context.read<HomeCubit>().fetchBooks();
                          },

                          child: SizedBox(
                            width: 150,

                            child: Image.asset(
                              item['image'] as String,

                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// TITLE
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Choose your book',

                          overflow: TextOverflow.ellipsis,

                          style: GoogleFonts.poppins(
                            fontSize: 22,

                            fontWeight: FontWeight.w600,

                            color: const Color(0xff202244),
                          ),
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          context.read<HomeCubit>().changeView(true);
                        },

                        icon: Icon(
                          Icons.view_list,

                          color: isListView
                              ? const Color(0xff4B68FF)
                              : Colors.grey,
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          context.read<HomeCubit>().changeView(false);
                        },

                        icon: Icon(
                          Icons.grid_view,

                          color: !isListView
                              ? const Color(0xff4B68FF)
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  /// FILTERS
                  SizedBox(
                    height: 35,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _tab(context, 'All', 0, selectedTab),
                        _tab(context, 'Popular', 1, selectedTab),
                        _tab(context, 'New', 2, selectedTab),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// BOOKS
                  Expanded(
                    child: Builder(
                      builder: (_) {
                        if (state is HomeLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is HomeError) {
                          return Center(child: Text(state.message));
                        }

                        if (state is! HomeLoaded) {
                          return const SizedBox();
                        }

                        final books = state.books;

                        if (books.isEmpty) {
                          return const Center(child: Text('No books found'));
                        }

                        /// LIST VIEW
                        if (isListView) {
                          return ListView.separated(
                            itemCount: books.length,

                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 15),

                            itemBuilder: (_, index) {
                              final book = books[index];

                              return InkWell(
                                borderRadius: BorderRadius.circular(20),

                                onTap: () {},

                                child: Container(
                                  padding: const EdgeInsets.all(14),

                                  decoration: BoxDecoration(
                                    color: Colors.white,

                                    borderRadius: BorderRadius.circular(20),

                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(.1),

                                        blurRadius: 20,
                                      ),
                                    ],
                                  ),

                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),

                                        child: Image.network(
                                          book.thumbnail,

                                          width: 75,

                                          height: 100,

                                          fit: BoxFit.cover,

                                          errorBuilder: (_, __, ___) =>
                                              Container(
                                                width: 75,

                                                height: 100,

                                                color: Colors.grey.shade300,

                                                child: const Icon(
                                                  Icons.menu_book,
                                                ),
                                              ),
                                        ),
                                      ),

                                      const SizedBox(width: 16),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,

                                          children: [
                                            Text(
                                              book.title,

                                              maxLines: 2,

                                              overflow: TextOverflow.ellipsis,

                                              style: GoogleFonts.poppins(
                                                fontSize: 18,

                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),

                                            const SizedBox(height: 5),

                                            Text(
                                              book.author,

                                              maxLines: 1,

                                              overflow: TextOverflow.ellipsis,

                                              style: GoogleFonts.poppins(
                                                color: Colors.grey,
                                              ),
                                            ),

                                            const SizedBox(height: 10),

                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.orange,
                                                  size: 18,
                                                ),

                                                const SizedBox(width: 5),

                                                Text(
                                                  book.rating.toString(),

                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }

                        /// GRID VIEW
                        return GridView.builder(
                          itemCount: books.length,

                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,

                                crossAxisSpacing: 15,

                                mainAxisSpacing: 15,

                                childAspectRatio: .62,
                              ),

                          itemBuilder: (_, index) {
                            final book = books[index];

                            return InkWell(
                              borderRadius: BorderRadius.circular(20),

                              onTap: () {},

                              child: Container(
                                padding: const EdgeInsets.all(12),

                                decoration: BoxDecoration(
                                  color: Colors.white,

                                  borderRadius: BorderRadius.circular(20),
                                ),

                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),

                                        child: Image.network(
                                          book.thumbnail,

                                          width: double.infinity,

                                          fit: BoxFit.cover,

                                          errorBuilder: (_, __, ___) =>
                                              Container(
                                                color: Colors.grey.shade300,

                                                child: const Icon(
                                                  Icons.menu_book,
                                                ),
                                              ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    Text(
                                      book.title,

                                      maxLines: 2,

                                      overflow: TextOverflow.ellipsis,

                                      textAlign: TextAlign.center,

                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),

                                    const SizedBox(height: 5),

                                    Text(
                                      book.author,

                                      maxLines: 1,

                                      overflow: TextOverflow.ellipsis,

                                      style: GoogleFonts.poppins(
                                        fontSize: 12,

                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _tab(BuildContext context, String title, int index, int selectedTab) {
    final selected = selectedTab == index;

    return GestureDetector(
      onTap: () {
        context.read<HomeCubit>().changeTab(index);
      },

      child: Container(
        margin: const EdgeInsets.only(right: 15),

        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),

        decoration: BoxDecoration(
          color: selected ? const Color(0xff4B68FF) : Colors.transparent,

          borderRadius: BorderRadius.circular(30),
        ),

        child: Text(
          title,

          style: GoogleFonts.poppins(
            color: selected ? Colors.white : const Color(0xff8E8EA0),

            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
