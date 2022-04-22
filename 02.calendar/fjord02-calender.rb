#!/usr/bin/env ruby

#optparseの設定をする
#opt.on('-m') {|v| month = v }のような形で代入ができないので気をつける
require 'optparse'
opt = OptionParser.new

params = {}

opt.on('-m') {|v| params[:a] = v }
opt.on('-y') {|v| params[:b] = v }


opt.parse!(ARGV)

#requireでdateを呼び出す

require "date"


#trueかnil判定用
month = params[:a]
year = params[:b]



#オプションに引数が渡されていない場合を考えて、それぞれ場合分けする
#2^2通りなので４つ
#paramsはtrueかnilを出力する
#データを持っているのはARGVのほうなので注意
#数字にする必要があるのでto_i
todayDate = Date.today
if month == nil && year == nil
  x = todayDate.month.to_i
  y = todayDate.year.to_i
elsif month == nil
  x = todayDate.month.to_i
  y = ARGV[0].to_i
elsif year == nil
  x = ARGV[0].to_i
  y = todayDate.year.to_i
else
  x = ARGV[0].to_i
  y = ARGV[1].to_i
end


#もし場合分けせずにARGVを使うと、-mだけ、-yだけ、しかオプションがない場合、ARGV[1]がなくなってしまう。
#全くオプションがない場合も考える

#xで月を、yで年を受け取る


#paramsではなくARGVを使う必要があるので注意






#月初日を調べる
startMonthDate = Date.new(y, x, 1)

#月末日を調べる
endMonthDate = Date.new(y, x, -1)


#月末日までの日数だけを抽出する
#文字列に変換してから３番めと4番目を取得して、数字に戻しています
stringTestdate = endMonthDate.strftime('%x')
stringNissuu = stringTestdate[3..4]
nissuu = stringNissuu.to_i


#カレンダーの上部の表示を出力する
puts "       #{x}月 #{y}"
puts " 日 月 火 水 木 金 土"


#配列を作る
numbers = []
for i in 1..nissuu do
  numbers.push(i)
end


# 空白を先頭に入れる
# 月初日に合わせて空白を入れる
# 空白の大きさは、rjustの大きさに合わせる（半角３つぶん）
# %xではなくて%wを使うので注意！！
print "   "*startMonthDate.strftime('%w').to_i


#calendarを並べる。７つごとに改行。
#rjustを使って右寄せ
#改行の\nにはシングルコーテーションはダメ！（ダブルコーテーションを使う）
count = 1
numbers.each do |number|
  print number.to_s.rjust(3)
  if (count + startMonthDate.strftime('%w').to_i) % 7 == 0
    print "\n"
  end
  count += 1
end



