require 'rinda/rinda'
 
#
# cs377
# spring 2019
# The S'mores Problem
# Tyler Kugler
# last-kid.rb
#
#

URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI))

while true
    #ts.take( ["last-kids-selection", 0] )
    
    randomchoice = rand(3) + 1
    puts "randomly chose #{randomchoice}"

    case randomchoice
    when 1
        puts "==> marsh-kid gets to eat!"
        ts.take( ["graham-crackers", 0] )
        ts.take( ["chocolate", 0] )
        puts "about to send"
        ts.write( ["graham-crackers", 1] )
        ts.write( ["chocolate", 1] )
        puts "sent"

        
    when 2
        puts "==> graham-kid gets to eat!"
        ts.take( ["chocolate", 0] )
        ts.take( ["marshmallows", 0] )
        puts "about to send"
        ts.write( ["chocolate", 2] )
        ts.write( ["marshmallows", 2] )
        puts "sent"


    when 3
        puts "==> choc-kid gets to eat!"
        ts.take( ["marshmallows", 0] )
        ts.take( ["graham-crackers", 0] )
        puts "about to send"
        ts.write( ["marshmallows", 3] )
        ts.write( ["graham-crackers", 3] )
        puts "sent"

    end
end
