module ApplicationHelper
  def lock_link_for(model)
    model_path = Array[*model].map {|model| model.class.name.tableize.singularize }.join('_').tr('/','_')
    current_model = Array[*model].last
    if current_model.locked_at
      link_to('已锁定', send("unlock_#{model_path}_path", *model), method: :post, data: { confirm: '确定解锁当前用户吗？' }, remote: true, title: '点击解锁', class: 'locked-yes')
    else
      link_to('未锁定', send("lock_#{model_path}_path", *model), method: :post, data: { confirm: '确定锁定当前用户吗？' }, remote: true, title: '点击锁定', class: 'locked-no')
    end
  end
end
