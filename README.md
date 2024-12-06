# E-Commerce App

This is a fully functional **E-Commerce Application** built using **Flutter** for the frontend and **Django** for the backend. The app provides a seamless shopping experience with robust features for browsing, searching, adding to cart, managing addresses, and placing orders. 

---

## Features

### 🌟 General Features
- **User Authentication**
  - Login using unique `loginid`.
  - Session management with SharedPreferences.
  - User role differentiation (`Merchant` and `Customer`).

- **Clean and Intuitive UI**
  - User-friendly navigation and responsive design.
  - Rich product display with images, descriptions, and categories.
  - Interactive icon with a circular background for the app bar.

### 🛍️ Product Features
- **Product Listing**
  - Fetch and display products in a grid format.
  - In-memory caching for product data using Provider to reduce redundant API calls.
  
- **Single Product Page**
  - View detailed product information.
  - Fetch product reviews dynamically when the review section is visible.
  - Toggle favorite products (persist favorites even after app restart).

- **Search Functionality**
  - Search for products by title or category.
  - Efficient backend integration with `SearchService`.

### ❤️ Favorites
- Add or remove products from favorites.
- Favorites are stored persistently using SharedPreferences.

### 🛒 Cart Management
- Add products to the cart with quantity selection.
- Increase or decrease product quantities within the cart.
- Real-time cart updates and item removal.

### 📦 Order Management
- Place orders with selected products and quantities.
- Link orders to a shipping address.
- Dynamic order history linked to user accounts.

### 🌐 Address Management
- Add, edit, and delete shipping addresses.
- Multiple addresses support with an intuitive address form.

### 📸 Media Storage
- Product images are stored and served using **Cloudinary**.

---

## Tech Stack

### 🖥️ Frontend
- **Flutter**
  - State management with **Provider**.
  - UI components with Material Design principles.
  - Navigation and routing for multi-page functionality.

### ⚙️ Backend
- **Django**
  - RESTful APIs with **Django REST Framework (DRF)**.
  - Database models for seamless integration of app features.
  - Secure authentication and role-based access.

### ☁️ Cloud Integration
- **Cloudinary** for image storage.

## Usage

1. Clone or download the project to your local machine.
2. Open a terminal in the project's root directory.
3. Run `flutter pub get` to ensure all dependencies are installed.
4. Build the APK using `flutter build apk` or run on an emulator/device using `flutter run`.

## Contributing

Contributions to this project are welcome. Feel free to open issues or pull requests to enhance the functionality, fix bugs, or improve the user experience.

## License

This project is open-source and available under the [MIT License](LICENSE). You are free to use and modify the code for your purposes.