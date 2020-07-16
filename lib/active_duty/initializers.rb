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
        init_string = []
        args.each do |arg|
          str = ""
          if arg.is_a?(Array)
            if arg.size == 2
              if arg[1].is_a?(String)
                str << "#{arg[0]} = \"#{arg[1]}\""
              else
                str << "#{arg[0]} = #{arg[1]}"
              end
            else
              str << "#{arg[0]}"
            end
          else
            str << "#{arg}"
          end
          init_string << str
        end
        class_eval <<-METHOD, __FILE__, __LINE__ + 1
            def initialize(#{init_string.join(', ')})
              #{args.map { |arg|
          if arg.is_a?(Array)
            "instance_variable_set(:\"@#{arg[0]}\", #{arg[0]}) 
                  self.class.attr_reader :#{arg[0]}"
          else
            "instance_variable_set(:\"@#{arg}\", #{arg}) 
                  self.class.attr_reader :#{arg}"
          end
        }.join("\n")
        }
            end
        METHOD
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

        initializer_string = []
        args.each do |key, values|
          str = "#{key}:"
          if values.is_a?(Array) && values.size == 2
            if values[0].is_a?(String)
              str += " \"#{values[0]}\""
            else
              str += "#{values[0]}"
            end
          end
          initializer_string << str
        end
        class_eval <<-METHOD, __FILE__, __LINE__ + 1
            def initialize(#{initializer_string.join(', ')})
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
