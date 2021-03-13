class SourceTrackersController < ApplicationController
  def index
    @source_trackers = SourceTracker.all
  end
end
