# README

这个项目演示了一种动态表单实现的思路。数据结构定义出于演示目的进行了简化，但提出了概要设计。

##  初始化

- `git clone`
- `bundle`
- `rake db:migrate && rake db:seed`
- `bin/rails s`
- <http://localhost:3000/companies/1/forms/1/preview>

## 关键文件

- `db/seeds.rb` 样本数据
- `app/controllers/companies/forms/previews_controller.rb#build_form_model` 动态生成模型类算法示例
- `app/views/companies/forms/previews/_form.erb` 动态生成模型的渲染算法示例

## 目标

- 动态定义、编辑表单
- 支持单个字段和整体两个层次的数据验证
- 易于扩展控件
- 支持类似"明细"的变长字段

## 原理

Rails 的模型包含了字段、结构化关系和数据验证的支持，并在视图渲染提供了各种方便。
一切表单都可以通过模型来定义、表达，但是模型的定义是静态的，如果能够找到一种方法去动态定义符合 Rails 标准的模型，
就可以把绝大多数工作交给框架完成。

结构化数据关系可以映射成模型间的关系，比如描述"员工信息"的表单
，其含有"姓名"、"性别"等个人信息字段、还有"所属部门"、"汇报人"等公司工作信息字段，还有"教育经历"这种可变长度字段，可抽象为

```ruby
class WorkingInformation
  attribute :department_id, :string # 所属部门ID
  attribute :leader_id, :string # 负责领导ID
end

class EducationHistory
  attribute :from, :date # 开始学习日期
  attribute :due, :date # 毕业日期
  attribute :description, :string # 描述
  
  validates :from, presence: true # 开始学习日期必须存在
  validates :description, presence: true # 描述必须存在
  validates :due, date: {later: :from}, allow_blank: true # 毕业日期可不存在（在读），如果存在，要比"开始学习"的日期晚
end

class Empolyee
  has_one :working_infomation # 工作信息
  has_many :education_histories # 多条教育经历
  
  # 若干员工基本信息
  attribute :name, :string
  attribute :birthday, :date
  
  # 若干对员工基本信息的数据验证
  validates :name, presence: true
end
```

原理上，如何存储表单数据都是可以的，如粗暴的直接序列化表单定义，只要设计并实现一个反序列化算法，将定义转化成表单模型类即可。

## 概要设计

### （基本的）表单描述

使用多条数据库记录来描述表单模型，抽象为三种模型：

- `Field`，字段，描述表单字段的控件类型、控件的配置、字段相关的数据验证规则以及渲染表单时需要的描述信息（如字段名、帮助信息等），映射成模型类中的属性（`attribute`）
- `Group`，组，物理上的字段的容器，描述渲染表单时需要的描述信息、容器级别的验证规则（如至少填写一个字段），映射成模型类，组是树形结构
- `Form`，表单，描述表单的描述信息和根组（root `Group`），这个模型是可选的

三种模型的关系为：

- `Group` has many `Field`s, `Field` belongs to a `Group`
- `Group` has many `Group`s, `Group` may belongs to a `Group`
- `Form` has one `Group`

### 表单定义转化成模型类

利用了 Ruby 的两个方法：

- `Class.new`
- `class_eval`

首先定义基类（示意）：

```ruby
class VirtualForm < DuckRecord::Base
  class << self
    # 组是模式性很强的，可以通过提出“变体”概念来避免重复的定义信息
    attr_accessor :variant
    
    # 设置 Active Model 的模型名字
    def model_name=(name)
      @_model_name = ActiveModel::Name.new(self, nil, name.classify)
    end

    # 存储视图渲染时需要的信息，比如说组的标题（如果需要）
    def options
      @options ||= {}
    end

    # 存储视图渲染属性时需要的信息
    def attribute_metadata
      @attribute_input_metadata ||= {}
    end

    # 存储视图渲染时的顺序和渲染策略，键为字段名，值为类型（是`Field`还是`Group`）
    # 由于 子groups（即嵌套模型）也需要渲染，所以必须存在这个属性
    # 这个属性可以用来控制渲染顺序
    def fields
      @fields ||= {}
    end
  end
end
```

算法步骤：

略，见 `app/controllers/companies/forms/previews_controller.rb#build_form_model`

### 模型类渲染

略，见 `app/views/companies/forms/previews/_form.erb`

## 一些已知情况的处理方式

### 控件类型的定义和扩展，表单设计器

模仿 `ActiveModel::Type` 的设计

控件包含存储时的数据类型、特有的数据验证、渲染用的视图文件等信息，这些需要并且只能以代码的形式实现（控件类），并注册到一个字典中。

控件类负责根据上下文信息渲染字段。

在表单模型生成算法里，根据表单字段定义的控件类型的取值，去寻找（`lookup`）对应的控件描述类。

表单设计器应当获取所有注册的控件，渲染设计器的工具箱里的插入控件按钮，由控件类完成。

### `select` 或类似的选择类型控件的可选项的数据源

对于系统资源，模仿 `ActiveModel::Type` 的设计，封装数据源类，并提供注册表，数据源类负责根据上下文信息来获取实际的数据。

在表单字段定义（Field）的控件配置里存储系统资源的标识符，以便需要使用时寻找（`lookup`）。

对于固定取值，直接将可能的取值项放入表单字段定义（Field）的控件配置即可。

### 表单的访问控制

访问控制有三种类型：可编辑（默认）、只读、隐藏

只读对应模型的 `attr_readonly` 声明
隐藏可以理解为禁止生成字段对应的模型属性

可以扩展表单定义转化成模型类的算法，允许传入 `overrides` 参数（字典，键为字段的标识符，值为覆盖用的配置），根据 `Field` 的记录结合 `overrides[field]` 的结果来生成

禁用或者增加验证同理

### 表单的字段渲染顺序控制

由于 Ruby 的字典有序，所以调整 `VirtualForm#fields` 的键的顺序即可，可以为 `Group` 增加 `order` 字段，存储字段（的标识）的顺序

### 表单数据处理

见 `app/models/virtual_form.rb#to_h`实现 `to_h` 方法，允许表单模型导出结构化的 `Hash`，用于后续处理或储存


