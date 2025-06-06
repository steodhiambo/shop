class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products, dependent: :destroy
  has_one :cart, dependent: :destroy
  has_many :payments, dependent: :destroy

  validates :name, presence: true

  # Create a cart for the user after they sign up
  after_create :create_cart

  private

  def create_cart
    Cart.create(user: self)
  end
end
