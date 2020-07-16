module ActiveDuty
  module Initializers
    extend ActiveSupport::Concern
    module ClassMethods
      def init_with(*args)
        kwargs = args.extract_options!

        if kwargs.empty?
          init_from_ordered(args)
        else
          init_from_kw(kwargs)
        end

      end

      private

      # initialize from ordered arguments
      #
      # init_with :username, :password
      # def initialize(username, password)
      #   @username = username
      #   @password = password
      #
      # init_with [:username], [:password, nil], [:email, "no email"], [:options, {}]
      # def initialize(username, password = nil, email: "no email", options = {})
      #   @username = username
      #   @password = password
      #   @email = email
      #   @options = options
      def init_from_ordered(args)
        define_method :initialize do |*initialize_args|
          args.zip(initialize_args) do |name, value|
            instance_variable_set("@#{name}", value)
          end
          self.class.attr_reader *args
        end
      end

      # Initialize with keyword args.
      #
      # { username: :user } will
      #   def initialize(username:)
      #     @user = username
      #
      # { username: ["Bob", :user] } will
      #   def initialize(username: "Bob")
      #     @user = username
      def init_from_kw(args)
        class_eval <<-METHOD, __FILE__, __LINE__ + 1
            def initialize(#{args.map { |key, values| "#{key}: #{values[0] if values.is_a?(Array)}" }.join(', ')})
              #{args.map { |key, values|
          if values.is_a?(Array)
            "instance_variable_set(:\"@#{values[1]}\", #{key}) 
                  self.class.attr_reader :#{values[1]}"
          else
            "instance_variable_set(:\"@#{values}\", #{key}) 
                  self.class.attr_reader :#{values}"
          end
        }.join("\n")
        }
            end
        METHOD
      end

    end

  end
end
