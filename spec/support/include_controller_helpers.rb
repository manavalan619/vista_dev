def add_controller_helpers *controllers
  controllers.each { |c| view.singleton_class.class_eval { include c.new._helpers } }
end
