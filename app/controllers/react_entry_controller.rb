# frozen_string_literal: true

class ReactEntryController < ApplicationController
  # layout "react_entry"

  def index
    @react_entry_props = { data: "This data is injected from the rails controller" }
  end
end
