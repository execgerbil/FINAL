module AuctionsHelper
  def label_class(state)
    case state.to_sym
    when :draft then "label label-default"
    when :published then "label label-primary"
    when :reserve_met then "label label-success"
   
    end
  end

end
