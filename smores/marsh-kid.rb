require 'rinda/rinda'
 
#
# cs377
# spring 2019
# The S'mores Problem
# Tyler Kugler
# marsh-kid.rb
#

URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI))

# At the top of every loop, the marshmallow kid will wait until 
# they can take the chocolate and graham crackers from the 
# last kid. Once successful, they're assemble and eat their 
# s'more. Then they'll hand back every ingredient.

while true
    puts "Marshmallow kid is waiting for the graham crackers and chocolate..."

    ts.take( ["graham-crackers", 1] )
    ts.take( ["chocolate", 1] )

    puts "Marshmallow kid has the graham crackers and chocolate! They're now assembling and eating -- YUM!"

    # Assembling and eating s'more
    sleep(0.5)

    ts.write( ["graham-crackers", 0] )
    ts.write( ["chocolate", 0] )
    ts.write( ["marshmallows", 0] )

    puts "Marshmallow kid is handing back all of the ingredients.\n\n"

end