class SpikesController < InheritedResources::Base
  def create
    @spike = Spike.new(params[:spike])

    if @spike.save
      redirect_to spikes_url
    else
      render action: "new"
    end
  end
end
