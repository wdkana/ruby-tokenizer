require 'erb'
require 'net/http'
require 'json'
require 'io/console'
require './env.rb'

erbenv = ERB.new %q{<%= SERVICE %><%= t %>}

puts "🐱 TOKEN GENERATOR 🐱"

print "username: "
u = gets.chomp

print "password: (tidak akan muncul ke console) "
p = STDIN.noecho(&:gets).chomp

def byte_calc(u, p)
    return u.chars + p.chars
end

def tokenizer(d)
    _t = 0
    for i in d
        _t += i.ord
    end
    return _t
end

t = tokenizer(byte_calc(u, p))
r = Net::HTTP.get(URI(erbenv.result))
tr = JSON.parse(r)

puts "\ntoken: #{tr[0]}"
