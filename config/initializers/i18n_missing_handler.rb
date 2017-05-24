module I18n
  class JustRaiseExceptionHandler < ExceptionHandler
    def call(exception, locale, key, options)
      if exception.is_a?(MissingTranslation)
        SlackNotifier.ping(exception.to_exception)
      end
      super
    end
  end
end
I18n.exception_handler = I18n::JustRaiseExceptionHandler.new
