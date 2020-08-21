module Versions
  class Base < PaperTrail::Version
    include PaperTrailUser
    include VersionsTable
  end
end
