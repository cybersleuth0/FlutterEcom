import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom/UI/ecom/Profile/Bloc/profile_Bloc.dart';
import 'package:flutter_ecom/UI/ecom/Profile/Bloc/profile_Event.dart';
import 'package:flutter_ecom/UI/ecom/Profile/Bloc/profile_State.dart';
import 'package:flutter_ecom/utils/constants/AppConstant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Map<String, dynamic> userData = {
    "id": "7",
    "name": "Mukesh Kumar",
    "email": "mukesh1@gmail.com",
    "mobile_number": "7073689209",
    "password": "123456",
    "image": "",
    "status": "1",
    "created_at": "2024-06-06 16:07:02",
    "updated_at": "2024-06-06 16:07:02",
  };

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(FetchUserDetails());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(CupertinoIcons.back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              "Profile",
              style: GoogleFonts.lato(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: BlocBuilder<ProfileBloc, ProfileStates>(
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return SizedBox(
                height:
                    MediaQuery.of(context).size.height -
                    (Scaffold.of(context).appBarMaxHeight ?? 0) -
                    MediaQuery.of(context).padding.top,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (state is ProfileSuccessState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              state.userData["image"] != null &&
                                  state.userData["image"].isNotEmpty
                              ? NetworkImage(state.userData["image"] as String)
                              : AssetImage("Assets/image/boy_3d_image.jpg")
                                    as ImageProvider,
                          backgroundColor: Colors.grey[200],
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(Icons.edit, color: Colors.white),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildProfileDetailRow(
                    Icons.person,
                    'Name',
                    state.userData["name"] ?? "N/A",
                  ),
                  _buildProfileDetailRow(
                    Icons.email,
                    'Email',
                    state.userData['email'] ?? "N/A",
                  ),
                  _buildProfileDetailRow(
                    Icons.phone,
                    'Mobile Number',
                    state.userData['mobile_number'] ?? "N/A",
                  ),
                  _buildProfileDetailRow(
                    Icons.info_outline,
                    'Status',
                    (state.userData['status'] ?? "0") == "1"
                        ? "Active"
                        : "Inactive",
                  ),
                  Divider(height: 30, thickness: 1, color: Colors.black),
                  _buildProfileDetailRow(
                    Icons.calendar_today,
                    'Joined On',
                    _formatDate(state.userData['created_at'] ?? "N/A"),
                  ),
                  _buildProfileDetailRow(
                    Icons.update,
                    'Last Updated',
                    _formatDate(state.userData['updated_at']),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.clear();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.ROUTE_LOGINPAGE,
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                          child: Text(
                            'Logout',
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            if (state is ProfileFailureState) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, color: Colors.red, size: 60),
                        SizedBox(height: 20),
                        Text(
                          'Oops! Something went wrong.',
                          style: GoogleFonts.lato(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "${state.errorMsg}\nPlease check your internet connection and try again.",
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            color: Colors.grey[800],
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
    );
  }

  Widget _buildProfileDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          SizedBox(width: 16),
          Text(
            '$label:',
            style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(width: 8),
          Expanded(child: Text(value, style: GoogleFonts.lato(fontSize: 16))),
        ],
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      DateTime dateTime = DateTime.parse(dateStr);
      return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    } catch (e) {
      return dateStr;
    }
  }
}
