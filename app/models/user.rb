class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :trackable,
         :validatable, authentication_keys: [:login]

  validates :username,
            presence: true,
            uniqueness: {
              case_sensitive: false
            }

  attr_accessor :login

  has_many :messages, dependent: :destroy
  has_many :received_messages, foreign_key: 'recipient_id', class_name: 'Message'
  has_many :user_dialogs
  has_many :dialogs, through: :user_dialogs

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
    elsif conditions.key?(:username) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end

  def active_for_authentication?
    super && !blocked
  end
end
