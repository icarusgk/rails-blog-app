module ApplicationHelper
  def my_hidden_field_tag(name, value)
    "<input name='#{name}' value='#{value}' type='hidden'".html_safe
  end

  def my_label_tag(txt)
    "<label>#{txt}</label>".html_safe
  end

  def my_text_field_tag(name, value)
    "<input name='#{name}' value='#{value}' type='text' />".html_safe
  end

  def my_text_area_tag(name, value)
    "<textarea name='#{name}'>#{value}</textarea>".html_safe
  end

  def my_submit_tag(txt="Submit")
    "<input type='submit' value='#{txt}'>".html_safe
  end


  def my_form_tag(path, &block)
    attrs = "method='post' action='#{path}'"
    # We use capture to trap the block's return value in a variable
    fields = capture(&block)

    "<form #{attrs}> #{my_authenticity_token_field} #{fields} </form>".html_safe
  end

  def my_authenticity_token_field
    my_hidden_field_tag('authenticity_token', form_authenticity_token)
  end
end
