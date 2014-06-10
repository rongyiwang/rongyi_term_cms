#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require_relative '../../../app/models/concerns/extension_field_extend'

class ExtensionFieldExtendSubject
  include ExtensionFieldExtend
end

describe ExtensionFieldExtendSubject do
  subject { ExtensionFieldExtendSubject.new }

  describe "#extension_fields_hash 应该返回满足条件的哈希表." do
    describe "当不提供条件参数时" do
      it "应该返回 read_attribute(:extension_fields) 对应的哈希." do
        def subject.read_attribute(expension_field)
          [["#来源", "http://detail.tmall.com"], ["*隐藏", "被隐藏的内容"], ["普通字段", "普通内容"]]
        end
        expected = {"#来源" => "http://detail.tmall.com", "*隐藏" => "被隐藏的内容", "普通字段" => "普通内容"}
        subject.extension_fields_hash.must_equal expected, '.'
      end
    end

    describe "当提供一个 only: ['#' '*'] 参数时" do
      it '应该仅仅返回 首字母匹配的 #, * 的结果' do
        def subject.read_attribute(expansion_field)
          [["#.网址", "http://detail.tmall.com"], ["*隐藏", "被隐藏的内容"], ["普通字段", "普通内容"]]
        end
        expected = {"网址" => "http://detail.tmall.com", "隐藏" => "被隐藏的内容"}
        subject.extension_fields_hash(only: ["#", "*"]).to_s.must_equal expected
      end
    end

    describe "当提供一个 only: ['来源', '产品参数'] 时" do
      it "返回匹配的结果, 并移除指定字符串." do
        def subject.read_attribute(expansion_field)
          [["来源.天猫", "http://detail.tmall.com"], ["产品参数品牌", "被隐藏的内容"], ["普通字段", "普通内容"]]
        end
        expected = {"天猫"=>"http://detail.tmall.com", "品牌"=>"被隐藏的内容"}
        subject.extension_fields_hash(only: [:来源, :产品参数]).to_s.must_equal expected
      end
    end

    describe "当提供一个 except: '#' 参数时" do
      it '应该仅仅返回不含 # 的哈希' do
        def subject.read_attribute(expension_field)
          [["#来源", "http://detail.tmall.com"], ["*隐藏", "被隐藏的内容"], ["普通字段", "普通内容"]]
        end
        expected = {"*隐藏" => "被隐藏的内容", "普通字段" => "普通内容"}
        subject.extension_fields_hash(except: "#").must_equal expected, '.'
      end
    end
  end

  describe "#with_prefix" do
    describe "当提供一个 only: ['来源', '产品参数']" do
      it "返回匹配的结果, 但保留 prefix." do
        def subject.read_attribute(expansion_field)
          [["来源.天猫", "http://detail.tmall.com"], ["产品参数.品牌", "被隐藏的内容"], ["普通字段", "普通内容"]]
        end
        expected = {"来源.天猫"=>"http://detail.tmall.com", "产品参数.品牌"=>"被隐藏的内容"}
        subject.extension_fields_hash(only: [:来源, :产品参数]).with_prefix.must_equal expected
      end
    end
  end

  describe "#extension_field" do
    describe "当指定的 name 在字段数组中存在时" do
      it "应该根据需要的 name 来获取对应的 value." do
        def subject.extension_fields
          [["name1", "value1"], ["name2", "value2"], ["name3", "value3"]]
        end
        subject.extension_field("name1").must_equal "value1", '.'
      end
    end

    describe "当指定的 name 在字段数组中不存在时" do
      it "应该仅仅返回 nil" do
        def subject.extension_fields
          [["name1", "value1"], ["name2", "value2"], ["name3", "value3"]]
        end
        subject.extension_field("name4").must_be_nil '.'
      end
    end
  end

  describe "#extension_fields=" do
    describe "当 params 为空时" do
      it "应该执行 self[:extension_fields] = [], 并直接返回." do
        def subject.[]=(arg1, arg2)
          if arg1 == :extension_fields and arg2 == []
            print "OK"
          end
        end
        -> { subject.extension_fields = nil }.must_output "OK"
        # subject.extension_fields=(nil).must_be_nil
      end
    end

    describe "当 params 不为空时" do
      it "应该执行 self[:extension_fields] = " do
        skip
        "这个测试比较难搞, 以后再说."
      end
    end
  end
end
