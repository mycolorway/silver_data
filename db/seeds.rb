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
group = form.create_group! name: :demo, variant: :normal
# 创建一个简单字段
params = {
  # 字段标识
  name: 'name',
  # 字段显示名字
  title: '姓名',
  # 字段的输入提示
  hint: '你的姓名',
  # 字段的数据类型
  store_type: :string,
  # 字段的默认值
  default_value: '张三',
  # 字段的输入方式
  input_type: :text_field,
  # 字段的输入配置
  input_options: {},
  # 输入验证
  validation_options: {
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
  # 字段的数据类型
  store_type: :string,
  # 字段的输入方式
  input_type: :email_field,
  # 字段的输入配置
  input_options: {},
  # 输入验证
  validation_options: {
    # 非空
    presence: true
  }
}
group.fields.create! **params

nested_group = group.children.create! name: :work, variant: :normal

# 再创建一个简单字段
# params = {
#   # 字段标识
#   name: 'department',
#   # 字段显示名字
#   title: '部门',
#   # 字段的数据类型
#   store_type: :string,
#   # 字段的输入方式
#   input_type: :select,
#   # 字段的输入配置
#   input_options: {
#     # 输入验证
#     validations: {
#       # 非空
#       presence: true
#     },
#     data_source: {
#       department: {
#         company_id: 1
#       }
#     }
#   }
# }
# group.fields.create! **params

# 表单的组是一个树形结构
nested_group = nested_group.children.create! name: :join_and_leave, variant: :combination
# 再创建一个简单字段
params = {
  # 字段标识
  name: 'joined_date',
  # 字段显示名字
  title: '加入日期',
  # 字段的数据类型
  store_type: :date,
  # 字段的输入方式
  input_type: :date_field,
  # 输入验证
  validation_options: {
    early_than: {field: 'started_at'},
    options: {
      allow_blank: true
    }
  }
}
nested_group.fields.create! **params

# 再创建一个简单字段
params = {
  # 字段标识
  name: 'leaved_at',
  # 字段显示名字
  title: '离开日期',
  # 字段的数据类型
  store_type: :date,
  # 字段的输入方式
  input_type: :date_field
}
nested_group.fields.create! **params

nested_group = group.children.create! name: :item, variant: :collection, options: {title: '清单'}
# 创建一个简单字段
params = {
  # 字段标识
  name: 'item',
  # 字段显示名字
  title: '项目',
  # 字段的数据类型
  store_type: :string,
  # 字段的输入方式
  input_type: :text_field,
  # 输入验证
  validation_options: {
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
  # 字段的数据类型
  store_type: :string,
  # 字段的输入方式
  input_type: :number_field,
  # 输入验证
  validation_options: {
    # 非空
    presence: true,
    numericality: {
      greater_than: 0
    }
  }
}
nested_group.fields.create! **params
