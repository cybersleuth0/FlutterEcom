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

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetAllProductsEvent());
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      // If the user scrolls down (reverse direction)
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible) setState(() => _isVisible = false);
      }
      // If the user scrolls up (forward direction)
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
    return Scaffold(
      backgroundColor: Color(0xffe3e3e3),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(CupertinoIcons.square_grid_2x2),
                Text(
                  "Home",
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.read<ProductBloc>().add(GetAllProductsEvent());
                  },
                  child: Icon(CupertinoIcons.bell),
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
                return Center(child: CircularProgressIndicator());
              }
              if (state is ProductSuccessState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Searchbar
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.search,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Search...",
                                  border: InputBorder.none,
                                  hintStyle: GoogleFonts.lato(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 20,
                              width: 1,
                              color: Colors.grey[400],
                              margin: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                            ),
                            const Icon(
                              CupertinoIcons.slider_horizontal_3,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    // Carousel Slider
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: const Offset(0, 4,
                            ),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: CarouselSlider(
                          items: bannerImages.map((eachImg) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(20.0,),
                              child: Image.network(eachImg, fit: BoxFit.fill),
                            );
                          }).toList(),
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 16 / 9,
                            enlargeCenterPage: true,
                            viewportFraction: 1.0,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeStrategy: CenterPageEnlargeStrategy
                                .height, // Optional: for a different enlarge effect
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    //Text(state.products[0].name!),
                    // Horizontal ListView for Category
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          String productName = "Category ${index + 1}";
                          String imageUrl =
                              "https://cdn.dummyjson.com/products/images/vehicle/Charger%20SXT%20RWD/thumbnail.png";
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(imageUrl),
                                  backgroundColor: Colors.grey[300],
                                  // Placeholder color
                                  child: imageUrl.isEmpty
                                      ? const Icon(
                                    Icons.image,
                                    size: 40,
                                    color: Colors.grey,
                                  )
                                      : null,
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  productName,
                                  style: GoogleFonts.lato(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    // Special offer for you row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Special offer for you",
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "see all",
                            style: GoogleFonts.lato(color: Colors.blue),
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
                        // Sets the horizontal spacing between columns
                        mainAxisSpacing: 10.0,
                        // Sets the vertical spacing between rows
                        childAspectRatio:
                        2 /
                            3, // Sets the ratio of width to height for each child item in the grid.
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.ROUTE_PRODUCT_DETAILSPAGE,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
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
                                    //Product image
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
                                    //product name
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        state.products[index].name!
                                            .toUpperCase(),
                                        style: GoogleFonts.lato(
                                          fontSize: 15.0,
                                          color: Colors.black87,
                                          letterSpacing: 0.5,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    //product price
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "\u{20B9} ${state.products[index]
                                                .price!}",
                                            style: GoogleFonts.lato(
                                              color: Colors.black45,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 12,
                                                height: 12,
                                                decoration: const BoxDecoration(
                                                  color: Colors.orange,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              const SizedBox(width: 2),
                                              Container(
                                                width: 12,
                                                height: 12,
                                                decoration: const BoxDecoration(
                                                  color: Colors.black,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              const SizedBox(width: 2),
                                              Container(
                                                width: 12,
                                                height: 12,
                                                decoration: const BoxDecoration(
                                                  color: Colors.red,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              Container(
                                                width: 12,
                                                height: 12,
                                                decoration: const BoxDecoration(
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
                                      color: Color(0xffff650e),
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(16),
                                        bottomLeft: Radius.circular(8),
                                      ),
                                    ),
                                    child: const Icon(
                                      CupertinoIcons.heart,
                                      color: Colors.white,
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
                return Center(
                  child: Text(state.errorMsg, style: GoogleFonts.lato()),
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
          backgroundColor: Color(0xffff650e),
          elevation: 4.0,
          shape: CircleBorder(),
          child: const Icon(CupertinoIcons.home, color: Colors.white),
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
                  icon: const Icon(CupertinoIcons.square_grid_2x2),
                  color: Color(0xffff650e),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(CupertinoIcons.heart),
                  color: Colors.grey,
                  onPressed: () {},
                ),
                const SizedBox(width: 40),
                IconButton(
                  icon: const Icon(CupertinoIcons.chat_bubble_text),
                  color: Colors.grey,
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(CupertinoIcons.person),
                  color: Colors.grey,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
