class CreateService
  def initialize(params)
    @errors = []
    @ad = Ad.new(params.slice(:title, :description, :city, :user_id))
  end

  attr_reader :errors, :ad

  def call
    ad.valid? && ad.save!
    fail!(ad.errors)
    self
  end

  def success?
    !failure?
  end

  def failure?
    @errors.any?
  end

  private

  def fail!(messages)
    @errors += Array(messages)
  end
end
