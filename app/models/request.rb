class Request < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :biography, presence: true
  validates :email, uniqueness: true, email: true
  validates :phone, format: { with: /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/, message: ' Number must have a length of minimum 7 and maximum 13 numbers' }

  default_scope { order(created_at: :asc) }
  scope :accepted, -> { where(accepted: true) }
  scope :confirmed, -> { where(email_confirmed: true) }
  scope :unconfirmed, -> { where(email_confirmed: false) }
  scope :expired, -> { where(expired: true) }

  before_save do
    self.set_confirmation_token
    self.raised_at = Time.now
  end

  def self.accept!
    request = Request.where(accepted: false).where(expired: false).where(email_confirmed: true).first
    request.update(accepted: true)
  end

  def set_confirmation_token
    if confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def validate_raise
    self.raised_at = Time.now
    self.confirm_token = nil
  end

  def validate_email
    self.email_confirmed = true
    self.confirm_token = nil
  end

  def self.registration_raise
    request = Request.where(email_confirmed: true).where(accepted: false).where(expired: false).all
    @result = request.where('raised_at BETWEEN ? AND ?', 91.days.ago.beginning_of_day, 91.days.ago.end_of_day)
    @result.each do |r|
      r.set_confirmation_token
      r.save
      index = @result.index(r) + 1
      ConfirmMailer.registration_raise(r, index).deliver
    end
  end

  def self.set_to_expired
    without_confirm = Request.where(email_confirmed: false).where('created_at < ?', 8.days.ago)
    without_raise = Request.where(expired: false).where(accepted: false).where('raised_at < ?', 99.days.ago)
    result = without_confirm + without_raise
    result.each do |r|
      r.expired = true
      r.save
    end
  end
end
