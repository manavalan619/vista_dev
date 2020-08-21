module Api::V1
  class ReleasesController < Api::V1::BaseController
    def check
      release = Release.latest_timestamp

      render json: { version: release.to_i }
    end

    def latest
      release = Release.latest

      if release
        render json: release.file.read
      else
        render json: { version: nil, categories: [], questions: [] }
      end
    end
  end
end
