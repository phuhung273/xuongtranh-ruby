
class HashUtil

    def self.to_hash_array_with_names(hash, *names)
        
        hash.each_with_object([]) do |(key, value), arr|
            first_name, *other_names = names
            child_hash = {}
            child_hash[first_name] = key
            second_name = other_names.first

            if value.respond_to?(:keys)
                second_name = second_name.pluralize
                child_hash[second_name] = to_hash_array_with_names(value, *other_names)
            else
                child_hash[second_name] = value
            end

            arr.push(child_hash)
        end
    end

end