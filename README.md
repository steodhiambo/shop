
## Overview
Shop is a fully functional e-Commerce web application built using Ruby on Rails 7.1. Users can create accounts, post ads for selling products, manage a shopping cart, and complete purchases using Stripe payment processing. The application features user authentication with Devise, a robust shopping cart system with session persistence, and a complete payment workflow.

##  COMPLETED IMPLEMENTATION

This implementation includes ALL the required features from the project specifications:

###  User Authentication (Devise)
- ** Registrations Controller**: Complete with `sign_up_params` and `account_update_params`
- ** User Model**: Includes name field and proper validations
- ** Authentication Views**: Sign up, sign in, edit profile pages

###  Product Management
- ** Products Helper**: Shows seller names and restricts edit/delete to creators only
- ** Product Model**: Full CRUD with brand, condition, color, price, description
- ** Product Views**: Create, edit, view, and list products with image support
- ** Image Upload**: CarrierWave integration with image processing

###  Shopping Cart System
- ** Cart Model**: Add/remove items, calculate totals, empty cart functionality
- ** Cart Items**: Individual item management with quantities
- ** Current Cart Concern**: Session persistence for anonymous users
- ** Cart Merging**: Seamless cart transfer when users sign in
- ** Cart Icon**: Dynamic item count display in navigation
- ** Flash Messages**: "Added to cart" / "Removed from cart" notifications

###  Payment System (BONUS REQUIREMENT)
- ** Stripe Integration**: Complete payment processing with Stripe
- ** Payment Model**: Track payment status and history
- ** Checkout Flow**: Secure payment form with card processing
- ** Payment Confirmation**: Success pages and payment tracking

## Features
- **User Authentication**: Users can sign up, sign in, and update their account details using Devise.
- **Product Ads**: Authenticated users can create, edit, and delete ads for products, including details like title, price, model, description, brand, color, condition, and images.
- **Shopping Cart**: A fully functional cart system that allows users to add/remove items, view a total price, and empty the cart. The cart persists across sessions, even for unauthenticated users.
- **Cart Notifications**: Displays "Added to your cart" and "Removed from your cart" messages that auto-disappear after a short time.
- **Cart Icon**: A homepage icon displays the number of items in the cart, updating dynamically as items are added or removed.
- **Seller Information**: Product ads display the seller's name, with edit and delete permissions restricted to the ad creator.
- **Bonus Features (Optional)**:
  - Product categories (e.g., cars, clothes, computers).
  - Additional product fields (e.g., more brands).
  - "Add to Cart" button directly from the product listing.
  - One-by-one item removal from the cart.
  - Custom UI/UX design.
  - Payment method integration.

## Installation
### Prerequisites
- Ruby (version compatible with Rails, e.g., 3.2.x)
- Rails (version specified in Gemfile, e.g., 7.x)
- SQLite (or other database specified in `config/database.yml`)
- Node.js and Yarn (for JavaScript dependencies)
- Devise gem for authentication

### Steps
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/steodhiambo/shop.git
   cd shop
   ```

2. **Install Dependencies**:
   ```bash
   bundle install
   yarn install
   ```

3. **Set Up the Database**:
   ```bash
   rails db:setup
   rails db:migrate
   ```

4. **Configure Devise**:
   - Ensure Devise is included in the Gemfile (`gem 'devise'`) and installed.
   - Run `rails generate devise:install` if not already set up.
   - Generate the User model: `rails generate devise User`.
   - Add necessary fields to the User model (e.g., `name`) via a migration.

5. **Start the Server**:
   ```bash
   rails server
   ```
   Access the application at `http://localhost:3000`.

## Usage
1. **User Registration**:
   - Navigate to the sign-up page and create an account with a name, email, password, and password confirmation.
   - Update account details via the account settings page.

2. **Creating Ads**:
   - Click the "Sell" button (available to authenticated users).
   - Fill in the ad form with:
     - Title
     - Price
     - Model
     - Description
     - Brand (select from predefined options)
     - Color (select from predefined options)
     - Condition (select from predefined options)
     - Images (choose from `app/assets/images`)
   - Submit to create the ad.

3. **Managing Ads**:
   - Only the ad creator can edit or delete their ads.
   - Seller names are displayed on each product ad via the `products_helper.rb`.

4. **Shopping Cart**:
   - Add products to the cart from the product ad page or (if implemented) directly from the product listing.
   - View the cart to see items, total price, and options to:
     - Remove individual items.
     - Empty the cart (redirects to the homepage).
   - The cart icon on the homepage shows the current item count.
   - Notifications appear briefly when adding/removing items.

5. **Cart Persistence**:
   - The `current_cart.rb` concern ensures cart contents persist for unauthenticated users and merge with the user's cart upon signing in.

## Project Structure
### Key Files and Directories
- **Controllers**:
  - `app/controllers/registrations_controller.rb`: Custom Devise controller for user sign-up and account updates.
- **Models**:
  - `app/models/cart.rb`: Model for the shopping cart.
  - `app/models/concerns/current_cart.rb`: Concern for managing cart persistence across sessions.
- **Helpers**:
  - `app/helpers/products_helper.rb`: Helper for displaying seller information and restricting edit/delete actions to ad creators.
- **Assets**:
  - `app/assets/images`: Directory for product images.
- **Views**:
  - Devise views for authentication (e.g., sign-up, sign-in).
  - Product ad views for creating/editing ads.
  - Cart views for managing the shopping cart.

### Implemented Features
1. **Registrations Controller**:
   - `sign_up_params`: Permits `name`, `email`, `password`, `password_confirmation`.
   - `account_update_params`: Permits `name`, `email`, `password`, `password_confirmation`, `current_password`.

2. **Products Helper**:
   - Displays the seller's name on each product ad.
   - Restricts edit/delete actions to the ad creator.

3. **Cart Model**:
   - Supports adding/removing items, calculating totals, and emptying the cart.
   - Includes individual item removal and dynamic total updates.
   - Displays flash messages for add/remove actions that auto-disappear.
   - Integrates with a homepage cart icon showing the item count.

4. **Current Cart Concern**:
   - Persists cart contents for unauthenticated users.
   - Merges cart contents with the user's cart upon sign-in.

## Contributing
1. Fork the repository.
2. Create a feature branch (`git checkout -b feature/your-feature`).
3. Commit your changes (`git commit -m "Add your feature"`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Open a pull request with a detailed description of your changes.

### Development Guidelines
- Follow Ruby on Rails conventions.
- Write tests for new features (e.g., using RSpec or Minitest).
- Ensure code passes RuboCop linting.
- Document any new methods or classes in the code.

## Bonus Features (Optional)
To enhance the application, the following are implemented:
- **Product Categories**: Allow users to categorize products (e.g., cars, clothes, computers).
- **Additional Product Fields**: Add more brands or other descriptive fields.
- **Direct Add to Cart**: Add a button to add products to the cart from the product listing.
- **Granular Item Removal**: Ensure intuitive one-by-one item removal from the cart.
- **Custom Design**: Improve the UI/UX with Tailwind CSS or custom styles.
- **Payment Integration**: Integrate a payment gateway (e.g., Stripe).

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.

## Contact
For questions or support, contact the project maintainer at stephenoginga6@gmail.com