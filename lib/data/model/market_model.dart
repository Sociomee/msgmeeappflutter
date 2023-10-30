class MarketModel {
  final String imageUrl;
  final String title;
  final String industry;
  final String price;
  final String? isSelling;
  final bool? sold;
  MarketModel({
    required this.imageUrl,
    required this.title,
    required this.industry,
    required this.price,
    this.isSelling,
    this.sold,
  });
}

List<MarketModel> marketlist = [
  MarketModel(
    imageUrl:
        'https://w7.pngwing.com/pngs/154/370/png-transparent-dxracer-gaming-chair-video-game-resident-evil-zero-chair.png',
    title: 'Gaming Chair, local pickup',
    industry: 'Technology',
    price: '\$200',
    sold: false,
  ),
  MarketModel(
    imageUrl:
        'https://e7.pngegg.com/pngimages/217/151/png-clipart-uncharted-4-a-thief-s-end-uncharted-the-nathan-drake-collection-sony-playstation-4-others-miscellaneous-gadget.png',
    title: 'Playstation 4 Limited Edition',
    industry: 'Technology',
    price: '\$200',
    sold: false,
  ),
  MarketModel(
    imageUrl:
        'https://cdn.shopify.com/s/files/1/2358/2817/products/air-jordan-1-retro-high-top-3-534340.png?v=1638813029',
    title: 'Air Jordan 1 Top 3 Sneaker',
    industry: 'Food & drink',
    price: '\$200',
    sold: true,
  ),
  MarketModel(
    imageUrl:
        'https://i1.wp.com/discountsqatar.com/wp-content/uploads/2018/11/hey-min-157.png?fit=500%2C500&ssl=1',
    title: 'iPad Pro 2017 Model',
    industry: 'Real estate activities',
    price: '\$200',
    sold: false,
  ),
  MarketModel(
    imageUrl:
        'https://stylecaster.com/wp-content/uploads/2021/09/coach-pillow-tabby-silver.png?w=670',
    title: "Coach Tabby 26 for sale",
    industry: 'Real estate activities',
    price: '\$200',
    isSelling: 'selling',
    sold: false,
  ),
  MarketModel(
    imageUrl:
        'https://w7.pngwing.com/pngs/622/14/png-transparent-star-wars-lego-poster-lego-star-wars-iii-the-clone-wars-anakin-skywalker-yoda-star-wars-star-wars-episode-vii-poster-logo.png',
    title: "Lego Star'War edition",
    industry: 'Food & drink',
    price: '\$200',
    isSelling: 'selling',
    sold: false,
  ),
  MarketModel(
    imageUrl:
        'https://www.freepnglogos.com/uploads/macbook-png/macbook-cleanmymac-the-best-mac-cleanup-app-for-macos-get-32.png',
    title: 'Macbook Pro 16 inch (2020)',
    industry: 'Real estate activities',
    price: '\$200',
    sold: false,
  ),
  MarketModel(
    imageUrl:
        'https://e7.pngegg.com/pngimages/332/438/png-clipart-eames-lounge-chair-charles-and-ray-eames-herman-miller-the-local-vault-chair-angle-furniture.png',
    title: 'Heimer Miller Sofa (Mint Condition)',
    industry: 'Real estate activities',
    price: '\$200',
    isSelling: 'selling',
    sold: false,
  ),
];
