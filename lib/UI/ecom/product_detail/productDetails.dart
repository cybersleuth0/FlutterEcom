import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom/UI/ecom/product_detail/Bloc/cart_Event.dart';
import 'package:flutter_ecom/UI/ecom/product_detail/Bloc/cart_State.dart';
import 'package:flutter_ecom/data/remote/models/productModel.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Bloc/cart_Bloc.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int _selectedTabIndex = 0;
  final List<String> _tabs = ["Description", "Specification", "Review"];

  int _productCount = 1;
  int _selectedColorIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final List<Color> _colors = [
      Colors.brown,
      Colors.red,
      Colors.blueAccent,
      Colors.yellow,
      Colors.grey,
    ];

    final detailedModel =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            height: kToolbarHeight + 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    CupertinoIcons.back,
                    color: colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Icon(Icons.share, color: colorScheme.onSurface),
                ),
                Icon(CupertinoIcons.heart, color: colorScheme.onSurface),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Slider
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: colorScheme.surface.withOpacity(0.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        detailedModel.image!,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              //Product Name Text
              //name
              Text(detailedModel.name!, style: textTheme.displaySmall),
              const SizedBox(height: 8),
              //Seller name and product price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //price
                  Text(
                    "₹${detailedModel.price!}",
                    style: textTheme.headlineSmall?.copyWith(
                      color: Colors.green,
                    ),
                    // style: GoogleFonts.roboto(
                    //   fontSize: 20,
                    //   color: Colors.green,
                    //   fontWeight: FontWeight.bold,
                    // ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.storefront,
                        color: Colors.black,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Seller Name: ",
                              // style: GoogleFonts.openSans(
                              //   fontSize: 18,
                              //   color: Colors.black,
                              // )
                              style: textTheme.headlineSmall,
                            ),
                            TextSpan(
                              text: "Ayush Shende",
                              // style: GoogleFonts.raleway(
                              //   fontSize: 16,
                              //   color: Colors.blueGrey,
                              //   fontWeight: FontWeight.w500,
                              //   fontStyle: FontStyle.italic,
                              // )
                              style: textTheme.headlineSmall?.copyWith(
                                color: Colors.blueGrey,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              //review row
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.orange, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    "4.2",
                    // style: GoogleFonts.montserrat(
                    //   fontSize: 16,
                    //   fontWeight: FontWeight.bold,
                    //   color: Colors.orange,
                    // )
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "(320 Reviews)",
                    // style: GoogleFonts.poppins(
                    //   fontSize: 16,
                    //   color: Colors.grey[600],
                    // )
                    style: textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              //Color Text
              Text(
                "Color",
                // style: GoogleFonts.lato(
                //   fontSize: 18,
                //   fontWeight: FontWeight.w600,
                // )
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              // Color selection row
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _colors.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColorIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: _selectedColorIndex == index
                              ? Border.all(
                                  color:
                                      colorScheme.brightness == Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                  width: 3,
                                )
                              : null,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: CircleAvatar(backgroundColor: _colors[index]),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Tabs for Description, Specification, Review
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(_tabs.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTabIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: _selectedTabIndex == index
                            ? colorScheme.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _tabs[index],
                            // style: GoogleFonts.nunito(
                            //   fontSize: 16,
                            //   fontWeight: _selectedTabIndex == index
                            //       ? FontWeight.bold
                            //       : FontWeight.normal,
                            //   color: _selectedTabIndex == index
                            //       ? Colors.white
                            //       : Colors
                            //             .grey[700], // Text color for selected tab
                            // ),
                            style: textTheme.bodyLarge?.copyWith(
                              fontWeight: _selectedTabIndex == index
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: _selectedTabIndex == index
                                  ? colorScheme.surface
                                  : Colors
                                        .grey[500], // Text color for selected tab
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
              // Content based on selected tab
              IndexedStack(
                index: _selectedTabIndex,
                children: [
                  // Description Content
                  Text(
                    "This is a detailed description of the product_detail. It highlights its key features, benefits, and specifications. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    // style: GoogleFonts.openSans(
                    //   fontSize: 15,
                    //   color: Colors.grey[700],
                    //   height: 1.5,
                    // )
                    style: textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                      color: colorScheme.brightness == Brightness.light
                          ? Colors.black.withOpacity(0.8)
                          : Colors.grey,
                    ),
                  ),
                  // Specification Content
                  Text(
                    "Product Specifications: \n- Material: High-quality leather \n- Dimensions: 10cm x 20cm x 5cm \n- Weight: 200g \n- Color Options: Brown, Black, Blue, Yellow, Grey",
                    // style: GoogleFonts.poppins(
                    //   fontSize: 15,
                    //   color: Colors.grey[700],
                    //   height: 1.5,
                    // )
                    style: textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                      color: colorScheme.brightness == Brightness.light
                          ? Colors.black.withOpacity(0.8)
                          : Colors.grey,
                    ),
                  ),
                  // Review Content
                  Text(
                    "Customer Reviews: \n- User A: Great product_detail, highly recommended! \n- User B: Good value for money. \n- User C: Satisfied with the purchase.",
                    // style: GoogleFonts.roboto(
                    //   fontSize: 15,
                    //   color: Colors.grey[700],
                    //   height: 1.5,
                    // )
                    style: textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                      color: colorScheme.brightness == Brightness.light
                          ? Colors.black.withOpacity(0.8)
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              //add to cart button
              BlocListener<CartBloc, CartState>(
                listener: (context, state) {
                  if (state is CartLoading_State) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                                strokeWidth: 2.0,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Adding to cart...",
                                style: textTheme.bodyMedium?.copyWith(
                                  height: 1.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        elevation: 6.0,
                        backgroundColor: colorScheme.secondary,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: EdgeInsets.all(10),
                      ),
                    );
                  } else if (state is CartSuccess_State) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Item Added to Cart",
                                // style: TextStyle(
                                //   color: colorScheme.surface,
                                //   fontSize: 16,
                                //   fontWeight: FontWeight.w600,
                                // )
                                style: textTheme.bodyLarge?.copyWith(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        elevation: 6.0,
                        backgroundColor: colorScheme.secondary,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: EdgeInsets.all(10),
                      ),
                    );
                  }
                  if (state is CartError_State) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: colorScheme.surface,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                state.errorMsg,
                                // style: TextStyle(
                                //   color: Colors.white,
                                //   fontSize: 16,
                                //   fontWeight: FontWeight.w600,
                                // )
                                style: textTheme.bodyLarge?.copyWith(
                                  color: colorScheme.surface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        elevation: 6.0,
                        backgroundColor: Colors.redAccent,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  }
                },
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Builder(
                    builder: (context) {
                      final screenWidth = MediaQuery.of(context).size.width;

                      final containerWidth = screenWidth > 600
                          ? screenWidth * 0.6
                          : screenWidth * 0.8;
                      final horizontalMargin = screenWidth > 600
                          ? screenWidth * 0.08
                          : screenWidth * 0.05;
                      // | Screen Width     | Container Width | Horizontal Margin |
                      // | ---------------- | --------------- | ----------------- |
                      // | > 600px (tablet) | 60% of screen   | 8% of screen      |
                      // | ≤ 600px (mobile) | 90% of screen   | 5% of screen      |

                      return Container(
                        width: containerWidth,
                        margin: EdgeInsets.symmetric(
                          horizontal: horizontalMargin,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 1,
                              blurRadius: 5,
                            ),
                          ],

                          borderRadius: BorderRadius.all(Radius.circular(35)),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 7,
                          horizontal: 10,
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Quantity selector
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (_productCount > 1) {
                                              _productCount--;
                                            }
                                          });
                                        },
                                        child: Icon(
                                          CupertinoIcons.minus,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0,
                                        ),
                                        child: Text(
                                          _productCount.toString(),
                                          // style: GoogleFonts.lato(
                                          //   fontSize: 18,
                                          //   color: Colors.white,
                                          //   fontWeight: FontWeight.bold,
                                          // ),
                                          style: textTheme.headlineSmall
                                              ?.copyWith(color: Colors.white),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _productCount++;
                                          });
                                        },
                                        child: Icon(
                                          CupertinoIcons.add,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Add to Cart Button
                              Expanded(
                                flex: 3,
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.read<CartBloc>().add(
                                      AddtoCartEvent(
                                        productId: int.parse(detailedModel.id!),
                                        quantity: _productCount,
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: colorScheme.primary,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),

                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    minimumSize: const Size(
                                      double.infinity,
                                      40,
                                    ),
                                  ),
                                  child: Text(
                                    "Add to Cart",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
