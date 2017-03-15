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
group = form.create_group! title: '字段组1'
# 创建一个简单字段
params = {
  # 字段标识
  name: 'name',
  # 字段显示名字
  title: '名字',
  # 字段的输入提示
  hint: '随便输入个名字',
  # 字段的数据类型
  data_type: :string,
  # 字段的默认值
  default_value: '张三',
  # 字段的输入方式
  input_type: :text_field,
  # 字段的输入配置
  input_options: {
    # 输入验证
    validations: {
      # 非空
      presence: true,
      # 长度验证
      length: {minimum: 2}
    }
  }
}
group.fields.create! **params

# 再创建一个简单字段
params = {
  # 字段标识
  name: 'phone',
  # 字段显示名字
  title: '手机',
  # 字段的输入提示
  hint: '手机号',
  # 字段的数据类型
  data_type: :string,
  # 字段的输入方式
  input_type: :text_field,
  # 字段的输入配置
  input_options: {
    # 输入验证
    validations: {
      # 非空
      presence: true
    }
  }
}
group.fields.create! **params

# 再创建一个简单字段
# params = {
#   # 字段标识
#   name: 'department',
#   # 字段显示名字
#   title: '部门',
#   # 字段的数据类型
#   data_type: :string,
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
nested_group = group.children.create!
# 再创建一个简单字段
params = {
  # 字段标识
  name: 'started_at',
  # 字段显示名字
  title: '开始时间',
  # 字段的数据类型
  data_type: :time,
  # 字段的输入方式
  input_type: :time_field,
  # 字段的输入配置
  input_options: {
    # 输入验证
    validations: {
      # 非空
      presence: true
    }
  }
}
nested_group.fields.create! **params

# 再创建一个简单字段
params = {
  # 字段标识
  name: 'ended_at',
  # 字段显示名字
  title: '结束时间',
  # 字段的数据类型
  data_type: :time,
  # 字段的输入方式
  input_type: :time_field,
  # 字段的输入配置
  input_options: {
    # 输入验证
    validations: {
      later_than: {field: :started_at},
      options: {
        allow_blank: true
      }
    }
  }
}
nested_group.fields.create! **params

nested_group = group.children.create! title: '清单', options: {repeatable_templete: true}
# 创建一个简单字段
params = {
  # 字段标识
  name: 'item',
  # 字段显示名字
  title: '项目',
  # 字段的数据类型
  data_type: :string,
  # 字段的输入方式
  input_type: :text_field,
  # 字段的输入配置
  input_options: {
    # 输入验证
    validations: {
      # 非空
      presence: true
    }
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
  data_type: :string,
  # 字段的输入方式
  input_type: :number_field,
  # 字段的输入配置
  input_options: {
    # 输入验证
    validations: {
      # 非空
      presence: true,
      numericality: {
        greater_than: 0
      }
    }
  }
}
nested_group.fields.create! **params
