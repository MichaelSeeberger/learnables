class CourseSectionsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    @course = Course.find(params[:id])
    unless policy.rearrange_sections?
      reject
      return
    end

    stream_for @course
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def move_section(data)
    sections = @course.move_section! data['from'], data['to']
    CourseSectionsChannel.broadcast_to @course, {sections: sections}
  end

  private
  def policy
    CoursePolicy.new(current_user, @course)
  end
end
