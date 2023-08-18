class User < ApplicationRecord
  # Validations
  validates :name, :phone, :identity_card, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }

  # CSV generation for users
  def self.to_csv
    attributes = %w[id name email phone identity_card address]
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.order(:id).each do |user|
        csv << attributes.map { |attr| user.send(attr) }
      end
    end
  end
end
