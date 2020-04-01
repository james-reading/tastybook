module ApplicationHelper
    def bootstrap_class_for(flash_type)
    { success: "toast-success", error: "toast-danger", alert: "toast-warning", notice: "toast-info" }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

end
