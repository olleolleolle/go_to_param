require "go_to_param/version"

module GoToParam
  def self.included(klass)
    klass.helper_method :hidden_go_to_tag,
      :go_to_hash, :build_go_to_hash,
      :go_to_path, :go_to_path_or
  end

  def hidden_go_to_tag
    view_context.hidden_field_tag :go_to, go_to_path
  end

  def go_to_hash(other_params = {})
    { go_to: go_to_path }.merge(other_params)
  end

  def build_go_to_hash
    if request.get?
      { go_to: request.fullpath }
    else
      {}
    end
  end

  def go_to_path
    # Avoid phishing redirects.
    if go_to_param_value.to_s.start_with?("/")
      go_to_param_value
    else
      nil
    end
  end

  def go_to_path_or(default)
    go_to_path || default
  end

  private

  def go_to_param_value
    params[:go_to]
  end
end
