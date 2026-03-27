class OnboardingPage {
  final String imagePath;
  final String title;
  final String titleHighlight;
  final String description;

  const OnboardingPage({
    required this.imagePath,
    required this.title,
    required this.titleHighlight,
    required this.description,
  });
}



const List<OnboardingPage> pages = [
  OnboardingPage(
    imagePath: 'assets/images/Professional athlete running.png',
    title: 'Track Your',
    titleHighlight: 'Journey',
    description:
        'Real-time step tracking and deep insights to help you understand your movement patterns and hit your daily goals.',
  ),
  OnboardingPage(
    imagePath: 'assets/images/Professional athlete running.png',
    title: 'Analyze Your',
    titleHighlight: 'Performance',
    description:
        'Dive deep into your metrics, compare sessions, and unlock the data you need to crush every personal record.',
  ),
  OnboardingPage(
    imagePath: 'assets/images/Professional athlete running.png',
    title: 'Reach Your',
    titleHighlight: 'Goals',
    description:
        'Set targets, stay consistent, and celebrate every milestone on your path to peak athletic achievement.',
  ),
];