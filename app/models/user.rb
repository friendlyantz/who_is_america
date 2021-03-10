class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :quotes, class_name: "Quote", foreign_key: "creator_id" #this is for adding new quotes for website
  has_many :votes
  has_many :user_trackers

  enum permissions: [:user, :moderator, :admin]

  validates :permissions, presence: true
  # has_many :voted_quotes, through: :votes, class_name: "Quote", foreign_key: "quote_id" # UNSURE if this is correct and neccessary. might be easier to:
  # 1. access User.votes 
  # 2a. loop though each VOTE to access QUOTE per vote -> 
  # 2b. Quote.politician
end
