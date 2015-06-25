class TelegramBot
  module AutoFromMethods
    module ClassMethods
      def from(id)
        case id
        when self, Struct
          id
        when nil
          nil
        when Hash
          parse(id)
        when Integer
          new(id)
        else
          warn "unknown stuff passed in [#{id}]"
        end
      end

      def extra_types
        {}
      end

      def hash_key_aliases
        {}
      end

      def parse(hsh)
        obj = new(*parse_attrs(hsh))
        parse_extra_types(obj)
        obj
      end

      private

      def parse_attrs(hsh)
        aliases = hash_key_aliases
        members.map do |attr|
          if aliases.include? attr
            hash_attr = aliases[attr]
          else
            hash_attr = attr
          end
          hsh[attr] || hsh[hash_attr.to_s]
        end
      end

      def parse_extra_types(obj)
        extra_types.each do |attr, typ|
          case typ
          when Class
            obj[attr] = typ.from(obj[attr])
          when Array
            unless obj[attr].nil?
              obj[attr] = obj[attr].map { |x| typ[0].from(x) }
            end
          else
            warn 'unknown type #{type}'
          end
        end
      end

    end

    def self.included(clazz)
      clazz.extend ClassMethods
    end
  end

end
