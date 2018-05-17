class Request < ApplicationRecord
  validates :name, presence: true, on: :create
  validates :email, presence: true, on: :create
  validates :biography, presence: true, on: :create
  validates :email, uniqueness: true, email: true, on: :create
  validates :phone, format: { with: /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/, message: ' Number must have a length of minimum 7 and maximum 13 numbers' }, on: :create

  default_scope { order(created_at: :asc) }
  scope :accepted, -> { where(accepted: 1) }
  scope :confirmed, -> { where(email_confirmed: 1) }
  scope :unconfirmed, -> { where(email_confirmed: 0) }
  scope :expired, -> { where(expired: 1) }

  def self.accept!
    request = Request.where(accepted: 0).where(expired: 0).where(email_confirmed: 1).first
    request.update(accepted: 1)
  end

  private

  def set_confirmation_token
    if confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  private

  def validate_raise
    self.raised_at = Time.now
    self.confirm_token = nil
  end

  def validate_email
    self.email_confirmed = true
    self.confirm_token = nil
  end

  def self.registration_raise
    request = Request.where(email_confirmed: 1).where(accepted: 0).where(expired: 0).all
    @result = request.where('raised_at BETWEEN ? AND ?', 91.days.ago.beginning_of_day, 91.days.ago.end_of_day)
    @result.each do |r|
      r.send :set_confirmation_token
      r.save(validate: false)
      index = @result.index(r) + 1
      ConfirmMailer.registration_raise(r, index).deliver
    end
  end

  def self.set_to_expired
    withoutConfirm = Request.where(email_confirmed: 0).where('created_at < ?', 8.days.ago)
    withoutRaise = Request.where(expired: 0).where(accepted: 0).where('raised_at < ?', 99.days.ago)
    result = withoutConfirm + withoutRaise
    result.each do |r|
      r.expired = true
      r.save
    end
  end
end
