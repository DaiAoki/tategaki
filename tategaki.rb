#!/bin/sh
exec ruby -S -x "$0" ${@+"$@"}
#!ruby

require "pry"

##### Function - start #####
def create_file_array(file)
  abort('Error: No such a file!') unless File.exist?(file)
  array = []
  File.open(file, 'r:utf-8') do |f|
    f.each_line do |line|
      array << line.chomp
    end
  end
  array
end

def to_tategaki(yoko)
  abort('Error: Empty file!') if yoko.empty?
  max_length = yoko.max_by{|y| y.size}.length

  temp = yoko
  array = Array.new(max_length).map{''}

  max_length.times do |i|
    temp.each do |t|
      s = t.empty? ? '　' : t.slice!(0)
      array[i].insert(0, s)
    end
    array[i] << "\n"
  end
  array
end

def nf_name(file)
  fb_name = File.basename(file, '.*')
  fe_name = File.extname(file)
  abort('Error: Permitted extension is .txt and .text!') unless %w(.txt .text).include?(fe_name)
  fb_name + '_yoko' + fe_name
end
##### Function - end #####



##### Process - start #####
puts 'please enter your file name you wanna convert. (Current directory files below.)'
puts `ls`
print 'filename: '
f_name = gets.chomp

yoko_array = create_file_array(f_name)
tate_array = to_tategaki(yoko_array)

cf_name = nf_name(f_name)
File.open(cf_name, 'w') do |f|
  tate_array.each do |tate|
    f.puts tate
  end
end

p "Success: The converted file name is #{cf_name}."
##### Process - end #####
