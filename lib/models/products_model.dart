import 'package:minimart_app/constants/app_images.dart';
import 'package:minimart_app/models/product.dart';

List<Product> sampleProducts = [
  Product(
    id: '1',
    title: 'Apple iPhone 16 ',
    imageUrl: AppImages.iphone_16,
    price: 700.00,
    color: 'Teal',
    storage: '128GB',
    description:
        "This pre-owned product is not Apple certified, but has been professionally inspected, tested and cleaned by Amazon-qualified suppliers;There will be no visible cosmetic imperfections, when held at an arm’s length  There will be no visible cosmetic imperfections when held at an arm’s length.",
  ),
  Product(
    id: '2',
    title: 'M4 Macbook Air 13"',
    price: 1000.00,
    imageUrl: AppImages.macbook,
    color: 'Sky Blue',
    storage: '256GB',
  ),
  Product(
    id: '3',
    title: 'Google Pixel 9A',
    price: 499.00,
    imageUrl: AppImages.googlePixel,
    color: 'Iris',
    storage: '128GB',
  ),
  Product(
    id: '4',
    title: 'Apple Airpods 4',
    price: 129.00,
    imageUrl: AppImages.airpod,
    color: '',
    storage: 'Active Noise Cancellation',
  ),
];
