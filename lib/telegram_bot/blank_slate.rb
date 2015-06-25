class TelegramBot
  class BlankSlate < Object
    def extend(&block)
      self.singleton_class.class_eval(&block)
    end

    def call(*args, &block)
      self.instance_exec(*args, &block)
    end
  end
end
