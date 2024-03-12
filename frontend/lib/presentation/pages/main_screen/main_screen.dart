import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/component/icons/cards_icon_main.dart';
import 'package:frontend/core/utils/component/icons/close_circle.dart';
import 'package:frontend/core/utils/component/icons/home_icon_main.dart';
import 'package:frontend/core/utils/component/icons/my_icon.dart';
import 'package:frontend/core/utils/component/icons/sound_icon.dart';
import 'package:frontend/main.dart';
import 'package:frontend/presentation/pages/card/card_page.dart';
import 'package:frontend/presentation/pages/home/component/background/back_ground_below.dart';
import 'package:frontend/presentation/pages/home/component/background/background_screen.dart';
import 'package:frontend/presentation/pages/home/component/background/background_upper.dart';
import 'package:frontend/presentation/pages/home/home_page.dart';
import 'package:frontend/presentation/pages/quiz/quiz_page.dart';
import 'package:indexed/indexed.dart';



class MainScreen extends StatefulWidget {
  final String? id;

  const MainScreen({this.id, super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;
  bool _isLoading = true; // Initial state is loading

  @override
  void initState() {
    super.initState();
    _updateSelectedIndex();

    assetsAudioPlayer.play();

  }

  @override
  void didUpdateWidget(covariant MainScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.id != oldWidget.id) {
      _isLoading = true; // Reset loading state on widget update
      _updateSelectedIndex();
    }
  }

  void _updateSelectedIndex() {
    // Simulate an asynchronous operation with a post frame callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final String pageIndex = widget.id ?? '0';
      try {
        setState(() {
          _selectedIndex = int.parse(pageIndex);
          _isLoading = false; // Loading complete
        });
      } on FormatException {
        setState(() {
          _selectedIndex = 0; // Default value in case of parsing error
          _isLoading = false; // Loading complete
        });
      }
    });
  }


  final List<Widget> _pages = [
    const WidgetForHomeButton(),
    const WidgetForCardButton(),
    const WidgetForQuizButton(),
  ];

  final List _icons = [
    const CardsIconMain(),
    const HomeIconMain(),
    const HomeIconMain(),
  ];

  void _onButtonPressed(int i) {
    setState(() {
      _selectedIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: BackgroundScreen(),
      );
    }

    return Scaffold(
      body: Indexer(
        children: [
          const Indexed(index: -5, child: BackGroundBelow()),
          Indexed(
            index: 0,
            child: IndexedStack(
              index: _selectedIndex,
              children: _pages,
            ),
          ),
          Indexed(
            index: 1000,
            child: Positioned(
              top: MediaQuery.of(context).size.height * 0.02,
              right: MediaQuery.of(context).size.width * 0.01,
              child: Row(
                children: [
                  IconButton(
                    icon: _icons[_selectedIndex], // replace with actual icons
                    onPressed: () => _selectedIndex == 0
                        ? _onButtonPressed(1)
                        : _onButtonPressed(0),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                  const MyIcon(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                  SoundIcon(assetsAudioPlayer),
                ],
              ),
            ),
          ),
          (_selectedIndex == 1)
              ? Indexed(
                  index: 1000,
                  child: Positioned(
                    top: MediaQuery.of(context).size.height * 0.12,
                    right: MediaQuery.of(context).size.width * 0.1,
                    child: GreenButton(
                      "문제 풀기",
                      onPressed: () => _onButtonPressed(2),
                    ),
                  ),
                )
              : Container(),
          (_selectedIndex == 2)
              ? Indexed(
                  index: 1000,
                  child: Positioned(
                    top: MediaQuery.of(context).size.height * 0.1,
                    right: MediaQuery.of(context).size.width * 0.065,
                    child: IconButton(
                        icon: const CloseCircle(),
                        onPressed: () => _onButtonPressed(1)),
                  ),
                )
              : Container(),
          const Indexed(index: 100, child: BackgroundUpper())
        ],
      ),
    );
  }
}

class WidgetForHomeButton extends StatelessWidget {
  const WidgetForHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: HomePage(),
    );
  }
}

class WidgetForCardButton extends StatelessWidget {
  const WidgetForCardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CardPage(),
    );
  }
}

class WidgetForQuizButton extends StatelessWidget {
  const WidgetForQuizButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: QuizPage(),
    );
  }
}
