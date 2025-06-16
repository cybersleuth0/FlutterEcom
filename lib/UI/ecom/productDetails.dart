import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom/utils/constants/AppConstant.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int _selectedTabIndex = 0;
  final List<String> _tabs = ["Description", "Specification", "Review"];

  int _selectedColorIndex = 0;
  final List<Color> _colors = [
    Colors.brown,
    Colors.black,
    Colors.blueAccent,
    Colors.yellow,
    Colors.grey,
  ];
  int _productCount = 1;
  @override
  // Main widget build method
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe3e3e3),
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
                  child: const Icon(CupertinoIcons.back),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Icon(Icons.share),
                ),
                const Icon(CupertinoIcons.heart),
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
              Container(
                height: 300,
                color: Colors.grey[200],
                child: const Center(child: Text("Carousel Slider Placeholder")),
              ),
              const SizedBox(height: 16),
              //Product Name Text
              const Text(
                "Product Name",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              //Seller name and product price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "\$99.99",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
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
                            const TextSpan(
                              text: "Seller Name: ",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            const TextSpan(
                              text: "Ayush Shende",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic,
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
                  const Text(
                    "4.2",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "(320 Reviews)",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              //Color Text
              const Text(
                "Color",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                              ? Border.all(color: Colors.black, width: 3)
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
                            ? Color(0xffff650e)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _tabs[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: _selectedTabIndex == index
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: _selectedTabIndex == index
                                  ? Colors
                                  .white // Text color for selected tab
                                  : Colors.grey[700],
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
                    "This is a detailed description of the product. It highlights its key features, benefits, and specifications. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      height: 1.5, // Improves readability
                    ),
                  ),
                  // Specification Content
                  Text(
                    "Product Specifications: \n- Material: High-quality leather \n- Dimensions: 10cm x 20cm x 5cm \n- Weight: 200g \n- Color Options: Brown, Black, Blue, Yellow, Grey",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                  // Review Content
                  Text(
                    "Customer Reviews: \n- User A: Great product, highly recommended! \n- User B: Good value for money. \n- User C: Satisfied with the purchase.",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              //add to cart button
              Align(
                alignment: Alignment.bottomCenter,
                child: Builder(
                  builder: (context) {
                    final screenWidth = MediaQuery
                        .of(context)
                        .size
                        .width;

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
                      decoration: const BoxDecoration(
                        color: Colors.black,
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
                                    vertical: 6
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
                                      child: const Icon(
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
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _productCount++;
                                        });
                                      },
                                      child: const Icon(
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
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.ROUTE_CART_PAGE,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffff650e),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  minimumSize: const Size(double.infinity, 40),
                                ),
                                child: const Text(
                                  "Add to Cart",
                                  style: TextStyle(
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
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
