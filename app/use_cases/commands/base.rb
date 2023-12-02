module Commands
  module Base
    def call(...)
      __send__(:new, ...).__send__(:perform)
    end

    def self.extended(mod)
      mod.private_class_method :new
    end
  end
end
