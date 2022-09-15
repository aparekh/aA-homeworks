class Map
    def initialize
        @my_map = []
    end

    def set(key, value)
        pair_index = my_map.index { |pair| pair[0] == key }
        if pair_index
            my_map[pair_index][1] = value
        else
            my_map.push([key, value])
        end

        value
    end

    def get(key)
        my_map.each { |pair| return pair[1] if pair[0] == key }
        nil
    end
    
    def delete(key)
        value = get(key)
        my_map.reject! { |pair| pair[0] == key }
        value
    end

    def show
        deep_dup(my_map)
    end

    private

    attr_reader :my_map

    def deep_dup(arr)
        arr.map { |el| el.is_a?(Array) ? deep_dup(el) : el }
    end
end