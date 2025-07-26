import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom/UI/ecom/dashboard/Bloc/product_bloc.dart';
import 'package:flutter_ecom/UI/ecom/dashboard/Bloc/product_event.dart';
import 'package:flutter_ecom/UI/ecom/dashboard/Bloc/product_state.dart';
import 'package:flutter_ecom/utils/constants/AppConstant.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<String> bannerImages = [
    "https://www.shutterstock.com/image-vector/sale-banner-template-design-260nw-487080769.jpg",
    "https://mir-s3-cdn-cf.behance.net/project_modules/fs/3ce709113389695.60269c221352f.jpg",
    "https://t3.ftcdn.net/jpg/04/65/46/52/360_F_465465254_1pN9MGrA831idD6zIBL7q8rnZZpUCQTy.jpg",
    "https://media.gettyimages.com/id/2007738539/vector/mega-sale-banner-template-on-the-abstract-pop-art-sunburst-background-vector-illustration.jpg?s=612x612&w=gi&k=20&c=lMAorzvjdOegGxEGlO0PeGI9AscvT6XTwPzJSz1rgdk=",
  ];
  bool _isVisible = true;
  late ScrollController _scrollController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetAllProductsEvent());
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible) setState(() => _isVisible = false);
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isVisible) setState(() => _isVisible = true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  CupertinoIcons.square_grid_2x2,
                  color: colorScheme.onBackground,
                ),
                Text(
                  "Home",
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.ROUTE_CART_PAGE);
                  },
                  child: Icon(
                    CupertinoIcons.shopping_cart,
                    color: colorScheme.onBackground,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoadingState) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: colorScheme.primary,
                      strokeWidth: 3,
                    ),
                  ),
                );
              }
              if (state is ProductSuccessState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Searchbar
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: colorScheme.surface.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.search,
                              color: colorScheme.onSurface.withOpacity(0.6),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Search...",
                                  border: InputBorder.none,
                                  hintStyle: textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onSurface.withOpacity(0.6),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 20,
                              width: 1,
                              color: colorScheme.onSurface.withOpacity(0.4),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                            ),
                            Icon(
                              CupertinoIcons.slider_horizontal_3,
                              color: colorScheme.onSurface,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    // Carousel Slider
                    StatefulBuilder(
                      builder: (context, ss) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: colorScheme.onBackground.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: CarouselSlider(
                                  items: bannerImages.map((eachImg) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.network(
                                        eachImg,
                                        fit: BoxFit.fill,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(
                                              color: colorScheme.primary,
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }).toList(),
                                  options: CarouselOptions(
                                    onPageChanged: (index, _) {
                                      ss(() {
                                        _currentIndex = index;
                                      });
                                    },
                                    autoPlay: true,
                                    aspectRatio: 16 / 9,
                                    enlargeCenterPage: true,
                                    viewportFraction: 1.0,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeStrategy:
                                    CenterPageEnlargeStrategy.height,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: -15,
                                left: 0,
                                right: 0,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 16.0,
                                    right: 16.0,
                                  ),
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                        vertical: 6.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: colorScheme.onBackground.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(
                                          20.0,
                                        ),
                                      ),
                                      child: CarouselIndicator(
                                        width: 8,
                                        height: 8,
                                        space: 8,
                                        cornerRadius: 10,
                                        color: colorScheme.surface.withOpacity(0.5),
                                        activeColor: colorScheme.surface,
                                        count: bannerImages.length,
                                        index: _currentIndex,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16.0),
                    // Special offer for you row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Special offer for you",
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "see all",
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    // GridView for products
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200.0,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 2 / 3,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.ROUTE_PRODUCT_DETAILSPAGE,
                              arguments: state.products[index],
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: colorScheme.surface,
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color: colorScheme.onBackground.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Product image
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius:
                                        const BorderRadius.vertical(
                                          top: Radius.circular(15.0),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.network(
                                              state.products[index].image!,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Product name
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        state.products[index].name!
                                            .toUpperCase(),
                                        style: textTheme.bodyLarge?.copyWith(
                                          color: colorScheme.onSurface,
                                          letterSpacing: 0.5,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    // Product price
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "\u{20B9} ${state.products[index].price!}",
                                            style: textTheme.bodyMedium?.copyWith(
                                              color: colorScheme.onSurface.withOpacity(0.7),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 12,
                                                height: 12,
                                                decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              const SizedBox(width: 2),
                                              Container(
                                                width: 12,
                                                height: 12,
                                                decoration: BoxDecoration(
                                                  color: colorScheme.onSurface,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              const SizedBox(width: 2),
                                              Container(
                                                width: 12,
                                                height: 12,
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              Container(
                                                width: 12,
                                                height: 12,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                  ],
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      color: colorScheme.primary,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(16),
                                        bottomLeft: Radius.circular(8),
                                      ),
                                    ),
                                    child: Icon(
                                      CupertinoIcons.heart,
                                      color: colorScheme.surface,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16.0),
                  ],
                );
              }
              if (state is ProductFailureState) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 60,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Oops! Something went wrong.',
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "${state.errorMsg}\nPlease check your internet connection and try again.",
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurface.withOpacity(0.7),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: colorScheme.primary,
          elevation: 4.0,
          shape: CircleBorder(),
          child: Icon(
            CupertinoIcons.home,
            color: colorScheme.onPrimary,
          ),
        ),
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: _isVisible ? 80.0 : 0.0,
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: SizedBox(
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(CupertinoIcons.square_grid_2x2),
                  color: colorScheme.primary,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(CupertinoIcons.heart),
                  color: colorScheme.onSurface.withOpacity(0.6),
                  onPressed: () {},
                ),
                const SizedBox(width: 40),
                IconButton(
                  icon: Icon(CupertinoIcons.chat_bubble_text),
                  color: colorScheme.onSurface.withOpacity(0.6),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(CupertinoIcons.person),
                  color: colorScheme.onSurface.withOpacity(0.6),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.ROUTE_PROFILE);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}