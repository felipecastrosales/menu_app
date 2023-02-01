import 'package:flutter/material.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({
    super.key,
    required this.page,
    required this.onChanged,
  });

  final int page;
  final Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[900]!,
            offset: const Offset(1, 1),
            blurRadius: 10,
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                alignment: Alignment(
                  page == 0 ? -1 : 1,
                  0,
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: constraints.maxWidth / 2,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.horizontal(
                      left: page == 0 ? const Radius.circular(24) : Radius.zero,
                      right:
                          page == 0 ? Radius.zero : const Radius.circular(24),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      clipBehavior: Clip.antiAlias,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(24),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          onChanged(0);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                            Text(
                              'Home',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      clipBehavior: Clip.antiAlias,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(24),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          onChanged(1);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                            Text(
                              'Cardápio',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
