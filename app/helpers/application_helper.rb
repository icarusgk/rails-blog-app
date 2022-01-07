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

  def my_form_for(records, &block)
    @record = records.is_a?(Array) ? records.last : records

    fields = capture(self, &block)

    unless @record.new_record?
      fields += my_hidden_field_tag('_method', 'patch')
    end

    path = url_for(records)
    attrs = "method='post' action='#{path}'"
    "<form #{attrs}> #{my_authenticity_token_field} #{fields} </form>".html_safe
  end

  def my_label(text)
    my_label_tag(text)
  end

  def name_for(record, attr_name)
    record_class_name = record.class.to_s.underscore
    "#{record_class_name}[#{attr_name}]"
  end

  def my_text_area(attr_name)
    # build the name string
    name  = name_for(@record, attr_name)
    # dynamically grab the attr value off of the @record
    value = @record.read_attribute(attr_name)
    # create and return the HTML string for the tag
    # using our tag helper from before
    my_text_area_tag(name, value)
  end


  def my_text_field(attr_name)
    name  = name_for(@record, attr_name)
    value = @record.read_attribute(attr_name)
    my_text_field_tag(name, value)
  end

  def my_submit
    # decide what the submit text should be
    text = if @record.new_record?
             "Create #{@record.class}"
           else
             "Update #{@record.class}"
           end

    # build and return the tag string
    my_submit_tag(text)
  end


  def my_authenticity_token_field
    my_hidden_field_tag('authenticity_token', form_authenticity_token)
  end
end
