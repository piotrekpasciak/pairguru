class BaseService
  CONNECTION_ERRORS = [
    Timeout::Error, Errno::EINVAL, Errno::ECONNRESET,
    Errno::ECONNREFUSED, EOFError, Net::HTTPBadResponse,
    Net::HTTPHeaderSyntaxError, Net::ProtocolError
  ].freeze

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
