class Response
    def initialize(data)
        @data = data
        json()
    end

    def json
        res = Hash.new
        res["data"] = @data
        res
    end
end
