require 'rinda/rinda'
 
#
# cs377
# spring 2019
# The S'mores Problem
# Tyler Kugler
# last-kid.rb
#

URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI))

# The last kid has a stomach ache and doesn't want any s'mores. 
# They will randomly choose a kid at the top of each loop. If chosen,
# they'll take the two ingredients not held by that kid and give them to 
# the chosen one. After the kid has made their s'more, the last kid will
# take them back. 

while true

    # randomly choose the next kid who gets to eat
    randomchoice = rand(3) + 1

    case randomchoice
    when 1
        puts "Marshmallow kid gets to eat a s'more!"

        # Take graham crackers and chocolate from the other two
        ts.take( ["graham-crackers", 0] )
        ts.take( ["chocolate", 0] )

        # Give them to the chosen kid
        ts.write( ["graham-crackers", 1] )
        ts.write( ["chocolate", 1] )
        
        tag, marsh = ts.take( ["m_count", Numeric] )
        marsh = marsh + 1
        ts.write( ["m_count", marsh] )
        print "They've eaten #{marsh} s'mores so far.\n\n"
        
    when 2
        puts "Graham Cracker kid gets to eat a s'more!"

        # Take chocolate and marshmallows from the other two
        ts.take( ["chocolate", 0] )
        ts.take( ["marshmallows", 0] )

        # Give them to the chosen kid
        ts.write( ["chocolate", 2] )
        ts.write( ["marshmallows", 2] )

        tag, graham = ts.take( ["g_count", Numeric] )
        graham = graham + 1
        ts.write( ["g_count", graham] )
        puts "They've eaten #{graham} s'mores so far.\n\n"


    when 3
        puts "Chocolate kid gets to eat a s'more!"

        # Take marshmallows and graham crackers from the other two
        ts.take( ["marshmallows", 0] )
        ts.take( ["graham-crackers", 0] )

        # Give them to the chosen kid
        ts.write( ["marshmallows", 3] )
        ts.write( ["graham-crackers", 3] )
        
        tag, choc = ts.take( ["c_count", Numeric] )
        choc = choc + 1
        ts.write( ["c_count", choc] )
        puts "They've eaten #{choc} s'mores so far.\n\n"

    end
end
