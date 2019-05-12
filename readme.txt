Tyler Kugler
CMPU 377
Final Assignment

========================================================================================

- smores
    - choc-kid.rb
    - graham-kid.rb
    - init-ts.rb
    - last-kid.rb
    - marsh-kid.rb
    - server.rb

- water 
    - water_molecule_process.go

========================================================================================

(1) The S'mores Problem (Ruby)

I definitely felt like this was the harder problem of the two! I still struggled
with the tuples = semaphores mentality, but I think I got it working correctly :)
I set it up so that the last kid, who isn't eating, always searches for the 
ingredients with the value 0 associated with them. Then, I gave each of the other 
kids their own special value. When the last kid randomly chooses 1, the marshmallow
kid will receive their graham crackers and chocolate. I ensure that that the other
two don't snatch it up (and cause deadlock in the event that the two ingredients 
being sent end up with different kids) by forcing them to only take in their 
associated number (1 = marshmallow, 2 = graham cracker, 3 = chocolate, 0 = last kid).

After that, I just needed to track how many s'mores each of them were able to eat. 
Weirdly, when I initialized a variable in the last-kid file, it wasn't incrementing
in my printouts. I decided that the simplest solution would be to fully embrace
tuple space by sending it through TS each time I incremented to make sure the 
incremented value was saved. This did the trick :)

========================================================================================

(2) The Water Molecule Problem (Go)

I remember doing a similar assignment in OS, but it was definitely interesting to
approach this problem in Go with a different concurrency method. I really enjoy 
using the select mechanism in Go -- it's super clean. All in all, I don't have too
much to say about this problem. The trickiest part of this problem is hooking up the
channels correctly in the different functions, but even that was much simpler than the
sort-pump.go assignment. I also wrangled with my method on preventing main() from 
ending too soon and halting all of the processes. I originally used a kill signal
like in sort-pump.go, but I eliminated that later by just calling the function 
waterlog() instead of calling it as a goroutine. That solved my problem in a much 
cleaner way. :) 


Thank you for a great semester. Have a good summer and good luck next fall!