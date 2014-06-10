require 'dm/string_extend'

class String
  include StringExtend
end

describe "StringExtend" do
  describe '应该返回 li 标签的值' do
    subject do
      %{<li title="&nbsp;银饰">&nbsp;\
材&nbsp;质&nbsp;:&nbsp\
;银饰</li>}
    end

    it "应该返回被 li 标签包含的字符串内容." do
      expected = %{&nbsp;\
材&nbsp;质&nbsp;:&nbsp\
;银饰}
      subject.li_tag_value.must_equal expected
    end
  end

  describe "应该返回 li 标签的值." do
    subject { %{<li title="JAWBONE up2">产品名称：JAWBONE up2</li> <li title="abc">产品内容：物品</li>} }

    it "应该返回第一个标签中的内容." do
      expected = %{产品名称：JAWBONE up2}
      subject.li_tag_value.must_equal expected
    end
  end

  describe '应该返回 : 前后被处理后的键值对字符串.' do
    describe '#1' do
      subject do
        %{&nbsp;\
材&nbsp;质&nbsp;:&nbsp\
;银饰}
      end

      it "should return expected." do
        expected='材 质:银饰'
        subject.get_hash_pair.must_equal expected, '.'
      end
    end

    describe '#2' do
      subject do
        "银饰分类:&nbsp;千足&银"
      end

      it "should 可以处理 gsub 不成功的情形." do
        expected = '银饰分类:千足&银'
        subject.get_hash_pair.must_equal expected, '.'
      end
    end
  end

  describe '应该将键值对字符串转化为一个数组' do
    describe "如果字符串使用英文的 :" do
      subject { '材质:&#38134;&#39280;' }
      it "返回期望的哈希." do
        expected = ['产品参数.材质', '银饰']
        subject.colon_string_to_array.must_equal expected
      end
    end
    describe "如果字符串使用中文的 ：" do
      subject { '材质：银饰' }
      it "应该也返回期望的哈希" do
        expected = ['产品参数.材质', '银饰']
        subject.colon_string_to_array.must_equal expected
      end
    end
  end

  describe '应该可以处理多行字符, 并收集到一个哈希数组中.' do
    subject do
      <<-TEXT
# <ul id="J_AttrUL">
        <li title="&nbsp;银饰">&nbsp;材&nbsp;质&nbsp;:&nbsp;银饰</li>
        <li title="&nbsp;千足银">银饰分类:&nbsp;千足&银</li>
        <li id="J_attrBrandName" title="&nbsp;Danye">品牌:&nbsp;Danye</li>
        <li title="&nbsp;其它形状/图案">形状/图案:&nbsp;其它形状/图案</li>
        <li title="&nbsp;民族风">风格:&nbsp;民族风</li>
        <li title="&nbsp;女">适用人群:&nbsp;&#22899;</li>
        <li title="&nbsp;现货">是否现货:&nbsp;现货</li>
        <li title="&nbsp;未镶嵌">

是否镶嵌:&nbsp;未镶嵌</li>
<li id="J_attrBrandName" title="&nbsp;EBAYN/&#20234;&#36125;&#23433;">品牌1:&nbsp;EBAYN/&#20234;&#36125;&#23433;</li>
        <li title="&nbsp;全新">成色:&nbsp;全新</li>
        <li title="&nbsp;金黄色">颜色分类:&nbsp;金黄色</li>
        <li title="&nbsp;401-500元">
价格区间:&nbsp;401-500元
</li>
        <li title="&nbsp;网聚特色">新奇特:&nbsp;网聚&nbsp;特&nbsp;色</li>
        <li title="&nbsp;2004045-02">货号:&nbsp;2004045-02</li>
</ul>

    TEXT
    end
    it "should return expected." do
      expected = [
                  [ '产品参数.材 质', '银饰'],
                  ['产品参数.银饰分类', '千足&银'],
                  ['产品参数.品牌', 'Danye'],
                  ['产品参数.形状/图案', '其它形状/图案'],
                  ['产品参数.风格',  '民族风'],
                  ['产品参数.适用人群', '女'],
                  ['产品参数.是否现货', '现货'],
                  ['产品参数.是否镶嵌', '未镶嵌'],
                  ["产品参数.品牌1", "EBAYN/伊贝安"],
                  ['产品参数.成色', '全新'],
                  ['产品参数.颜色分类', '金黄色'],
                  ['产品参数.价格区间', '401-500元'],
                  ['产品参数.新奇特', '网聚 特 色'],
                  ['产品参数.货号', '2004045-02']
                 ]
      subject.tmall_cpcs.must_equal expected
    end
  end

  describe "#convert_html_entity_to_character" do
    describe "当不包含实体字符时" do
      subject { "401-500元" }
      it "应该返回同样的值" do
        expected = "401-500元"
        subject.convert_html_entity_to_character.must_equal expected
      end
    end

    describe "当包含实体字符时." do
      subject { "&#20854;&#20182;: 401-500元" }
      it "应该将实体字符替换为文字." do
        expected = '其他: 401-500元'
        subject.convert_html_entity_to_character.must_equal expected
      end
    end

    describe "当包含标题时" do
      subject { "产品参数.&#20854;&#20182;" }
      it "应该将实体替换为文字." do
        expected = '产品参数.其他'
        subject.convert_html_entity_to_character.must_equal expected
      end
    end
  end
end
