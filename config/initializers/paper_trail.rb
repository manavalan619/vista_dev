PaperTrail.config.track_associations = false
PaperTrail.serializer = PaperTrail::Serializers::JSON

PaperTrail::Version.class_eval do
  def changed_object
    @changed_object ||= JSON.parse(object, object_class: OpenStruct)
  end

  def changes_object
    @changes_object ||= JSON.parse(object_changes, object_class: OpenStruct)
  end
end
