class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "إبحث عن كتابك",
    image: "images/p2.png",
    desc: "أسرع عملية لتوفير الكتب.",
  ),
  OnboardingContents(
    title: "اعرض كتابك المستحدم للبيع",
    image: "images/p3.png",
    desc:"أسرع عملية لتوفير الكتب.",
  ),
  OnboardingContents(
    title: "احصل على أسرع توصيل",
    image: "images/p4.png",
    desc:
    "أسرع عملية لتوفير الكتب.",
  ),
];