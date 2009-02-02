module ProjectsHelper
  def remove_link_unless_new_record(fields)
    unless fields.object.new_record?
      out = ''
      out << fields.hidden_field(:_delete)
      out << link_to_function("remove", "$(this).up('.#{fields.object.class.name.underscore}').hide(); $(this).previous().value = '1'")
      out
    end
  end
  
  # These use the current date, but they could be lots easier.
  # Maybe just keep a global counter which starts at 10 or so.
  # That would be good enough if we only build 1 new record in the controller.
  #
  # And this of course is only needed because Ryan's example uses JS to add new
  # records. If you just build a new one in the controller this is all unnecessary.
  
  def add_task_link(name, form)
    link_to_function name do |page|
      task = render(:partial => 'task', :locals => { :pf => form, :task => Task.new })
      page << %{
        var new_task_id = "new_" + new Date().getTime();
        $('tasks').insert({ bottom: "#{ escape_javascript task }".replace(/new_\\d+/g, new_task_id) });
      }
    end
  end
  
  def add_tag_link(name, form)
    link_to_function name do |page|
      tag = render(:partial => 'tag', :locals => { :pf => form, :tag => Tag.new })
      page << %{
        var new_tag_id = "new_" + new Date().getTime();
        $('tags').insert({ bottom: "#{ escape_javascript tag }".replace(/new_\\d+/g, new_tag_id) });
      }
    end
  end
  
  # tasks has_and_belongs_to_many notes
  def add_note_link( name, form, task )
    link_to_function name do |page|
      note = render(:partial => 'note', :locals => { :tf => form, :tag => Note.new })
      page << %{
        var new_note_id = "new_" + new Date().getTime();
        $('#{ dom_id( task ) }_notes').insert({ bottom: "#{ escape_javascript note }".replace(/new_\\d+/g, new_note_id) });
      }
    end    
  end
  
end
