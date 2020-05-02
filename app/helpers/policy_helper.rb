module PolicyHelper
  def edit?(resouce)
    @edit_policy ||= policy(resouce).edit?
  end
end
