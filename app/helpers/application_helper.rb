module ApplicationHelper
  def edit_current_users_profile_path
    if current_user.nil?
      nil
    elsif current_user.student_profile_id.nil?
      edit_staff_profile_path(current_user.staff_profile_id)
    else
      edit_student_profile_path(current_user.student_profile_id)
    end
  end
end
