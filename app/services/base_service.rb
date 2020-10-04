# frozen_string_literal: true

module BaseService
  module ClassMethods
    def call(*args)
      new(*args).call
    end
  end

  def self.prepended(base)
    base.extend ClassMethods
  end

  attr_reader :result, :errors

  def initialize(*args)
    super(*args)
    @errors = []
  end

  def call
    self.result = super
    self
  end

  def success?
    !failure?
  end

  def failure?
    @errors.any?
  end

  def error_message
    @errors.join('; ')
  end

  private

  attr_writer :result

  def fail!(messages)
    @errors += Array(messages)
    self
  end
end
