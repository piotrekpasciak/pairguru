class BaseService
  Result = Struct.new(:success, :value) do
    def success?
      success
    end

    def failure?
      !success
    end
  end

  private

  def success(value = nil)
    Result.new(true, value)
  end

  def failure(value = nil)
    Result.new(false, value)
  end
end
