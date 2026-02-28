import 'package:flutter/material.dart';
import 'package:cakli/app/routes/app_pages.dart';
import 'package:get/get.dart';


class EditpinView extends StatefulWidget {
  const EditpinView({super.key});

  @override
  State<EditpinView> createState() => _EditpinViewState();
}

class _EditpinViewState extends State<EditpinView> {
  final TextEditingController _controller = TextEditingController();
  final int pinLength = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBE8E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEBE8E8),
        title: const Text('Edit PIN'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 40),

            Image.asset(
              'assets/images/editpin/icon.png',
              width: 100,
              height: 100,
            ),

            const SizedBox(height: 30),

            Align(
              alignment: Alignment.center,
              child: Text(
                'Masukkan 6 digit PIN baru',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),

          const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black12,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// PIN CIRCLE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(pinLength, (index) {
                      bool isFilled = index < _controller.text.length;
                      return Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey),
                          color: isFilled ? Colors.black : Colors.transparent,
                        ),
                      );
                    }),
                  ),

                  /// Hidden TextField
                  Offstage(
                    offstage: true,
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      maxLength: pinLength,
                      buildCounter:
                          (
                            context, {
                            required currentLength,
                            required isFocused,
                            maxLength,
                          }) => null,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Lupa PIN',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepOrange,
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Get.toNamed(Routes.SETTING);
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFE04D04),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Selanjutnya',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
