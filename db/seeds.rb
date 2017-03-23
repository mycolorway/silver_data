# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

company = Company.create! name: '彩程设计'

%w(开发部 销售部 人事部).each do |d|
  company.departments.create! name: d
end

# 创建表单记录
form = company.forms.create! title: '样本表单', description: '样本表单，测试各种类型字段的支持情况'
# 创建表单字段组1
group = form.create_group! type: Form::SimpleGroup.to_s, name: :demo
# 创建一个简单字段
params = {
  # 字段标识
  name: 'name',
  # 字段显示名字
  title: '姓名',
  # 字段的输入提示
  hint: '你的姓名',
  # 字段的输入方式
  type: Form::TextField.to_s,
  # 字段的输入配置
  options: {
    # 字段的默认值
    default_value: '张三'
  },
  # 输入验证
  validations: {
    # 非空
    presence: true,
    # 长度验证
    length: {minimum: 2}
  }
}
group.fields.create! **params

# 再创建一个简单字段
params = {
  # 字段标识
  name: 'email',
  # 字段显示名字
  title: '邮箱',
  # 字段的输入提示
  hint: '你的邮箱',
  # 字段的输入方式
  type: Form::EmailField,
  # 字段的输入配置
  options: {},
  # 输入验证
  validations: {
    # 非空
    presence: true
  }
}
group.fields.create! **params

work_group = group.children.create! type: Form::SimpleGroup.to_s, name: :work

# 再创建一个简单字段
# params = {
#   # 字段标识
#   name: 'department',
#   # 字段显示名字
#   title: '部门',
#   # 字段的输入方式
#   input_type: :select,
#   # 字段的输入配置
#   input_options: {
#     data_source: {
#       department: {
#         company_id: 1
#       }
#     }
#   }
# }
# group.fields.create! **params

# 表单的组是一个树形结构
nested_group = work_group.children.create! type: Form::ShallowGroup.to_s, name: :join_and_leave
# 再创建一个简单字段
params = {
  # 字段标识
  name: 'joined_date',
  # 字段显示名字
  title: '加入日期',
  # 字段的输入方式
  type: Form::DateField,
  # 输入验证
  validations: {
    date: {before: :leaved_date},
    allow_blank: true
  }
}
nested_group.fields.create! **params

# 再创建一个简单字段
params = {
  # 字段标识
  name: 'leaved_date',
  # 字段显示名字
  title: '离开日期',
  # 字段的输入方式
  type: Form::DateField
}
nested_group.fields.create! **params

# 表单的组是一个树形结构
nested_group = work_group.children.create! type: Form::SimpleGroup.to_s, name: :address
# 再创建一个简单字段
params = {
  # 字段标识
  name: 'location',
  # 字段显示名字
  title: '地区',
  # 字段的输入方式
  type: Form::TextField,
  # 输入验证
  validations: {
    presence: true
  }
}
nested_group.fields.create! **params

# 再创建一个简单字段
params = {
  # 字段标识
  name: 'address',
  # 字段显示名字
  title: '住址',
  # 字段的输入方式
  type: Form::TextField,
  # 输入验证
  validations: {
    presence: true
  }
}
nested_group.fields.create! **params

nested_group = group.children.create! type: Form::CollectionGroup.to_s, name: :item, options: {title: '清单'}
# 创建一个简单字段
params = {
  # 字段标识
  name: 'item',
  # 字段显示名字
  title: '项目',
  # 字段的输入方式
  type: Form::TextField,
  # 输入验证
  validations: {
    # 非空
    presence: true
  }
}
nested_group.fields.create! **params

nested_group = group.children.create! type: Form::CollectionGroup.to_s, name: :item, options: {title: '清单'}
# 创建一个简单字段
params = {
  # 字段标识
  name: 'item',
  # 字段显示名字
  title: '项目',
  # 字段的输入方式
  type: Form::TextField,
  # 输入验证
  validations: {
    # 非空
    presence: true
  }
}
nested_group.fields.create! **params

# 再创建一个简单字段
params = {
  # 字段标识
  name: 'amount',
  # 字段显示名字
  title: '数量',
  # 字段的输入方式
  type: Form::NumberField,
  # 输入验证
  validations: {
    # 非空
    presence: true,
    numericality: {
      greater_than: 0
    }
  }
}
nested_group.fields.create! **params
