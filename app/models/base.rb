class Base
    def self.map_to_schema(entity, fields)
        mapped_entity = Hash.new
        fields.each do |field|
            mapped_entity[field] = entity[field]
        end
        mapped_entity
    end
end
