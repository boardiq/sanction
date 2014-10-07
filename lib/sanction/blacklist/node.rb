module Sanction
  module Blacklist
    class Node < Sanction::Node

      def permitted?
        super
        root? ? true : (@parent[type].permitted? && @parent[type].allowed_ids.include?(id))
      end

      def allow!
        @parent.resources.reject! {|x| x == type } unless @parent[type].count > 1
        unlink
        true
      end

      def deny!
        false
      end

      def whitelist?
        false
      end

      def blacklist?
        true
      end

      def mode
        'blacklist'
      end

      def array_class
        Sanction::Blacklist::Array
      end

      def null_array_class
        Sanction::Blacklist::NullArray
      end

    end
  end
end